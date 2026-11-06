#!/usr/bin/env bash
# Generates an ARM64 static library; NOT a playable NRO.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
: "${DEVKITPRO:?Run from devkitPro MSYS2}"
CC="$DEVKITPRO/devkitA64/bin/aarch64-none-elf-gcc"
AR="$DEVKITPRO/devkitA64/bin/aarch64-none-elf-ar"
"$CC" --version >/dev/null
"$AR" --version >/dev/null
OUT="$ROOT/switch/build-generated"
mkdir -p "$OUT"
shopt -s nullglob
files=("$ROOT"/generated/*.c)
if (("${#files[@]}" == 0)); then echo "Generated C files missing" >&2; exit 1; fi
objects=()
for src in "${files[@]}"; do
 obj="$OUT/$(basename "${src%.c}").o"
 "$CC" -std=gnu11 -O2 -w -Wno-implicit-function-declaration -march=armv8-a+crc+crypto -mtune=cortex-a57 -ffunction-sections -fdata-sections -I"$ROOT/config" -I"$ROOT/snesrecomp/runner/src" -I"$ROOT/snesrecomp/runner/src/snes" -c "$src" -o "$obj"
 objects+=("$obj")
done
"$AR" rcs "$OUT/libsnesrecomp_game.a" "${objects[@]}"
echo "Generated library only: $OUT/libsnesrecomp_game.a"
