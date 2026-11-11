# Storyboard Video: Dasar Jira dalam 8 Langkah

Durasi target: 6 sampai 8 menit. Rekaman memakai scripts/record_walkthrough.py.

## Persiapan

- Buka Jira dengan akun pemilik project, bukan akun tamu.
- Pastikan Sprint 1 dan Sprint 2 sudah ada di backlog.
- Tutup tab lain supaya rekaman bersih.
- Jalankan: python scripts/record_walkthrough.py

## Alur dan narasi

1. Halaman awal Jira. "Ini Jira, tempat pekerjaan dicatat. Satu kartu disebut issue atau work item."
2. Backlog. "Backlog adalah daftar tunggu. Di sini ada Sprint 1 dan Sprint 2, masing-masing dua minggu."
3. Tombol Create, pilih Task. "Setiap pekerjaan baru dimulai dari sini. Summary adalah judul satu baris."
4. Isi judul, buka Priority, pilih Medium, klik Create. "Priority menentukan urutan kerja, bukan besarnya pekerjaan."
5. Pindahkan tiket ke Sprint 1. "Tiket masuk sprint berarti dikerjakan dalam dua minggu ini."
6. Board. "Kolom menunjukkan status. Kartu bergerak dari kiri ke kanan."
7. Tarik kartu ke In Progress lalu In QA. "In Progress berarti sedang dikerjakan. In QA berarti sedang diuji."
8. Buka tiket, tunjukkan Priority, Labels, komentar. "Semua bukti dan keputusan dicatat di tiket ini."

## Catatan istilah yang sering salah

- Priority di Jira: Highest, High, Medium, Low, Lowest.
- Blocked bukan priority. Blocked adalah status, flag, atau tautan "is blocked by". Kalau sebuah tiket menunggu orang lain, pakai status Blocked dan tulis di komentar siapa yang ditunggu.
- Story Points mengukur besar pekerjaan, bukan prioritas.
- Severity hanya untuk Bug, mengukur dampak teknis.

## Setelah rekaman

Video tersimpan sebagai .webm di results/tutorial. Kalau butuh mp4, konversi dengan ffmpeg:

    ffmpeg -i hasil.webm -c:v libx264 -crf 23 hasil.mp4

Folder results dan .tutorial-profile tidak ikut di-commit.

