# Test Strategy - QA Learning Lab

Pemilik: QA. Berikut berlaku untuk semua sprint pada aplikasi latihan SauceDemo.

## Tujuan mutu

Keputusan rilis diambil dari bukti, bukan perasaan. Untuk setiap rilis:

- 100 persen acceptance criteria P1 terverifikasi.
- Nol bug S1 atau S2 terbuka.
- Smoke test otomatis lulus di CI.

## Ruang lingkup

Masuk: alur login, katalog, keranjang, dan checkout pada browser desktop.

Keluar: pembayaran sungguhan, aplikasi mobile, performance berskala, dan audit keamanan penuh. Ketiganya masuk roadmap setelah baseline otomasi stabil.

## Pendekatan

Berbasis risiko. Dampak bisnis dikali kemungkinan rusak menentukan kedalaman uji.

| Area | Dampak | Kemungkinan | Perlakuan |
| --- | --- | --- | --- |
| Checkout | Tinggi | Sedang | Uji manual mendalam dan otomasi happy path |
| Login | Tinggi | Rendah | Smoke otomatis, cek negatif tiap sprint |
| Keranjang | Sedang | Sedang | Otomasi tambah, hapus, badge |
| Sorting | Rendah | Tinggi | Otomasi, murah dan cepat |
| Kosmetik | Rendah | Rendah | Eksplorasi berkala, tidak menahan rilis |

Piramida pengujian: banyak unit test di sisi developer, lapisan API di tengah, dan sedikit end-to-end di UI. Suite Robot di repo ini adalah lapisan end-to-end untuk alur yang paling mahal kalau rusak.

## Environment

- Produksi latihan: https://www.saucedemo.com
- Browser: Chrome terbaru, viewport 1440x900.
- CI: Ubuntu, Chrome headless, hasil diunggah sebagai artifact.
- Data uji: akun demo publik, tanpa data pribadi.

## Entry dan exit

Masuk pengujian kalau acceptance criteria bisa diuji, build punya versi, dan environment bisa diakses.

Keluar kalau semua test P1 dan P2 dieksekusi, regression lulus, tidak ada bug blocker, dan test summary ditulis.

## SLA bug

- S1: direspons hari yang sama, rilis ditahan.
- S2: diperbaiki dalam sprint berjalan.
- S3: dijadwalkan di sprint berikutnya.
- S4: backlog, dikerjakan bila ada waktu.

## Tinjauan

Dokumen ini ditinjau setiap awal sprint. Perubahan besar dicatat di komentar halaman, bukan ditimpa diam-diam.

