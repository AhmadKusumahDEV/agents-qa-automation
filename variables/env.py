"""Konfigurasi environment untuk suite Robot Framework.

Semua nilai bisa dioverride lewat environment variable supaya suite yang sama
dipakai di laptop dan di GitHub Actions tanpa mengubah test.
"""

import os

BASE_URL = os.getenv("BASE_URL", "https://www.saucedemo.com/")
BROWSER = os.getenv("BROWSER", "chrome")
HEADLESS = os.getenv("HEADLESS", "true").lower() in ("1", "true", "yes")
DEFAULT_TIMEOUT = os.getenv("DEFAULT_TIMEOUT", "10s")
