#include <stdio.h>
#include "board.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKW41Z4.h"
#include "fsl_lpuart.h"
#include "fsl_lpuart_freertos.h"

#define LPUART_CLKSRC BOARD_DEBUG_UART_CLKSRC
#define LPUART_CLK_FREQ CLOCK_GetFreq(BOARD_DEBUG_UART_CLKSRC)
#define uartTask_PRIORITY (configMAX_PRIORITIES - 1)
#define END             0xC0    /* indicates end of packet */
#define ESC             0xDB    /* indicates byte stuffing */
#define ESC_END         0xDC    /* ESC ESC_END means END data byte */
#define ESC_ESC         0xDD    /* ESC ESC_ESC means ESC data byte */


static void uartTask(void *pvParameters);
int sendPacket(uint8_t *p, int len);


typedef struct {
  uint8_t version:4, ihl:4;
  uint8_t tos;
  uint16_t tl;
  uint16_t inden;
//  uint16_t flags:3, fragOffet:13;
  uint16_t flagsOffset;
  uint8_t ttl;
  uint8_t protcol;
  uint16_t checksum;
  uint32_t saddr;
  uint32_t daddr;
} IPv4Header;

uint8_t uartBuffer[128];
const char *to_send = "<html><body><h1>Hello world!</h1></body></html>";
lpuart_rtos_handle_t rtos_handle;
struct _lpuart_handle handle;

lpuart_rtos_config_t lpuart_config = {
    .baudrate = 115200,
    .parity = kLPUART_ParityDisabled,
    .stopbits = kLPUART_OneStopBit,
    .buffer = uartBuffer,
    .buffer_size = sizeof(buffer)
};

int main(void) {
  	/* Init board hardware. */
    BOARD_InitBootPins();
    BOARD_InitBootClocks();

  	/* Init FSL debug console. */
    BOARD_InitDebugConsole();

    // Setup LPUART
    CLOCK_SetLpuartClock(0x2U);
    NVIC_SetPriority(LPUART0_IRQn, 5);
    lpuart_config.srcclk = LPUART_CLK_FREQ;
    lpuart_config.base = LPUART0;

    if (0 > LPUART_RTOS_Init(&rtos_handle, &handle, &lpuart_config))
    {
        return 1;
    }

    xTaskCreate(uartTask, "UartTask", configMINIMAL_STACK_SIZE + 10, NULL, uartTask_PRIORITY, NULL);

    vTaskStartScheduler();
    for (;;);
}

static void uartTask(void *pvParameters)
{
    IPv4Header header = createIPv4Header(strlen(to_send));

    uint16_t packetLen = sizeof(header) + strlen(to_send);
    uint8_t packet[packetLen];
    if (createPacket(header, to_send, strlen(to_send), &packet, packetLen) == 1) {
      vTaskSuspend(NULL);
    }

    if (sendPacket((uint8_t *)&packet, packetSize) == 1) {
        vTaskSuspend(NULL);
    }

    //LPUART_RTOS_Deinit(&rtos_handle);

    vTaskSuspend(NULL);
}

int sendPacket(uint8_t *p, int len) {
  uint8_t c = END;
  if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {
    return 1;
  }

  while(len--) {
    switch(*p) {
      case END:
        c = ESC;
        if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {return 1;}
        c = ESC_END;
        if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {return 1;}
        break;
      case ESC:
        c = ESC;
        if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {return 1;}
        c = ESC_ESC;
        if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {return 1;}
        break;
      default:
        if (0 > LPUART_RTOS_Send(&rtos_handle, p, 1)) {return 1;}
    }
    
    p++;
  }
  
  c = END;
  if (0 > LPUART_RTOS_Send(&rtos_handle, &c, 1)) {
    return 1;
  }

  return 0;
}

int receivePacket() {
  size_t n;
  LPUART_RTOS_Receive(&rtos_handle, recv_buffer, sizeof(recv_buffer), &n);
}

IPv4Header createIPv4Header(uint16_t len) {
  IPv4Header header = {
      .version = 4,
      .ihl = 5,
      .tos = 0,
      .tl = 20 + len,
      .inden = 123,
	  .flagsOffset = 0,
      .ttl = 10,
      .protcol = 6,
      .saddr = 0xC0A80002,
      .daddr = 0xC0A80001,
    }; 

    return header;
}

int createPacket(IPv4Header header, uint8_t *payload, uint16_t payloadSize, uint8_t *buffer, uint16_t length) {
  uint32_t checksum = 0;
  for (int i = 0; i < sizeof(IPv4Header); i += 2) {
    if (i == 5) {
      continue;
    }
    checksum += ((uint16_t *) &header)[i];
  }

  header.checksum = ~((uint16_t)(checksum << 4) + (uint16_t)((checksum & 0x000F0000) >> 16));
  int packetSize = sizeof(IPv4Header) + payloadSize;
  
  if (packetSize > length) {
    return 1;
  }
  
  memcpy(buffer, &header, sizeof(header));
  memcpy(((uint8_t*)&buffer) + sizeof(header), to_send, strlen(to_send));

  return 0;
}

uint8_t* createPingResponse(IPv4Header header, uint8_t *request) {
  IPv4Header requestHeader = (IPv4Header) request;
  uint16_t icmpStart = requestHeader.ihl * 4;
  uint8_t *icmp = request + icmpStart;

  return icmp;
}