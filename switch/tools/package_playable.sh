#!/usr/bin/env bash
# Package ONLY a separately validated, playable game binary.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
NRO="$ROOT/switch/Mother2Deluxe.nro"
OUT="$ROOT/../Mother2Deluxe_Switch_Release"
if [[ ! -f "$NRO" ]]; then
  echo "No playable Mother2Deluxe.nro was built" >&2
  exit 2
fi
if [[ "${MOTHER2_DELUXE_PLAYABLE_VERIFIED:-}" != YES ]]; then
  echo "Gameplay, audio, and saving have not been verified; refusing release" >&2
  exit 3
fi
mkdir -p "$OUT/switch/mother2deluxe/saves"
cp "$NRO" "$OUT/switch/mother2deluxe/Mother2Deluxe.nro"
printf '%s\n' 'Copy switch/ to your SD card; supply your own legal Mother 2 Deluxe ROM.' > "$OUT/README.txt"
echo "Staged $OUT"
