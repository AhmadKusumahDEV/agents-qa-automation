# Katalog Test Case - SauceDemo

Setiap ID di sini dipakai juga sebagai tag di Robot Framework, sehingga manual dan otomasi bisa dilacak. Status otomasi: ya berarti ada test dengan tag ID tersebut di tests/.

| ID | Fitur | Skenario | Prioritas | Otomasi |
| --- | --- | --- | --- | --- |
| TC-LOGIN-001 | Login | Login berhasil dengan kredensial valid | P1 | ya |
| TC-LOGIN-002 | Login | User terkunci ditolak dengan pesan | P1 | ya |
| TC-LOGIN-003 | Login | Password salah menampilkan pesan error | P1 | ya |
| TC-LOGIN-004 | Login | Username kosong menampilkan pesan error | P2 | ya |
| TC-LOGIN-005 | Login | Password kosong menampilkan pesan error | P2 | belum |
| TC-LOGIN-006 | Login | Logout kembali ke halaman login dan sesi hilang | P2 | belum |
| TC-INVENTORY-001 | Katalog | Sorting harga termurah menaruh Onesie di urutan pertama | P3 | ya |
| TC-INVENTORY-002 | Katalog | Sorting nama Z-A dimulai dari Test.allTheThings | P3 | belum |
| TC-INVENTORY-003 | Katalog | Klik nama produk membuka halaman detail dengan harga sama | P2 | belum |
| TC-INVENTORY-004 | Katalog | Tambah enam produk menampilkan badge 6 | P2 | belum |
| TC-INVENTORY-005 | Katalog | Semua gambar produk termuat tanpa broken image | P4 | belum |
| TC-INVENTORY-006 | Katalog | Menu hamburger membuka dan menutup navigasi | P3 | belum |
| TC-CART-001 | Keranjang | Badge bertambah dan berkurang saat tambah atau hapus | P1 | ya |
| TC-CART-002 | Keranjang | Continue Shopping kembali ke katalog | P2 | ya |
| TC-CART-003 | Keranjang | Hapus produk dari keranjang mengosongkan daftar | P1 | ya |
| TC-CART-004 | Keranjang | Isi keranjang bertahan setelah refresh halaman | P2 | belum |
| TC-CART-005 | Keranjang | Checkout dengan keranjang kosong tidak diizinkan | P2 | belum |
| TC-CART-006 | Keranjang | Jumlah item ditampilkan benar untuk tiap baris | P3 | belum |
| TC-CHECKOUT-001 | Checkout | Satu produk sampai halaman sukses | P1 | ya |
| TC-CHECKOUT-002 | Checkout | Nama depan kosong menampilkan error | P1 | ya |
| TC-CHECKOUT-003 | Checkout | Kode pos kosong menampilkan error | P1 | ya |
| TC-CHECKOUT-004 | Checkout | Cancel kembali ke keranjang tanpa kehilangan item | P2 | belum |
| TC-CHECKOUT-005 | Checkout | Total sama dengan subtotal ditambah tax | P1 | belum |
| TC-CHECKOUT-006 | Checkout | Tombol Back Home kembali ke katalog | P3 | belum |

## Template test case

| Field | Isi |
| --- | --- |
| ID | TC-FITUR-001 |
| Judul | Perilaku yang diuji, satu kalimat |
| Requirement | Tautan ke story atau acceptance criteria di Jira |
| Precondition | Keadaan awal, akun, dan data yang dipakai |
| Langkah | Nomor urut dengan data konkret |
| Expected | Hasil yang bisa diamati, bukan kata "berhasil" |
| Prioritas | P1 sampai P4 |
| Tipe | Fungsional, negatif, regresi, eksplorasi |
| Otomasi | ya atau belum, plus tag Robot |
| Bukti terakhir | Tanggal, build, dan tautan laporan |

## Cara memakai

1. Pilih test case P1 saat build pertama, lalu P2, P3.
2. Setelah eksekusi, catat lulus atau gagal dan lampirkan bukti pada bug bila gagal.
3. Kalau sebuah kasus berulang tiap sprint dan stabil, jadikan kandidat otomasi dan isi kolom otomasi.
4. Setiap bug yang lolos ke produksi harus menambah satu test case baru di tabel ini.

