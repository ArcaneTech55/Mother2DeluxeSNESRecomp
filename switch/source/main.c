/* Switch DIAGNOSTIC ONLY. No gameplay integration. */
#include <switch.h>
#include <stdio.h>
#define ROM_PATH "sdmc:/switch/mother2deluxe/Mother 2 (Deluxe v3.0.16).smc"
int main(int argc, char **argv) {
  (void)argc; (void)argv;
  consoleInit(NULL);
  printf("Mother 2 Deluxe Switch diagnostic\n");
  printf("NOT A PLAYABLE GAME\n\n");
  FILE *f=fopen(ROM_PATH,"rb");
  if (f) {
    if (!fseek(f,0,SEEK_END)) printf("ROM bytes: %ld (expected 6291456)\n",ftell(f));
    fclose(f);
  } else printf("ROM not found at %s\n",ROM_PATH);
  printf("Press PLUS to exit\n");
  PadState pad;
  padConfigureInput(1,HidNpadStyleSet_NpadStandard);
  padInitializeDefault(&pad);
  while (appletMainLoop()) {
    padUpdate(&pad);
    if (padGetButtonsDown(&pad)&HidNpadButton_Plus) break;
    consoleUpdate(NULL);
  }
  consoleExit(NULL);
  return 0;
}
