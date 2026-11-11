"""Beri anotasi angka dan keterangan pada screenshot Jira asli."""

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "results" / "real-shots"
OUT = ROOT / "docs" / "panduan-jira" / "screens"
OUT.mkdir(parents=True, exist_ok=True)

BOLD = "C:/Windows/Fonts/seguisb.ttf"
REG = "C:/Windows/Fonts/segoeui.ttf"
BAR = 92


def font(path: str, size: int) -> ImageFont.FreeTypeFont:
    try:
        return ImageFont.truetype(path, size)
    except Exception:
        return ImageFont.load_default()


def annotate(name: str, points, title: str, subtitle: str) -> None:
    img = Image.open(SRC / f"{name}.jpg").convert("RGB")
    w, h = img.size
    canvas = Image.new("RGB", (w, h + BAR), "#172b4d")
    canvas.paste(img, (0, 0))
    draw = ImageDraw.Draw(canvas)

    for index, (x, y) in enumerate(points, start=1):
        r = 17
        draw.ellipse([x - r - 4, y - r - 4, x + r + 4, y + r + 4], fill="#0052cc")
        draw.ellipse([x - r, y - r, x + r, y + r], fill="#ffffff")
        f = font(BOLD, 21)
        text = str(index)
        box = draw.textbbox((0, 0), text, font=f)
        draw.text(
            (x - (box[2] - box[0]) / 2, y - (box[3] - box[1]) / 2 - box[1]),
            text,
            fill="#0052cc",
            font=f,
        )

    draw.text((32, h + 14), title, fill="#ffffff", font=font(BOLD, 26))
    draw.text((32, h + 52), subtitle, fill="#c1c7d0", font=font(REG, 18))

    canvas.save(OUT / f"{name}.png")
    print("saved", name)


annotate(
    "01-backlog",
    [(985, 26), (400, 560), (1236, 580), (383, 644)],
    "1. Backlog: tempat sprint dan tiket disusun",
    "Create untuk tiket baru · panel sprint · Start sprint untuk mengaktifkan · daftar task di bawah",
)

annotate(
    "02-create",
    [(300, 92), (300, 132), (300, 190), (1005, 411)],
    "2. Membuat task dari tombol Create",
    "Pilih Task · tulis Summary · isi acceptance criteria · klik Create",
)

annotate(
    "03-issue",
    [(332, 160), (1040, 172), (335, 684)],
    "3. Detail tiket: membaca syarat dan menulis bukti",
    "AC di kiri · field di kanan · comment untuk hasil uji dan tautan bukti",
)

annotate(
    "04-board",
    [(710, 614), (505, 143)],
    "4. Board kosong sebelum sprint dimulai",
    "Klik Go to Backlog · Start sprint · kartu akan muncul di kolom To Do",
)

annotate(
    "05-fields",
    [(26, 339), (368, 655)],
    "5. Mengaktifkan field Priority",
    "Space settings · Work types untuk menambah field · Priority sudah ada di daftar",
)

