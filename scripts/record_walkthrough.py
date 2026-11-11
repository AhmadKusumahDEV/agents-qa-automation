"""Perekam walkthrough Jira memakai Playwright + Microsoft Edge.

Cara pakai:
    python scripts/record_walkthrough.py

Yang terjadi:
1. Edge terbuka dengan profil khusus di .tutorial-profile (login cukup sekali).
2. Panel kecil di bawah menjelaskan langkah yang sedang direkam.
3. Kamu melakukan klik sendiri di Jira, lalu tekan tombol Lanjut di panel.
4. Video disimpan di results/tutorial.

Password tidak pernah dibaca oleh skrip ini. Sesi login tersimpan di profil lokal
yang sudah masuk .gitignore.
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

from playwright.sync_api import sync_playwright

DEFAULT_STEPS = [
    "Langkah 1 dari 8 - Kalau muncul halaman login, masuk dulu. Setelah Jira terbuka, klik Lanjut.",
    "Langkah 2 dari 8 - Buka Backlog. Tunjukkan Sprint 1 dan Sprint 2 yang sudah ada.",
    "Langkah 3 dari 8 - Klik tombol Create di kanan atas, lalu pilih Task. Perhatikan field Summary.",
    "Langkah 4 dari 8 - Isi judul tiket, lalu buka field Priority dan pilih Medium. Klik Create.",
    "Langkah 5 dari 8 - Pindahkan tiket baru ke Sprint 1 lewat menu titik tiga atau drag ke sprint.",
    "Langkah 6 dari 8 - Buka Board Sprint 1. Tunjukkan kolom To Do, In Progress, dan Done.",
    "Langkah 7 dari 8 - Tarik satu kartu ke In Progress, lalu ke In QA. Jelaskan arti tiap kolom.",
    "Langkah 8 dari 8 - Buka tiketnya, tunjukkan Priority, Labels, dan komentar. Selesai.",
]

OVERLAY_JS = """
(steps) => {
  if (window.__qaInstalled) return;
  window.__qaInstalled = true;

  const box = document.createElement('div');
  box.id = '__qa_overlay';
  box.style.cssText = [
    'position:fixed', 'left:50%', 'bottom:18px', 'transform:translateX(-50%)',
    'width:min(860px, 92vw)', 'background:#0f172a', 'color:#f8fafc',
    'font:14px/1.5 system-ui, sans-serif', 'padding:14px 16px',
    'border-radius:10px', 'box-shadow:0 8px 24px rgba(0,0,0,.35)',
    'z-index:2147483647', 'display:flex', 'gap:14px', 'align-items:center'
  ].join(';');

  const label = document.createElement('div');
  label.id = '__qa_label';
  label.style.cssText = 'flex:1;';

  const btn = document.createElement('button');
  btn.textContent = 'Lanjut';
  btn.style.cssText = [
    'background:#2563eb', 'color:#fff', 'border:0', 'border-radius:6px',
    'padding:8px 14px', 'font:600 14px system-ui, sans-serif', 'cursor:pointer',
    'white-space:nowrap'
  ].join(';');

  function render() {
    const i = Number(sessionStorage.getItem('__qa_step') || 0);
    label.textContent = steps[Math.min(i, steps.length - 1)];
    btn.textContent = i >= steps.length - 1 ? 'Selesai' : 'Lanjut';
  }

  btn.addEventListener('click', () => {
    const i = Number(sessionStorage.getItem('__qa_step') || 0) + 1;
    sessionStorage.setItem('__qa_step', String(i));
    if (i >= steps.length) {
      window.__qa_done = true;
    }
    render();
  });

  box.appendChild(label);
  box.appendChild(btn);
  document.body.appendChild(box);
  render();
}
"""


def main() -> int:
    parser = argparse.ArgumentParser(description="Rekam walkthrough Jira dengan Playwright")
    parser.add_argument("--url", default="https://madgo.atlassian.net/jira/software/projects/SCRUM/backlog")
    parser.add_argument("--out", default="results/tutorial")
    parser.add_argument("--profile", default=".tutorial-profile")
    parser.add_argument("--slowmo", type=int, default=120)
    args = parser.parse_args()

    root = Path(__file__).resolve().parent.parent
    out_dir = (root / args.out).resolve()
    profile_dir = (root / args.profile).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    profile_dir.mkdir(parents=True, exist_ok=True)

    steps = DEFAULT_STEPS
    started = time.time()

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(
            user_data_dir=str(profile_dir),
            channel="msedge",
            headless=False,
            slow_mo=args.slowmo,
            viewport={"width": 1280, "height": 800},
            record_video_dir=str(out_dir),
            record_video_size={"width": 1280, "height": 800},
            args=["--start-maximized"],
        )
        page = context.pages[0] if context.pages else context.new_page()

        def install(_=None):
            try:
                page.evaluate(OVERLAY_JS, steps)
            except Exception:
                pass

        page.on("load", install)
        page.goto(args.url, wait_until="domcontentloaded")
        install()

        print("Edge terbuka. Login kalau diminta, lalu ikuti panel di bawah layar.")
        print("Tekan Ctrl+C untuk berhenti lebih awal.")

        video = page.video
        try:
            while True:
                try:
                    done = page.evaluate("window.__qa_done === true")
                except Exception:
                    done = False
                if done:
                    break
                page.wait_for_timeout(400)
        except KeyboardInterrupt:
            print("\nDihentikan. Video tetap disimpan.")

        context.close()

        if video:
            try:
                path = video.path()
            except Exception:
                path = None
            if path:
                print(f"Video tersimpan: {path}")

    print(f"Selesai dalam {int(time.time() - started)} detik. Folder: {out_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

