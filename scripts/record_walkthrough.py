"""Perekam walkthrough Jira yang ringan.

Mode bawaan menyimpan satu screenshot per langkah, bukan merekam video terus-menerus.
Setelah selesai, jalankan scripts/make_video.py untuk merangkainya menjadi mp4.

Cara pakai:
    python scripts/record_walkthrough.py

Opsi:
    --video     merekam video terus-menerus (lebih berat, hindari di laptop berspesifikasi rendah)
    --url       halaman awal
    --out       folder hasil
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from playwright.sync_api import sync_playwright

STEPS = [
    "1/8 Buka Jira dan pastikan sudah login. Klik Lanjut.",
    "2/8 Buka Backlog. Tunjukkan Sprint 1 dan Sprint 2.",
    "3/8 Klik Create, pilih Task. Perhatikan field Summary.",
    "4/8 Isi judul, buka Priority, pilih Medium, lalu Create.",
    "5/8 Pindahkan tiket ke Sprint 1 lewat menu titik tiga.",
    "6/8 Buka Board. Tunjukkan kolom To Do, In Progress, Done.",
    "7/8 Tarik satu kartu ke In Progress, lalu ke In QA.",
    "8/8 Buka tiketnya, tunjukkan Priority dan komentar. Selesai.",
]

OVERLAY_JS = """
(steps) => {
  if (window.__qaInstalled) return;
  window.__qaInstalled = true;
  const box = document.createElement('div');
  box.style.cssText = [
    'position:fixed','left:50%','bottom:16px','transform:translateX(-50%)',
    'width:min(820px,94vw)','background:#0f172a','color:#f8fafc',
    'font:14px/1.5 system-ui,sans-serif','padding:12px 14px','border-radius:10px',
    'z-index:2147483647','display:flex','gap:12px','align-items:center'
  ].join(';');
  const label = document.createElement('div');
  label.id = '__qa_label';
  label.style.cssText = 'flex:1;';
  const btn = document.createElement('button');
  btn.style.cssText = [
    'background:#2563eb','color:#fff','border:0','border-radius:6px',
    'padding:7px 13px','font:600 14px system-ui,sans-serif','cursor:pointer',
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
    if (i >= steps.length) window.__qa_done = true;
    render();
  });
  box.appendChild(label); box.appendChild(btn);
  document.body.appendChild(box);
  render();
}
"""


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", default="https://madgo.atlassian.net/jira/software/projects/SCRUM/backlog")
    parser.add_argument("--out", default="results/walkthrough")
    parser.add_argument("--profile", default=".tutorial-profile")
    parser.add_argument("--video", action="store_true", help="rekam video terus-menerus (lebih berat)")
    parser.add_argument("--width", type=int, default=1280)
    parser.add_argument("--height", type=int, default=720)
    args = parser.parse_args()

    root = Path(__file__).resolve().parent.parent
    out_dir = (root / args.out).resolve()
    profile_dir = (root / args.profile).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    profile_dir.mkdir(parents=True, exist_ok=True)

    launch_kwargs = dict(
        user_data_dir=str(profile_dir),
        channel="msedge",
        headless=False,
        viewport={"width": args.width, "height": args.height},
        args=[
            "--no-first-run",
            "--no-default-browser-check",
            "--disable-background-timer-throttling",
            "--disable-renderer-backgrounding",
        ],
    )
    if args.video:
        launch_kwargs["record_video_dir"] = str(out_dir)
        launch_kwargs["record_video_size"] = {"width": args.width, "height": args.height}

    with sync_playwright() as p:
        context = p.chromium.launch_persistent_context(**launch_kwargs)
        page = context.pages[0] if context.pages else context.new_page()

        def install(_=None):
            try:
                page.evaluate(OVERLAY_JS, STEPS)
            except Exception:
                pass

        page.on("load", install)
        page.goto(args.url, wait_until="domcontentloaded")
        install()

        frames = out_dir / "frames"
        frames.mkdir(exist_ok=True)

        print("Edge terbuka. Login kalau diminta, lalu ikuti panel di bawah layar.")
        print("Setiap kali kamu klik Lanjut, screenshot disimpan sebagai satu frame video.")

        last = -1
        captured = 0
        while True:
            try:
                step = int(page.evaluate("Number(sessionStorage.getItem('__qa_step') || 0)"))
                done = bool(page.evaluate("window.__qa_done === true"))
            except Exception:
                step, done = last, False

            if step != last:
                page.wait_for_timeout(500)
                shot = frames / f"{step:02d}.png"
                try:
                    page.screenshot(path=str(shot))
                    captured += 1
                except Exception:
                    pass
                last = step

            if done:
                break
            page.wait_for_timeout(600)

        context.close()

    print(f"{captured} frame tersimpan di {frames}")
    print("Jalankan: python scripts/make_video.py")
    return 0


if __name__ == "__main__":
    sys.exit(main())

