# QA Learning Lab

Repo latihan QA end-to-end: manual testing, Scrum dua minggu, Jira, Confluence, lalu otomasi dengan Robot Framework + SeleniumLibrary.

Target aplikasi: [SauceDemo](https://www.saucedemo.com) — situs demo e-commerce yang memang dibuat untuk latihan testing. Tidak ada data atau transaksi nyata.

## Isi repo

| Folder | Isi |
| --- | --- |
| tests/ | Skenario test, dipisah smoke dan regression |
| resources/ | Keyword bersama dan page object per halaman |
| variables/ | Konfigurasi environment dan data uji |
| docs/ | Test plan dan katalog test case manual |
| jira/ | Backlog siap impor dan panduan setup Jira |
| confluence/ | Draf halaman Confluence |

## Prasyarat

- Python 3.9 atau lebih baru (diuji di 3.10 dan 3.12)
- Google Chrome (Selenium Manager mengunduh driver otomatis)
- Git

## Setup

    python -m venv .venv
    .venv\Scripts\activate
    pip install -r requirements.txt

Di macOS atau Linux, aktivasi memakai:

    source .venv/bin/activate

## Menjalankan test

Semua test:

    python -m robot --outputdir results tests

Hanya smoke:

    python -m robot --outputdir results --include smoke tests

Hanya regression:

    python -m robot --outputdir results --include regression tests

Satu file:

    python -m robot --outputdir results tests/smoke/checkout.robot

Melihat browser (tanpa headless):

    set HEADLESS=false
    python -m robot --outputdir results --include smoke tests

PowerShell memakai:

    $env:HEADLESS="false"

Hasil ada di results/: log.html, report.html, output.xml, dan screenshot bila gagal.

## Struktur dan konvensi

- Satu file page object untuk satu halaman, berisi locator dan keyword aksi.
- Test case hanya berisi langkah bisnis dan assertion, tanpa detail DOM.
- Locator memakai atribut data-test milik SauceDemo, bukan XPath absolut.
- Keyword memakai pola kata kerja + objek: Add Product To Cart, Verify Order Completed.
- Setiap test punya tag TC-... yang sama dengan ID di docs/test-cases.md, sehingga manual dan otomasi bisa dilacak.
- Satu browser baru per test. Lebih lambat sedikit, tetapi test tidak saling mewarisi cookie atau isi keranjang.
- Tidak ada Sleep untuk menunggu elemen. Semua memakai Wait Until dan retry berbasis perubahan URL.

## Kenapa ada retry klik

SauceDemo dibangun dengan React. Pada koneksi lambat, tombol bisa sudah terlihat tetapi handler klik belum terpasang, sehingga klik pertama tidak berefek. Keyword Click And Wait For Location mengulang klik sampai URL berubah, dengan batas waktu. Ini menutupi masalah nyata kalau halaman benar-benar rusak, karena test tetap gagal setelah 15 detik.

Selain itu, di Chrome headless pada mesin ini klik pointer native tidak memicu handler React untuk tombol add, remove, dan beberapa navigasi. Karena itu klik dilakukan lewat DOM (Click Test Id dan Click Product Button). Handler aplikasi tetap dijalankan, jadi bug logika tetap membuat test gagal. Kalau di mesin atau CI kamu klik native bekerja, ganti pemanggilan itu dengan Click Element biasa.

## Menambah test baru

1. Tambahkan keyword aksi di page object terkait, misalnya resources/pages/cart_page.resource.
2. Tulis test case di tests/smoke atau tests/regression.
3. Beri tag smoke atau regression, plus tag TC-... yang merujuk ke docs/test-cases.md.
4. Jalankan satu file dulu, lalu seluruh suite.

Contoh bentuk test:

    Nama Perilaku Yang Diuji
        [Tags]    regression    cart    TC-CART-004
        Login As Standard User
        Add Product To Cart    Sauce Labs Backpack
        Open Cart
        Verify Cart Contains Product    Sauce Labs Backpack

## CI

.github/workflows/robot.yml menjalankan seluruh suite headless di setiap push ke main dan setiap pull request. Hasil run diunggah sebagai artifact robot-results selama tujuh hari.

Untuk repo publik, jangan menaruh kredensial pribadi di variables/. Pakai environment variable atau GitHub Secrets.

## Hubungan dengan Jira dan Confluence

- jira/backlog.csv berisi epic, story, task, dan bug contoh untuk dua sprint.
- jira/SETUP.md berisi langkah membuat project Scrum dua minggu, kolom board, field, filter, dan dashboard.
- docs/test-cases.md adalah sumber ID test case yang dipakai sebagai tag di repo ini.
- confluence/ berisi struktur dokumentasi QA yang bisa ditempel ke Confluence.

## Troubleshooting

Browser tidak terbuka di CI: pastikan HEADLESS=true dan Chrome tersedia di runner.

Error driver: hapus folder cache Selenium Manager, lalu jalankan ulang. Jangan memasang webdriver-manager bersamaan.

Test gagal hanya di CI: buka artifact robot-results, lihat log.html dan FAILED-*.png. Bandingkan ukuran jendela; CI memakai 1440x900.

Koneksi lambat: naikkan DEFAULT_TIMEOUT, misalnya 20s, lewat environment variable.

