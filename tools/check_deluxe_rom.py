#!/usr/bin/env python3
"""Check Mother 2 Deluxe ROM identity and expanded HiROM compatibility.

This does not guess how the expansion banks are wired. It deliberately fails
until the recompiler and runner have an explicitly validated mapping.
"""
import argparse
import hashlib
from pathlib import Path
import sys
import zlib

EXPECTED_SHA256 = "635b4a148cfd1abf8cb43b37726b094183a81a92d11043090d7df1fc391a0f1a"
HIROM_ADDRESS_SPACE = 0x400000


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("rom", type=Path)
    args = parser.parse_args()
    raw = args.rom.read_bytes()
    rom = raw[512:] if len(raw) % 1024 == 512 else raw
    sha = hashlib.sha256(rom).hexdigest()
    crc = zlib.crc32(rom) & 0xffffffff
    print(f"ROM: {len(rom):,} bytes; CRC32={crc:08x}; SHA256={sha}")
    if sha != EXPECTED_SHA256:
        print("ERROR: This is not the pinned Mother 2 Deluxe v3.0.16 ROM.", file=sys.stderr)
        return 2
    if len(rom) > HIROM_ADDRESS_SPACE:
        extra = rom[HIROM_ADDRESS_SPACE:]
        print(f"Expansion: {len(extra):,} bytes above the standard 4 MiB HiROM window")
        print(f"Expansion: {sum(x != 0 for x in extra):,} nonzero bytes")
        print(f"Expansion SHA256: {hashlib.sha256(extra).hexdigest()}")
        print("BLOCKED: Standard SNESRecomp HiROM maps only 0x000000..0x3FFFFF.")
        print("Identify Deluxe's bank layout and update both analyzer and runtime mapper.")
        return 3
    print("Standard HiROM size check passed; gameplay remains unvalidated.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
