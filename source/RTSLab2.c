/**
 * @file    RTSLab2.c
 * @brief   Application entry point.
 */
#include <stdio.h>
#include "board.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKW41Z4.h"

/* TODO: insert other include files here. */

/* TODO: insert other definitions and declarations here. */
typedef struct {
  uint8_t version:4, ihl:4;
  uint8_t tos;
  uint16_t tl;
  uint16_t inden;
  uint16_t flags:3, fragOffet:13;
  uint8_t ttl;
  uint8_t protcol;
  uint16_t checksum;
  uint32_t saddr;
  uint32_t daddr;
} IPv4Header;

/*
 * @brief   Application entry point.
 */
int main(void) {

  	/* Init board hardware. */
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
  	/* Init FSL debug console. */
    BOARD_InitDebugConsole();

    printf("Hello World\n");

    return 0 ;
}
