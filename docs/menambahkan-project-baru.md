# Menambahkan Project Baru ke QA Automation

Dokumen ini menjelaskan cara repo ini dipakai sebagai rumah bersama untuk otomasi banyak project.

## Istilahnya apa

Pola ini disebut **QA automation monorepo**: satu repository untuk banyak suite otomasi, dengan inti (core) yang dipakai bersama dan satu folder per aplikasi.

Kalau di dalamnya ada template, konfigurasi standar, dan cara onboarding yang seragam, orang menyebutnya **internal QA platform** atau **test automation platform**. Bedanya cuma tingkat kematangan: monorepo itu strukturnya, platform itu layanannya.

Yang bukan: bukan polyrepo (satu repo per aplikasi), dan bukan unit test (itu tetap di repo masing-masing aplikasi).

## Struktur target

    agents-qa-automation/
      core/                     keyword, driver, dan util yang dipakai semua project
      projects/
        saucedemo/              suite yang sekarang ada di repo ini
        go-chat/                suite untuk aplikasi go-chat
        atelier/                suite untuk aplikasi atelier
      templates/project/        salinan awal untuk project baru
      docs/                     panduan dan peta
      .github/workflows/        CI, dijalankan per project
      requirements.txt

Aturan pemisahan: folder core tidak boleh tahu nama project. Folder projects/<nama> boleh memakai core, tetapi tidak boleh memakai isi project lain.

## Yang cocok dan yang tidak cocok masuk sini

Cocok: end-to-end UI, smoke test, regression lintas halaman, test API ringan yang mendukung alur UI, dan test data setup.

Tidak cocok: unit test komponen, benchmark performa berat, dan test yang butuh database internal aplikasi. Itu tetap di repo aplikasinya.

## Checklist menambah project

1. Buat folder dari templates/project menjadi projects/<nama>, huruf kecil dan tanpa spasi.
2. Isi README.md di folder itu: URL staging dan produksi, akun QA, lima alur kritis, risiko utama, dan pemilik.
3. Set BASE_URL dan kredensial lewat environment variable atau GitHub Secrets. Jangan pernah menulis password di repo.
4. Petakan tiga halaman pertama ke page object. Urutan locator: data-test lalu id stabil, baru CSS berbasis atribut. XPath absolut dilarang.
5. Tulis lima smoke test untuk alur yang paling mahal kalau rusak. Jalankan lokal tiga kali berturut sebelum dianggap stabil.
6. Daftarkan project di matrix CI dan filter path, supaya perubahan di project lain tidak menjalankan suite ini.
7. Review terakhir: tidak ada Sleep untuk menunggu, assertion memeriksa hasil bisnis, dan hasil run tersimpan sebagai artifact.

## Contoh perintah

    python -m robot --outputdir results/saucedemo projects/saucedemo/tests
    python -m robot --outputdir results/go-chat --include smoke projects/go-chat/tests
    python -m robot --outputdir results --include regression projects

## Contoh matrix CI

    strategy:
      fail-fast: false
      matrix:
        project: [saucedemo, go-chat, atelier]
    steps:
      - run: python -m robot --outputdir results/${{ matrix.project }} projects/${{ matrix.project }}/tests

Tambahkan filter path agar suite hanya jalan saat foldernya berubah.

## Konvensi yang menjaga repo tetap sehat

- Satu page object untuk satu halaman, di dalam folder project-nya.
- Nama keyword memakai kata kerja dan objek: Add Product To Cart, bukan Klik Tombol 2.
- Setiap test punya tag TC-... dan tag jenis: smoke, regression, negative.
- Satu test tidak boleh bergantung pada test lain. Buka browser baru atau bersihkan state di teardown.
- Konfigurasi per project berada di projects/<nama>/variables, bukan di core.

## Definition of Done suite baru

- Lima smoke test lulus tiga kali berturut di lokal.
- CI hijau pada pull request pertama.
- Waktu jalan smoke di bawah lima menit.
- README berisi cara menjalankan dan daftar akun uji.
- Tidak ada kredensial, IP internal, atau data pribadi di kode.

## Anti-pattern

- Satu file test berisi semua halaman dan semua project.
- Copy-paste page object antar project lalu mengubah sebagian, sehingga dua sumber kebenaran.
- Menjalankan seluruh project di setiap commit, sampai CI lambat dan orang berhenti peduli.
- Mengandalkan hasil generate otomatis tanpa review manusia. Locator yang dihasilkan tanpa dicek adalah sumber flaky paling cepat.
- Menyimpan laporan hasil di repo. Simpan sebagai artifact.

## Soal agent yang membaca tampilan

Agent bisa membantu memetakan halaman ke page object, tetapi hasilnya harus dianggap draf. Tiga aturan:

1. Minta aplikasi punya atribut data-test dulu. Tanpa itu, locator cepat rusak dan agent akan menebak.
2. Review setiap locator dan assertion sebelum masuk main.
3. Ukur cakupan alur bisnis, bukan jumlah baris kode yang dihasilkan.

