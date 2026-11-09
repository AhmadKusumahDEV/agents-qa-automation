# Bug Report Guideline

Bug yang baik bisa direproduksi orang lain tanpa bertanya. Satu tiket, satu masalah.

## Format judul

[Area] Perilaku yang salah dalam kondisi apa

Contoh: [Checkout] Tombol Bayar tetap nonaktif setelah memilih e-wallet di iOS 17

## Field wajib

| Field | Isi |
| --- | --- |
| Environment | URL, build atau commit, browser dan versi, OS, perangkat, akun uji |
| Precondition | Keadaan awal dan data yang sudah disiapkan |
| Steps | Nomor urut, singkat, tanpa langkah yang tidak relevan |
| Actual | Apa yang benar-benar terjadi, termasuk pesan error persis |
| Expected | Apa yang seharusnya terjadi menurut acceptance criteria |
| Frequency | 10/10 atau 3/5, sebutkan kalau hanya pada koneksi lambat |
| Evidence | Screenshot, rekaman, request id, potongan log |
| Severity | S1 sampai S4, dampak teknis |
| Priority | P1 sampai P4, urgensi bisnis |
| Link | Story asal dan test case yang menemukannya |

## Severity dan Priority

- S1 Critical: data hilang, keamanan bocor, alur utama mati tanpa workaround.
- S2 Major: fitur penting gagal, ada workaround terbatas.
- S3 Minor: fungsi kecil terganggu, workaround jelas.
- S4 Cosmetic: tampilan atau teks.

Priority ditentukan bisnis: P1 dikerjakan hari ini, P2 sprint ini, P3 backlog dekat, P4 kapan ada waktu.

Severity S1 tidak otomatis P1. Crash pada fitur di balik feature flag yang belum dinyalakan tetap S1, tetapi priority bisa P3.

## Sebelum submit

1. Cari duplikat dengan JQL: project = QAL AND text ~ "kata kunci".
2. Pastikan bug muncul di build dan environment yang ditulis.
3. Pisahkan dua masalah berbeda menjadi dua tiket.
4. Lampirkan bukti yang menunjukkan waktu dan build.
5. Tautkan ke story dan test case.

## Setelah submit

QA memverifikasi fix di build yang menyebut nomor perbaikannya, menjalankan regresi di sekitar perubahan, lalu memindahkan status ke Done. Kalau gagal, kembalikan ke Ready for Retest dengan komentar berisi bukti baru.

