# Mother 2 Deluxe v3.0.16 — port status

This is an **uncompiled starter scaffold**, not a playable Windows or Nintendo Switch port.

## Verified locally

- ROM file length: 6,291,456 bytes (6 MiB), no copier header.
- ROM verification: passed CRC32 `a805153b` and SHA-256 in `rom_identity.txt`.
- Probe reports HiROM, USA, no coprocessor, 32 KiB SRAM, reset vector `$8141`.
- Header declares 4 MiB (`0x0C`); the extra 2 MiB is not identical to the first 2 MiB and contains nonzero data.
- The SNESRecomp project scaffolder successfully generated the project layout and analysis configuration.
- C generation was attempted and stopped: Rust/Cargo is missing. The retired Python analyzer cannot be used instead.
- `tools/check_deluxe_rom.py` validates the pinned ROM and intentionally exits with status 3 on its unsupported expansion. Local check passed: 1,605,951 nonzero bytes in the final 2 MiB.
- Independently, Snes9x issue #691 identifies Mother 2 Deluxe as a nonstandard 6 MiB mapping requiring an emulator-specific detection heuristic: https://github.com/snes9xgit/snes9x/issues/691
- No executable or `.nro` was produced or runtime-tested.

## Critical integration work

1. Determine the **actual** Deluxe ROM expansion bank mapping, including whether the 4–6 MiB region is accessed through an ExHiROM-like scheme or custom bank logic. SNESRecomp currently documents ExHiROM as unsupported. The probe's `hirom` result is **not** proof that the expanded ROM maps correctly.
2. Extend mapper and code analysis to cover the expansion if needed, then regenerate C with the Rust analyzer.
3. Build and debug Windows x64 first (boot, title screen, movement, audio, combat, saves, long-running play).
4. Adapt the desktop host to libnx/devkitPro for Switch; the generated Windows executable does not turn into an `.nro` automatically.
5. Develop and validate true 16:9 scenes separately; the default runtime does not inherently expand EarthBound's world layout.

## Windows development commands

Install Git, Python 3.11+, Rust (with Cargo), Visual Studio 2022 C++ workload, and CMake. In Developer PowerShell:

```powershell
git submodule update --init --recursive
bash tools/regen.sh --rom 'C:/ROMs/Mother 2 (Deluxe v3.0.16)(5).smc'
cmake -S . -B build -G 'Visual Studio 17 2022' -A x64
cmake --build build --config Release --parallel
```

These commands are **development steps**, not a promise of a successful or playable build. Fix the expanded mapper and validate the program before claiming playability.

Never commit the ROM, generated translation, or user saves to a public repository.
