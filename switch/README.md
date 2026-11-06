# Mother 2 Deluxe — Nintendo Switch port

This is a **work-in-progress**, not a playable `.nro`.

This branch tracks the libnx/devkitPro port of the SNESRecomp generated code. The generated C comes from a proprietary ROM and is deliberately not committed to this public repository. The ROM and save data must also remain local.

## Local development

1. Extract `Mother2Deluxe_Switch_Development_Kit_v2.zip` on your PC.
2. Install devkitPro and `switch-dev` in devkitPro MSYS2.
3. Run `bash switch/tools/build_generated.sh` from your locally generated `Mother2DeluxeRecomp` project root.
4. The expected output is `switch/build-generated/libsnesrecomp_game.a`, a **static library**, not a working game.

A separate diagnostic NRO can be built with `cd switch && make`, but it **does not run Mother 2 Deluxe**.

## Required for a playable port

- Verify the special 6 MiB Deluxe HiROM bank mapping against hardware-compatible behavior.
- Cross-compile and link CPU/65816 fallback, cartridge bus, PPU, DMA, SPC700/DSP, and SRAM runtime.
- Add a libnx main loop with real input, rendered video and timed audio.
- Test game boot, encounters, menus, telephone saves and reloads on physical Switch hardware.
- Preserve original game speed at the ~60 Hz NTSC cadence before implementing true widescreen.

Do not distribute a diagnostic app as `Mother2Deluxe.nro`.

Development ZIP: kept locally rather than committed because it includes generated ROM-derived code.
