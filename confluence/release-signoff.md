# Release Sign-off - Template

Diisi sebelum memutuskan Go atau No-Go. Tanpa sign-off, rilis ditahan.

| Item | Bukti | Status |
| --- | --- | --- |
| Build dan versi yang diuji | nomor build atau commit | |
| Acceptance criteria P1 | tautan test run atau test case | |
| Smoke test otomatis | tautan run CI terakhir | |
| Regression otomatis | tautan run CI dan jumlah lulus | |
| Bug S1 dan S2 terbuka | hasil filter JQL bug blocker | |
| Bug S3 terbuka | daftar dan workaround | |
| Risiko tersisa | catatan singkat | |
| Rencana rollback | langkah dan penanggung jawab | |

Keputusan: Go atau No-Go

Approver: QA dan product owner. Kalau salah satu tidak menyetujui, statusnya No-Go.

## Aturan

- Bukti berupa tautan, bukan ingatan.
- Bug yang diterima sebagai known issue harus punya workaround dan pemilik.
- Sign-off dicatat di Jira sebagai komentar pada story rilis, dan halaman ini ditautkan ke sana.
- Setelah rilis, jalankan smoke di produksi dan perbarui status menjadi Verified.

