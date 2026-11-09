# Rancangan Space Confluence "QA Learning Lab"

Confluence menyimpan keputusan, cara kerja, dan bukti; Jira tetap sumber status. Struktur ini untuk satu QA yang menjalankan Scrum 2 minggu dengan Robot Framework + Selenium.

## 1. Page tree (11 halaman aktif + Archive)

| Halaman | Tujuan |
|---|---|
| QA Learning Lab (Home) | Titik masuk, ritme sprint, tautan Jira. |
| Learning Path 2 Minggu | Rencana harian Scrum + latihan Robot/Selenium. |
| Test Strategy | Keputusan mutu: scope, risiko, environment, entry/exit. |
| Sprint Test Plan | Rencana tes per sprint: scope, risiko, data, jadwal. |
| Test Case Repository | Katalog kasus per fitur, ID unik, status otomasi. |
| Bug Report Guideline | Aturan bug layak review, severity/priority, triage. |
| Regression Checklist | Cek wajib per rilis + suite Robot terkait. |
| Release Sign-off | Bukti go/no-go, residual risk, approver. |
| Sprint QA Report | Hasil, metrik, insight, action item. |
| Automation Guide | Setup repo, run, tag, laporan, CI, konvensi. |
| QA Metrics | Definisi metrik + tautan filter JQL. |

Subpage **Archive** menyimpan sprint lama (label `arsip`). Learning path: Hari 1–3 Scrum/AC; 4–7 test case + bug; 8–12 Robot/Selenium; 13–14 regression + report.

## 2. Isi halaman kunci

**Test Strategy** — Tujuan mutu (0 bug P1 lolos, 90% AC P1 terverifikasi), in/out scope, risk-based testing, environment, entry/exit criteria, SLA bug, tools. Exit: 100% AC P1 lulus, 0 bug S1/S2 terbuka, smoke pass. Tinjau per kuartal.

**Sprint Test Plan** — Halaman `Sprint 03 — Test Plan`: scope + tautan AC, risk matrix, jenis tes, data/akun, jadwal harian, dependency, exit criteria. DoD: AC terverifikasi + bukti run. Tautkan ke sprint Jira.

**Test Case Repository** — Confluence Database atau satu halaman per fitur; satu baris satu kasus. Review saat planning, perbarui setelah bug regression. Hasil run di Jira/CI; di sini status otomasi dan bukti terakhir.

**Bug Report Guideline** — Formula judul, field wajib, severity vs priority, alur New → Triaged → In Progress → Ready to Test → Verified/Reopened → Closed, cek duplikat, SLA, triage harian 15 menit.

**Regression Checklist** — Smoke P1 15–20 menit per build; regression berbasis risiko; full regression sebelum rilis. Tiap baris: TC ID, tag Robot, bukti run. Tambahkan kasus setiap escaped bug.

**Release Sign-off** — Scope terverifikasi, bug P1/P2, regression pass, laporan otomasi, known issue + workaround, rollback, approver, keputusan Go/No-Go. Approver: PO + QA; tanpa sign-off = No-Go.

**Sprint QA Report** — Scope, planned/run/pass, defect per severity, escaped bug, automation coverage, risiko, action item + owner/tanggal. Bandingkan dengan sprint sebelumnya; tautkan dashboard.

**Automation Guide** — Struktur `tests/`, `resources/`, `libraries/`; setup Python/venv; `robot --tags smoke tests/`; tag per Jira; laporan XML/HTML; CI PR + nightly; SeleniumLibrary, Page Object, headless; karantina flaky; secret di CI.

## 3. Template

**Test case** (10 field): ID (`TC-LOGIN-001`), Judul, Requirement/AC (link Jira), Precondition, Steps + data konkret, Expected teramati, Priority P1–P3, Type, Automation status + tag Robot, Last run + bukti.

**Bug report**: Judul `[Checkout] Tombol Bayar tetap disabled setelah pilih kurir`; Environment (URL, build/commit, browser/OS, role); Precondition; Steps minimal; Actual vs Expected; Evidence bertimestamp; Severity/Priority terpisah; Frequency (`3/5`); Story/TC; Workaround; Reporter. Lolos review bila satu bug per tiket, reproducible di environment bersih, duplikat dicek.

**Severity:** S1 blocker/data loss/security, S2 mayor, S3 minor, S4 kosmetik. **Priority:** P1 hari ini, P2 sprint ini, P3 backlog.

## 4. Traceability Confluence–Jira

- Test case: kolom Requirement memakai Jira issue link; Story punya remote link ke test case.
- ID stabil `TC-<FITUR>-<NNN>` di judul, field Jira, dan tag Robot. Contoh `TC-LOGIN-001` ↔ `QA-12` ↔ tag `QA-12`.
- Story ↔ Bug lewat issue link `relates to`/`is caused by`; AC jadi checklist.
- CI kirim URL laporan ke komentar Jira tiap run; tanpa Xray/Zephyr, issue link native + TC ID cukup.
- Macro Jira Issues menampilkan bug/sprint live; matriks di Release Sign-off: Story → AC → TC → otomasi → bug → status.

## 5. Kebiasaan agar tetap hidup

Update di planning, saat risiko berubah, sebelum review, sebelum rilis, dan retro. Tulis owner + tanggal **last verified** di atas halaman: QA punya halaman QA, PO punya AC, developer punya catatan fix. Simpan keputusan dan cara kerja; status/angka live dari Jira/CI. Jangan tulis status harian, log mentah, notulen tanpa keputusan, atau duplikasi Jira. Arsipkan sprint lama dengan label `qa`, `sprint-<n>`; cek tautan mati tiap Jumat.

## 6. Lima kesalahan dokumentasi QA paling umum

1. Halaman templat kosong, field "TBD", tanpa owner/tanggal.
2. Menyalin status Jira ke Confluence sehingga cepat basi.
3. Test case tanpa data, expected teramati, atau ID; tidak bisa diulang.
4. Bug report kurang environment/langkah, menggabung bug, severity = priority.
5. Satu halaman raksasa, nama acak, tanpa arsip; hilang saat handover.

Tidak ada perubahan di Confluence; ini rekomendasi.
