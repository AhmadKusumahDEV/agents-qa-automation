# Panduan Lengkap Jira untuk QA

Dokumen ini menjelaskan setiap halaman Jira yang kamu temui, apa fungsinya, cara memakainya, dan bagian mana yang relevan untuk pekerjaan QA. Ditulis untuk project SCRUM di madgo.atlassian.net, tetapi polanya berlaku di Jira Cloud mana pun.

## Cara memakai dokumen ini

Baca berurutan untuk pertama kali. Setelah itu, pakai daftar isi sebagai rujukan saat kamu membuka halaman tertentu. Setiap section punya pola yang sama: apa ini, apa yang terlihat, cara pakai, dan untuk QA.

## Status verifikasi

Halaman yang saya buka langsung di akunmu: Board, Backlog, Work item (SCRUM-14), dialog Create, dan Space settings - Fields.

Halaman lain dijelaskan menurut standar Jira Cloud. Tampilan bisa sedikit berbeda tergantung tipe project (team-managed atau company-managed), paket langganan, dan izin akun.

## 1. Peta aplikasi

Jira punya tiga lapis navigasi.

Bar atas: logo aplikasi, search, tombol Create, notifikasi, dan avatar. Tombol Create selalu ada di semua halaman, jadi membuat tiket tidak pernah jauh.

Sidebar kiri: For you, Recent, Starred, Plans, Spaces, Filters, Dashboards, lalu daftar produk lain seperti Confluence dan Loom. Kalau tersesat, kembali ke sini.

Area utama: berubah sesuai halaman yang dibuka. Tab di atas area ini adalah pintu antar-halaman project: Summary, Board, Backlog, Timeline, Calendar, Reports, List, Development, Releases, Docs, Archived work items.

Istilah penting: di Jira versi baru, issue sering disebut work item. Keduanya sama.

## 2. For you (halaman awal)

Apa ini: dasbor pribadi yang menampilkan pekerjaan yang relevan untukmu.

Yang terlihat: "Find a space" untuk mencari project, daftar Recently viewed, dan tab Recommended, Assigned to me, Starred, Worked on, Viewed.

Cara pakai: buka halaman ini di pagi hari. Tab Assigned to me adalah daftar kerja harianmu. Starred dipakai untuk menyimpan project yang sering dibuka.

Untuk QA: jadikan Assigned to me sebagai titik awal standup. Kalau kosong padahal kamu sedang menguji sesuatu, berarti tiket belum di-assign ke kamu. Assign dulu supaya riwayat kerja tercatat.

## 3. Spaces dan daftar project

Apa ini: wadah tempat project berada. Satu space bisa berisi beberapa project, misalnya satu space untuk satu produk.

Yang terlihat: daftar space di sidebar, masing-masing dengan ikon dan nama. Di dalamnya ada board dan project yang bisa dibuka.

Cara pakai: klik Spaces, lalu pilih space. Di halaman space kamu melihat project yang tersedia, anggota tim, dan pengaturan akses.

Untuk QA: kalau satu perusahaan punya beberapa produk, biasanya satu produk satu space. Contoh di board industri: ASG Motogadai Business, ASG Maxgadai Business, ASL Core Price Engine. Masing-masing punya board sendiri.

## 4. Summary (ringkasan project)

Apa ini: halaman pertama saat membuka project. Isinya ringkasan status, aktivitas terbaru, dan pintasan.

Yang terlihat: kartu status pekerjaan, aktivitas anggota, deskripsi project, dan tautan cepat ke board atau backlog.

Cara pakai: gunakan untuk melihat kondisi project dalam 10 detik. Kalau kamu baru bergabung di sebuah tim, mulai dari sini sebelum membuka board.

Untuk QA: cocok untuk melihat apakah sprint sedang berjalan dan siapa yang aktif. Jangan dipakai untuk mengubah status; itu pekerjaan di board.

## 5. Board (Active sprints)

Apa ini: papan kanban dari sprint yang sedang aktif. Ini halaman yang paling sering dibuka tim.

Yang terlihat: kolom status, kartu work item, avatar pelaksana, angka di judul kolom, tombol Complete sprint, filter, dan menu Group.

Cara pakai: buka board saat standup. Tarik kartu dari kiri ke kanan sesuai kemajuan. Klik kartu untuk membuka detail. Gunakan tombol Group untuk mengelompokkan berdasarkan epic, assignee, atau priority.

Untuk QA: kolom yang relevan biasanya In Progress, Ready for QA, In QA, dan Done. Kalau kolom In QA menumpuk, itu tanda uji menjadi bottleneck. Angkat di standup, jangan diamkan.

Catatan untuk akunmu: board SCRUM sekarang kosong karena belum ada sprint yang di-start. Setelah Start sprint ditekan di Backlog, kartu akan muncul di kolom To Do.

## 6. Backlog

Apa ini: daftar tunggu seluruh pekerjaan, dikelompokkan per sprint.

Yang terlihat: panel per sprint dengan nama, tanggal, jumlah work item, tombol Start sprint, dan daftar task di bawahnya. Di bagian bawah ada backlog umum dan tombol Create.

Cara pakai:

1. Buat sprint dengan Create sprint.
2. Isi nama, tanggal mulai, tanggal selesai, dan sprint goal.
3. Tarik task dari backlog ke panel sprint, atau ubah field Sprint di tiket.
4. Tekan Start sprint saat siap. Sprint jadi aktif dan muncul di board.

Untuk QA: backlog adalah tempat menilai kesiapan. Sebelum sprint dimulai, pastikan acceptance criteria bisa diuji dan data uji tersedia. Kalau belum, jangan biarkan tiket masuk sprint.

## 7. Work item (halaman tiket)

Apa ini: satu tiket lengkap. Semua konteks pekerjaan ada di sini.

Yang terlihat: judul, status di kanan atas, deskripsi dan acceptance criteria di kiri, panel Details di kanan berisi assignee, parent, due date, labels, team, start date, sprint, story point, reporter. Di bawah ada attachments, activity, dan comment.

Cara pakai: baca judul dan AC, cek status, lalu kerjakan. Setiap perubahan status tercatat di activity. Komentar dipakai untuk keputusan dan bukti, bukan untuk mengobrol panjang.

Untuk QA: ini ruang kerja utamamu. Tulis hasil uji di komentar, lampirkan screenshot atau rekaman, tautkan bug, dan jangan mengubah priority tanpa alasan.

Catatan untuk akunmu: field Priority belum tampil di layout project ini. Field-nya ada, tetapi perlu ditambahkan lewat Work types agar muncul di panel kanan.

## 8. Dialog Create

Apa ini: formulir cepat untuk membuat work item baru tanpa meninggalkan halaman.

Yang terlihat: pilihan space dan tipe di bagian atas, kolom Summary, area deskripsi, baris chip (Automatic, Parent, Due date, Labels, Team), dan tombol Create.

Cara pakai: pilih tipe, tulis Summary satu baris, isi deskripsi dengan acceptance criteria, lalu Create. Kalau butuh field lain, buka tiket setelah dibuat.

Untuk QA: biasakan menulis judul dengan pola [Area] perilaku yang diuji. Contoh: [Checkout] Tombol bayar nonaktif setelah memilih e-wallet. Judul seperti ini langsung bisa dicari dan dipahami developer.

## 9. List view

Apa ini: tampilan tabel dari sekumpulan work item.

Yang terlihat: kolom key, summary, status, assignee, priority, dan kolom lain yang bisa diatur. Ada pencarian dan filter.

Cara pakai: pakai saat butuh melihat banyak tiket sekaligus, misalnya semua bug terbuka. Klik header kolom untuk mengurutkan.

Untuk QA: lebih efisien daripada board saat menyusun laporan. Filter dulu, lalu ekspor atau salin ke dokumen test summary.

## 10. Timeline

Apa ini: tampilan garis waktu untuk melihat urutan dan rentang pekerjaan.

Yang terlihat: bar horizontal per work item atau epic, sejajar dengan kalender. Bisa di-zoom.

Cara pakai: lihat apakah pekerjaan bertumpuk di minggu yang sama. Geser rentang untuk mengubah tanggal, kalau diizinkan.

Untuk QA: berguna melihat kapan fase uji jatuh dibanding tanggal rilis. Kalau semua uji menumpuk di hari terakhir sprint, itu risiko.

## 11. Calendar

Apa ini: tampilan kalender berdasarkan due date atau tanggal mulai.

Yang terlihat: grid bulanan berisi kartu work item.

Cara pakai: klik tanggal untuk melihat pekerjaan hari itu. Cocok untuk perencanaan rilis dan cuti tim.

Untuk QA: tandai tanggal regression dan sign-off di kalender supaya tidak bertabrakan dengan rilis lain.

## 12. Reports

Apa ini: kumpulan laporan otomatis dari data sprint.

Yang tersedia umumnya: Sprint report, Burndown, Velocity, Cumulative flow, Control chart.

Cara pakai: pilih sprint, lalu baca grafiknya. Sprint report menunjukkan apa yang selesai dan apa yang dipindahkan keluar.

Untuk QA: velocity membantu memperkirakan berapa banyak uji yang realistis dalam satu sprint. Burndown yang mendatar di akhir sprint biasanya berarti pekerjaan menumpuk di QA.

## 13. Releases

Apa ini: daftar versi rilis (fix version) yang bisa diisi ke tiket.

Yang terlihat: versi dengan tanggal rilis, status unreleased atau released, dan daftar tiket di dalamnya.

Cara pakai: buat versi sebelum sprint yang menargetkan rilis, lalu isi field Fix version di tiket. Saat rilis, tekan Release.

Untuk QA: ini dasar filter kesiapan rilis. Sebelum sign-off, pastikan tidak ada bug terbuka dengan fix version yang sama.

## 14. Docs

Apa ini: pintasan ke halaman Confluence yang ditautkan ke project.

Yang terlihat: daftar dokumen atau tombol untuk membuat dokumen baru.

Cara pakai: simpan test plan, strategi, dan catatan rilis di Confluence, lalu tautkan di sini agar mudah ditemukan dari Jira.

Untuk QA: jangan menulis dokumen panjang di Jira. Jira untuk status, Confluence untuk pengetahuan.

## 15. Development

Apa ini: panel yang menghubungkan tiket dengan commit, branch, dan pull request.

Yang terlihat: daftar branch, commit, dan pull request yang menyebut key tiket.

Cara pakai: developer menulis key tiket di nama branch atau commit, misalnya SCRUM-14. Jira menampilkannya otomatis.

Untuk QA: kamu bisa melihat perubahan kode yang terkait bug, lalu menyusun regression di sekitar area itu. Ini cara cepat tahu apa yang berubah.

## 16. Filters dan JQL

Apa ini: daftar filter tersimpan, masing-masing berisi query JQL.

Yang terlihat: My open work items, Reported by me, All work items, Open work items, Done work items, dan filter buatanmu.

Cara pakai: buat filter baru dengan JQL, simpan, lalu pakai di dashboard atau bagikan ke tim.

Untuk QA, lima filter yang berguna:

    project = SCRUM AND issuetype = Bug AND statusCategory != Done ORDER BY priority DESC
    project = SCRUM AND assignee = currentUser() AND statusCategory != Done
    project = SCRUM AND created >= -7d AND issuetype = Bug
    project = SCRUM AND status = "Ready to Retest"
    project = SCRUM AND fixVersion = "v0.1" AND statusCategory != Done

## 17. Dashboards

Apa ini: halaman berisi kumpulan gadget, misalnya grafik dan daftar filter.

Cara pakai: buat dashboard pribadi, tambahkan gadget Assigned to me, Created vs Resolved, dan Sprint Health. Dashboard bersifat memantau, bukan tempat bekerja.

Untuk QA: satu dashboard berisi tren bug dan daftar retest sudah cukup. Jangan membuat sepuluh dashboard yang tidak dibuka.

## 18. Search dan JQL

Apa ini: pencarian global di bar atas. Bisa memakai teks biasa atau JQL.

Cara pakai: ketik kata kunci untuk pencarian cepat. Untuk pencarian presisi, buka advanced search dan tulis JQL.

Untuk QA: hafalkan pola dasar JQL: project, issuetype, status, assignee, created, labels, fixVersion, dan ORDER BY. Enam pola ini menutup sebagian besar kebutuhan.

## 19. Space settings (pengaturan project)

Apa ini: konfigurasi project. Di project team-managed, isinya: Details, Access, Notifications, Automation, Fields, Work types, Features, Custom filters, Toolchain, dan Apps.

Details: nama, key, deskripsi, avatar project.

Access: siapa yang boleh masuk dan perannya.

Notifications: aturan pemberitahuan.

Automation: aturan otomatis, misalnya menambah label saat status berubah.

Fields: daftar field yang tersedia. Di sinilah Priority terlihat di akunmu.

Work types: jenis pekerjaan dan field yang tampil di tiap jenis. Untuk memunculkan Priority di tiket, tambahkan lewat sini.

Features: menyalakan atau mematikan fitur seperti timeline, calendar, dan releases.

Custom filters: filter khusus project.

Toolchain: integrasi dengan alat lain.

## 20. Archived work items

Apa ini: arsip untuk work item lama yang tidak lagi aktif.

Cara pakai: buka saat mencari tiket lama yang sudah selesai dan tidak muncul di pencarian biasa.

Untuk QA: arsipkan tiket sprint lama setiap akhir sprint agar board dan list tetap ringan.

## 21. Notifikasi, watch, dan mention

Apa ini: mekanisme agar kamu tahu ada perubahan tanpa membuka tiket.

Cara pakai: tekan Watch pada tiket penting. Mention dengan @nama di komentar untuk memanggil orang tertentu.

Untuk QA: watch bug yang kamu laporkan sampai statusnya Done. Jangan mention seluruh tim untuk hal kecil.

## 22. Assignment dan avatar

Apa ini: penentuan siapa yang mengerjakan tiket.

Cara pakai: buka tiket, klik Assignee, pilih orang. Avatar akan muncul di kartu board.

Untuk QA: assign tiket ke dirimu saat mulai menguji, supaya jelas siapa yang sedang memegang. Kalau pindah orang, pindahkan assignee, bukan hanya komentar.

## 23. Kenapa board industri terlihat berbeda

Board pada contohmu (autopedai, AG board) punya tujuh kolom: TO DO, IN PROGRESS, QA, TESTED, REJECT, PENDING, DONE. Ada angka di tiap kolom, avatar inisial, quick filters, dan nama sprint berpola [MVP2][S17].

Itu bukan fitur khusus. Itu hasil konfigurasi:

1. Status ditambah dan dinamai sesuai proses tim, bukan memakai bawaan To Do, In Progress, Done.
2. Kolom diberi batas WIP, sehingga angkanya bermakna.
3. Quick filter dibuat untuk menyaring bug, pekerjaan saya, atau blocker.
4. Swimlane dipakai untuk mengelompokkan per epic atau assignee.
5. Work item diberi prefix tipe di judul, misalnya [FE], [BE], [QA].
6. Sprint diberi kode rilis dan nomor sprint, misalnya [MVP2][S17].
7. Beberapa space dipakai untuk beberapa produk, masing-masing dengan board sendiri.

Kamu bisa mencapai level yang sama di SCRUM dengan menambah status QA, Tested, Reject, dan Pending di Work types, lalu menyusun ulang kolom board.

## 24. Jalur naik level

Minggu 1: kuasai Board, Backlog, dan halaman tiket. Buat lima tiket nyata dari pekerjaanmu sendiri.

Minggu 2: tambah status QA, Tested, Reject, Pending. Susun kolom board. Buat quick filter untuk bug dan pekerjaan saya.

Minggu 3: buat dua filter JQL rutin dan satu dashboard sederhana. Pakai sprint report untuk melihat di mana pekerjaan menumpuk.

Minggu 4: tambah field Priority ke layout lewat Work types. Buat versi rilis dan isi Fix version di tiket.

Bulan 2: tambah komponen, label taksonomi, dan automation sederhana. Mulai tautkan tiket ke commit dan halaman Confluence.

## 25. Istilah singkat

Epic: tema besar. Story: pekerjaan bernilai. Task: pekerjaan teknis. Sub-task: pecahan. Bug: defect. Spike: riset berbatas waktu.

Sprint: periode kerja tetap. Backlog: daftar tunggu. Board: papan status. WIP: jumlah pekerjaan yang sedang berjalan.

JQL: bahasa query Jira. Filter: query tersimpan. Dashboard: kumpulan gadget. Component: area fungsional. Label: penanda bebas. Fix version: versi rilis.

DoR: syarat sebelum masuk sprint. DoD: syarat sebelum dianggap selesai. Story point: ukuran relatif. Velocity: rata-rata poin per sprint.

## 26. Latihan

1. Buka Backlog, buat sprint baru bernama Latihan, isi tanggal dua minggu, lalu hapus lagi setelah paham.
2. Buat satu task dengan judul [QA] Uji alur login dan isi AC-nya.
3. Tambahkan Priority ke layout, lalu ubah satu tiket menjadi High.
4. Buat filter JQL bug terbuka dan simpan sebagai My Bugs.
5. Buka satu tiket, tulis komentar berisi hasil uji dan tautan screenshot.
6. Pindahkan tiket dari To Do ke In Progress di board, lalu ke Done setelah AC lulus.

Kalau enam langkah ini selesai, kamu sudah memakai Jira pada level yang sama dengan tim produk biasa.

