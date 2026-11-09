# Automation Guide - Robot Framework + SeleniumLibrary

Repo: qa-note. Target: https://www.saucedemo.com. Framework: Robot Framework 7 dengan SeleniumLibrary 6.

## Setup

    python -m venv .venv
    .venv\Scripts\activate
    pip install -r requirements.txt

Selenium Manager mengunduh driver yang cocok otomatis. Jangan memasang webdriver-manager bersamaan.

## Menjalankan

    python -m robot --outputdir results tests
    python -m robot --outputdir results --include smoke tests
    python -m robot --outputdir results --include regression tests

Di PowerShell, untuk melihat browser: $env:HEADLESS="false".

## Struktur

- tests/smoke: alur kritis, target di bawah lima menit.
- tests/regression: cakupan lebih luas, termasuk kasus negatif.
- resources/pages: satu file per halaman, berisi locator dan keyword aksi.
- resources/common.resource: setup browser, klik, tunggu halaman siap, screenshot.
- variables: konfigurasi environment dan data uji.
- results: output Robot, tidak di-commit.

## Konvensi

- Test case hanya berisi langkah bisnis dan assertion.
- Keyword memakai kata kerja plus objek: Add Product To Cart, Verify Order Completed.
- Locator memakai data-test. XPath hanya dipakai untuk mencari kartu produk berdasarkan nama.
- Setiap test membawa tag TC-... yang sama dengan docs/test-cases.md.
- Satu browser baru per test, sehingga cookie dan keranjang tidak bocor antar test.

## Menunggu tanpa Sleep

Gunakan Wait Until Element Is Visible, Wait Until Location Contains, atau Wait Until Keyword Succeeds dengan kondisi yang bisa diamati. Sleep hanya menambah waktu dan menyembunyikan flaky.

## Catatan klik DOM

Di environment headless yang dipakai saat repo ini dibuat, klik pointer native tidak memicu handler React untuk tombol add, remove, dan beberapa navigasi. Karena itu keyword Click Test Id dan Click Product Button memanggil HTMLElement.click(). Handler aplikasi tetap dijalankan, jadi bug logika tetap menyebabkan test gagal. Kalau di mesin atau CI kamu klik native bekerja, ganti pemanggilan itu dengan Click Element biasa.

## CI

.github/workflows/robot.yml menjalankan suite headless pada push ke main dan pull request, lalu mengunggah results sebagai artifact selama tujuh hari.

## Penanganan test flaky

Test yang gagal lulus tanpa perubahan kode diberi label flaky di Jira, dicatat frekuensinya, lalu diperbaiki dalam sprint yang sama. Jangan menaikkan timeout sebagai satu-satunya solusi; cari kondisi yang seharusnya ditunggu.

## Menambah test

1. Tambah keyword di page object terkait.
2. Tulis test di tests/smoke atau tests/regression dengan tag TC-....
3. Jalankan file tunggal, lalu seluruh suite dua kali untuk memastikan stabil.
4. Buka pull request dengan tautan ke story Jira.

