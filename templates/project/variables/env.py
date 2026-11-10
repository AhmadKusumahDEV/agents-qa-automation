"""Konfigurasi environment untuk suite ini. Semua nilai bisa dioverride."""

import os

BASE_URL = os.getenv("BASE_URL", "https://example.com/")
BROWSER = os.getenv("BROWSER", "chrome")
HEADLESS = os.getenv("HEADLESS", "true").lower() in ("1", "true", "yes")
DEFAULT_TIMEOUT = os.getenv("DEFAULT_TIMEOUT", "10s")

