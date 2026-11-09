# Test Plan - Sprint 1 (SauceDemo)

Pemilik: QA Learning Lab. Terakhir diperbarui: 9 November 2026. Status: aktif.

## Tujuan

Membuktikan alur belanja utama SauceDemo berjalan sesuai acceptance criteria, sekaligus membangun kebiasaan kerja QA: risiko dulu, test case yang bisa diulang, bukti sebelum rilis.

Target keluar sprint: 100 persen acceptance criteria prioritas tinggi terverifikasi, tidak ada bug S1 atau S2 terbuka saat sign-off, dan smoke test otomatis lulus di CI setiap push.

## Scope

Masuk pengujian: login (valid, user terkunci, password salah, field kosong), katalog (daftar produk, sorting, detail), keranjang (tambah, hapus, badge, navigasi), checkout (form, validasi field wajib, ringkasan, penyelesaian).

Di luar scope: pembayaran nyata, performance dan keamanan mendalam, aksesibilitas penuh.

## Environment dan data

- URL: https://www.saucedemo.com
- Browser: Chrome terbaru, viewport 1440x900, headless di CI.
- Akun: standard_user, locked_out_user, problem_user dengan password secret_sauce.
- Data checkout: QA Learner, 12345.
- Tidak ada data pribadi atau kredensial asli.

## Pendekatan berbasis risiko

| Area | Dampak | Kemungkinan rusak | Prioritas |
| --- | --- | --- | --- |
| Checkout | Tinggi (pendapatan) | Sedang | P1, tiap build |
| Login | Tinggi (akses) | Rendah | P1 |
| Keranjang | Sedang | Sedang | P2 |
| Sorting | Rendah | Tinggi | P3, kandidat otomasi |
| Kosmetik | Rendah | Rendah | P4, backlog |

Urutan eksekusi: smoke alur utama, area yang berubah, integrasi dan data, edge case, terakhir kosmetik.

## Jadwal 10 hari kerja

| Hari | Aktivitas | Artefak |
| --- | --- | --- |
| H-3 | Refinement, baca acceptance criteria | Risk list, catatan DoR |
| 1 | Planning, susun test plan | Dokumen ini |
| 2-3 | Desain test case dan data | docs/test-cases.md |
| 4-6 | Eksekusi manual dan otomasi awal | Test run, bug di Jira |
| 7 | Refinement sprint berikutnya | Catatan AC |
| 8 | Exploratory dan bug bash | Daftar defect |
| 9 | Regression, release candidate | Test summary, sign-off |
| 10 | Rilis, smoke produksi, retro | Laporan sprint |

## Entry dan exit criteria

Masuk: acceptance criteria bisa diuji, environment dan data tersedia, build punya nomor versi atau commit.

Keluar: semua test P1 dan P2 dieksekusi dengan hasil tercatat, smoke dan regression otomatis lulus, tidak ada bug S1 atau S2 terbuka, test summary dan sign-off ditulis.

## Deliverable

Katalog test case dengan ID stabil, bug report yang bisa direproduksi, suite Robot Framework yang jalan di lokal dan CI, dan test summary berisi risiko tersisa serta rekomendasi rilis.

## Risiko

| Risiko | Mitigasi |
| --- | --- |
| Situs demo berubah tanpa pemberitahuan | Locator berbasis data-test, review suite tiap sprint |
| Test flaky karena timing | Retry berbasis perubahan state, tanpa Sleep |
| Kredensial masuk repo | Hanya akun demo publik, konfigurasi lewat environment variable |
| Cakupan terlalu luas | Batasi ke alur belanja utama, tambah per sprint |

