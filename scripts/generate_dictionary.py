#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import base64
import zipfile
from pathlib import Path
import oracledb

# =========================
# Repo paths
# =========================
ROOT = Path(".")
OUT_DIR = ROOT / "diccionario"
OUT_DIR.mkdir(parents=True, exist_ok=True)

INDEX_MD = ROOT / "index.md"

# Runtime wallet folder (must NOT be committed)
WALLET_DIR = ROOT / ".wal_
