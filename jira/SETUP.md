# Setup Jira - QA Learning Lab

Panduan ini membuat project Scrum dua minggu yang mengikuti standar kerja QA. Semua langkah bisa diselesaikan dalam 20 sampai 30 menit.

Catatan: site yang terhubung ke Codex saat ini adalah fatursofyanfs.atlassian.net, dan site itu menjawab 404 untuk Jira maupun Confluence. Kalau URL di address bar Jira kamu berbeda, pakai URL itu saat membuka halaman pengaturan di bawah.

## 1. Buat project

1. Buka Jira, pilih Projects, lalu Create project.
2. Pilih template Scrum, bukan Kanban.
3. Nama: QA Learning Lab. Key: QAL.
4. Pilih team-managed supaya kamu bisa mengubah status dan field tanpa admin global.

Kalau kamu ingin berlatih konfigurasi ala perusahaan, pilih company-managed. Konsekuensinya, workflow dan field diatur lewat scheme yang lebih kaku.

## 2. Atur kolom board

Buka Project settings, lalu Board. Susun status berurutan:

1. To Do
2. In Progress
3. In Review
4. Ready for QA
5. In QA
6. Ready for Retest
7. Done

Aturan perpindahan:

- Developer memindahkan ke Ready for QA setelah build siap.
- QA memindahkan ke In QA saat mulai menguji.
- Kalau gagal, buat Bug dan tautkan ke story, lalu story kembali ke In Progress.
- Ready for Retest dipakai setelah fix deploy, dan QA memindahkan ke Done hanya kalau acceptance criteria plus regresi di sekitarnya lulus.

## 3. Aktifkan field

Di Project settings, Fields:

- Story Points: aktifkan, skala Fibonacci 1, 2, 3, 5, 8.
- Severity: buat field select dengan nilai S1 Critical, S2 Major, S3 Minor, S4 Cosmetic.
- Environment: field teks bebas untuk build, OS, browser, akun.
- Acceptance Criteria: field paragraf, atau tulis sebagai bagian Description dengan heading sendiri.
- Component: Auth, Catalog, Cart, Checkout.
- Labels: pakai daftar tertutup, misalnya smoke, regression, exploratory, automation, flaky.

Priority tetap dipakai untuk semua issue. Severity hanya untuk Bug. Jangan menyamakan keduanya: Priority menjawab seberapa cepat, Severity menjawab seberapa rusak.

## 4. Impor backlog

1. Buka Issues, lalu menu titik tiga, pilih Import issues.
2. Pilih CSV, unggah jira/backlog.csv.
3. Petakan kolom: Issue Type, Summary, Description, Epic Link, Priority, Labels, Story Points.
4. Biarkan Sprint kosong; semua masuk backlog.
5. Setelah impor, buka Backlog dan tarik isu berlabel sprint-1 ke Sprint 1, sprint-2 ke Sprint 2.

Kalau Epic Link tidak terbaca, impor Epic lebih dulu, lalu impor sisanya. Jira Cloud kadang meminta nama epic persis sama dengan Summary.

## 5. Buat sprint dua minggu

- Sprint 1: 10 November 2026 sampai 23 November 2026. Goal: fondasi manual testing dan Jira rapi.
- Sprint 2: 24 November 2026 sampai 7 Desember 2026. Goal: suite otomasi pertama jalan di CI.

Isi sprint goal di setiap sprint. Sprint tanpa goal akan berubah jadi daftar tugas tanpa arah.

## 6. Filter JQL yang disimpan

Simpan sebagai filter, lalu tampilkan di dashboard.

Triage bug harian:

    project = QAL AND issuetype = Bug AND statusCategory != Done ORDER BY priority DESC, created ASC

Pekerjaan saya:

    project = QAL AND assignee = currentUser() AND statusCategory != Done ORDER BY status ASC, priority DESC

Laporan mingguan:

    project = QAL AND updated >= startOfWeek(-1) AND updated < startOfWeek() ORDER BY updated DESC

Kesiapan rilis:

    project = QAL AND fixVersion = "v0.1" AND statusCategory != Done ORDER BY priority DESC

Defect baru:

    project = QAL AND issuetype = Bug AND created >= -7d ORDER BY created DESC

Bug menunggu retest:

    project = QAL AND status = "Ready for Retest" ORDER BY updated ASC

## 7. Dashboard minimum

Tambahkan empat gadget: Assigned to Me, Sprint Health, Created vs Resolved, dan Filter Results untuk filter bug harian. Empat gadget ini cukup untuk melihat beban kerja, arah sprint, tren defect, dan antrean triage.

## 8. Definition of Ready dan Done

Definition of Ready: acceptance criteria bisa diuji, desain dan data uji tersedia, dependency jelas, story points terisi, dan tidak ada blocker.

Definition of Done: semua AC lulus dengan bukti, bug baru tercatat dan tertaut, smoke dan regression relevan lulus, dokumentasi diperbarui, dan product owner menerima hasilnya di Sprint Review.

## 9. Kalau site 404

Gejala: konektor Atlassian terlihat connected, tetapi setiap panggilan Jira atau Confluence mengembalikan 404 Site temporarily unavailable.

Penyebab yang paling sering: subdomain site salah, site dinonaktifkan karena tidak dipakai, atau produk Jira belum diaktifkan di site tersebut.

Langkah: buka https://admin.atlassian.com, cek site yang muncul di daftar, lalu salin URL-nya dari address bar. Kalau site tidak ada di daftar, buat site baru dan aktifkan Jira Software serta Confluence di dalamnya.

