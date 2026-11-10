# AI Workflow: Context-Driven Pipeline

Repo ini memakai **workflow berbasis konteks**, bukan autonomous agent. Agent tidak memilih target sendiri, tidak menjalankan loop tanpa henti, dan tidak menggabungkan pull request. Setiap perpindahan tahap punya gerbang review manusia.

## Mengapa model ini

- Input dibatasi: satu project, satu alur, satu set acceptance criteria.
- Output berbentuk artefak yang bisa dibaca: peta halaman, daftar locator, test case, kode.
- Biaya dan waktu bisa diprediksi karena tidak ada eksplorasi bebas.
- Kesalahan mudah dilacak: setiap tahap punya input dan output yang jelas.
- Hasil generate tetap dianggap draf sampai direview.

## Tahap pipeline

| Tahap | Input | Dikerjakan | Output | Gerbang |
| --- | --- | --- | --- | --- |
| 0. Konteks | URL, akun uji, alur kritis | Manusia | context/<project>/project.md | Lengkap dan disetujui |
| 1. Pilih target | Daftar alur | Manusia | Satu alur + AC | Target terkunci |
| 2. Recon | URL + DOM | Agent | Peta halaman + kandidat locator | Manusia menandai locator final |
| 3. Desain test | AC + risk list | Agent | Draf test case | Manusia menyetujui cakupan |
| 4. Generate kode | Locator + test case | Agent | Page object + test | Review kode |
| 5. Run lokal | Kode | Agent menjalankan | log.html + daftar kegagalan | Manusia memutuskan bug atau flaky |
| 6. CI dan laporan | Branch | Manusia | Pull request + artifact | Review dan merge manusia |

Tidak ada tahap yang otomatis melanjutkan ke tahap berikutnya tanpa persetujuan.

## Kontrak input per project

Setiap project punya satu folder konteks:

    context/<nama>/
      project.md      URL, environment, pemilik, stack
      flows.md        lima alur kritis dan acceptance criteria
      selectors.md    inventaris data-test yang sudah diverifikasi
      data.md         akun uji dan fixture, tanpa password

Agent hanya boleh bekerja dari isi folder ini. Kalau informasinya tidak ada, agent berhenti dan bertanya, bukan menebak.

## Aturan recon

- Sumber kebenaran locator adalah DOM dan accessibility tree, bukan screenshot.
- Urutan prioritas: data-test, id stabil, name, CSS berbasis atribut. XPath absolut dilarang.
- Setiap locator ditulis beserta nama halaman dan elemennya.
- Kalau elemen tidak punya penanda stabil, hasil recon berisi usulan menambah data-test di aplikasi, bukan tebakan.

## Aturan generate

- Satu page object per halaman, di dalam projects/<nama>/resources/pages.
- Test hanya berisi langkah bisnis dan assertion.
- Tidak ada Sleep untuk menunggu. Gunakan wait berbasis kondisi.
- Setiap test diberi tag TC-... dan jenisnya.
- Kode yang dihasilkan wajib lulus sekali jalan lokal sebelum diusulkan sebagai pull request.

## Yang sengaja tidak dilakukan

- Menemukan project baru sendiri.
- Mengubah kode aplikasi tanpa diminta.
- Menjalankan test berulang tanpa batas sampai hijau.
- Menggabungkan pull request.
- Menyimpan kredensial di repo atau di prompt.
- Mengklaim lulus tanpa log yang bisa diperiksa.

## Definition of done per tahap

- Recon: peta halaman dan locator final disetujui manusia.
- Desain test: cakupan sesuai AC, minimal satu kasus negatif.
- Generate: kode terbaca, tanpa duplikasi page object, tanpa locator ajaib.
- Run: hasil bisa direproduksi dua kali berturut.
- CI: artifact terunggah, durasi di bawah batas yang disepakati.

## Cara memulai satu siklus

1. Salin context/_template menjadi context/<project>.
2. Isi project.md dan flows.md. Ini pekerjaan manusia, bukan agent.
3. Jalankan recon untuk satu alur saja.
4. Review locator, kunci yang dipakai.
5. Minta draf test case, setujui cakupannya.
6. Baru generate kode.
7. Jalankan lokal, review hasil.
8. Buka pull request sendiri.

