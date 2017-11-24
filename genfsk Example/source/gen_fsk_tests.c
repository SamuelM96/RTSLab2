#include "MemManager.h"
#include "RNG_Interface.h"
#include "TimersManager.h"

#include "genfsk_interface.h"
#include "gen_fsk_tests_states.h"
#include "gen_fsk_tests.h"
#include "xcvr_test_fsk.h"
#include "menus.h"

/*! *********************************************************************************
* Public memory declarations
********************************************************************************** */
/*serial interface id*/
uint8_t mAppSerId;
/*timers manager app timer id*/
uint8_t mAppTmrId;
/*GENFSK instance id*/
uint8_t mAppGenfskId;
/*configuration params*/
ct_config_params_t gaConfigParams[5];

/*! *********************************************************************************
* Private macros
********************************************************************************** */
#define gPerOpcode1 (0xCA)
#define gPerOpcode2 (0xFE)

// #define gRangeOpcode1 (0xAB)
// #define gRangeOpcode2 (0xCD)
/************************************************************************************
* Private prototypes
************************************************************************************/
/* PER RX handler */
static bool_t CT_PacketErrorRateRx(ct_event_t evType, void* pAssociatedValue, bool_t bReInit);
/* PER TX handler */
static bool_t CT_PacketErrorRateTx(ct_event_t evType, void* pAssociatedValue, bool_t bReInit, uint16_t lState);

/************************************************************************************
* Private memory declarations
************************************************************************************/
/* buffers for interaction with Generic FSK */
static uint8_t* gRxBuffer;
static uint8_t* gTxBuffer;

/* Generic FSK packets to get formatted data*/
static GENFSK_packet_t gRxPacket;
static GENFSK_packet_t gTxPacket;

/* control if shortcuts are enabled or disabled*/
static bool_t   bEnableShortcuts = FALSE;

/*hook to notify app thread*/
static pHookAppNotification pNotifyAppThread = NULL;
/*hook to notify app thread*/
static pTmrHookNotification pTmrCallback = NULL;

/*packet configuration*/
static GENFSK_packet_config_t pktConfig = 
{
    .preambleSizeBytes = 0, /*1 byte of preamble*/
    .packetType = gGenfskFormattedPacket,
    .lengthSizeBits = gGenFskDefaultLengthFieldSize_c,
    .lengthBitOrder = gGenfskLengthBitLsbFirst,
    /*sync address bytes = size + 1*/
    .syncAddrSizeBytes = gGenFskDefaultSyncAddrSize_c,
    .lengthAdjBytes = 3, /*length field not including CRC so adjust by crc len*/
    .h0SizeBits = gGenFskDefaultH0FieldSize_c,
    .h1SizeBits = gGenFskDefaultH1FieldSize_c,
    .h0Match = gGenFskDefaultH0Value_c, /*match field containing zeros*/
    .h0Mask = gGenFskDefaultH0Mask_c,
    .h1Match = gGenFskDefaultH1Value_c,
    .h1Mask = gGenFskDefaultH1Mask_c
};

/*CRC configuration*/
static GENFSK_crc_config_t crcConfig =
{
    .crcEnable = gGenfskCrcEnable,
    .crcSize = 3,
    .crcStartByte = 4,
    .crcRefIn = gGenfskCrcInputNoRef,
    .crcRefOut = gGenfskCrcOutputNoRef,
    .crcByteOrder = gGenfskCrcLSByteFirst,
    .crcSeed = 0x00555555,
    .crcPoly = 0x0000065B,
    .crcXorOut = 0
};

/*whitener configuration*/
static GENFSK_whitener_config_t whitenConfig = 
{
    .whitenEnable = gGenfskWhitenEnable,
    .whitenStart = gWhitenStartWhiteningAtH0,
    .whitenEnd = gWhitenEndAtEndOfCrc,
    .whitenB4Crc = gCrcB4Whiten,
    .whitenPolyType = gGaloisPolyType,
    .whitenRefIn = gGenfskWhitenInputNoRef,
    .whitenPayloadReinit = gGenfskWhitenNoPayloadReinit,
    .whitenSize = 7,
    .whitenInit = 0x53,
    .whitenPoly = 0x11, /*x^7 + x^4 + 1! x^7 is never set*/
    .whitenSizeThr = 0,
    .manchesterEn = gGenfskManchesterDisable,
    .manchesterStart = gGenfskManchesterStartAtPayload,
    .manchesterInv = gGenfskManchesterNoInv,
};

/*radio configuration*/
static GENFSK_radio_config_t radioConfig = 
{
    .radioMode = gGenfskGfskBt0p5h0p5,
    .dataRate = gGenfskDR1Mbps
};

/*bit processing configuration*/

/*network / sync address configuration*/
static GENFSK_nwk_addr_match_t ntwkAddr = 
{
    .nwkAddrSizeBytes = gGenFskDefaultSyncAddrSize_c,
    .nwkAddrThrBits = 0,
    .nwkAddr = gGenFskDefaultSyncAddress_c,
}; 

/**********************************************************************************/
void CT_GenFskInit(pHookAppNotification pFunc, pTmrHookNotification pTmrFunc)
{
    bEnableShortcuts = TRUE;

    /*configure hook*/
    pNotifyAppThread = pFunc;
    
    /*configure timer callback*/
    pTmrCallback = pTmrFunc;
    
    /* populate shortcut array */
    gaConfigParams[0].paramType = gParamTypeString_c;
    FLib_MemCpy(gaConfigParams[0].paramName, "Mode", 5);
    FLib_MemCpy(gaConfigParams[0].paramValue.stringValue, "RX", 3);
    if(gDefaultMode_c == gModeTx_c)
    {
        gaConfigParams[0].paramValue.stringValue[0] = 'T';
    }
    gaConfigParams[1].paramType = gParamTypeNumber_c;
    FLib_MemCpy(gaConfigParams[1].paramName, "Channel", 8);
    gaConfigParams[1].paramValue.decValue = gGenFskDefaultChannel_c;
    
    gaConfigParams[2].paramType = gParamTypeNumber_c;
    FLib_MemCpy(gaConfigParams[2].paramName, "Power", 6);
    gaConfigParams[2].paramValue.decValue = gGenFskDefaultTxPowerLevel_c;
    
    gaConfigParams[3].paramType = gParamTypeNumber_c;
    FLib_MemCpy(gaConfigParams[3].paramName, "Payload", 8);
    gaConfigParams[3].paramValue.decValue = gGenFskDefaultPayloadLen_c;
    
    gaConfigParams[4].paramType = gParamTypeMaxType_c;
    /* allocate once to use for the entire application */
    gRxBuffer  = MEM_BufferAlloc(gGenFskDefaultMaxBufferSize_c + 
                                 crcConfig.crcSize);
    gTxBuffer  = MEM_BufferAlloc(gGenFskDefaultMaxBufferSize_c);
    
    gRxPacket.payload = (uint8_t*)MEM_BufferAlloc(gGenFskMaxPayloadLen_c  + 
                                                       crcConfig.crcSize);
    gTxPacket.payload = (uint8_t*)MEM_BufferAlloc(gGenFskMaxPayloadLen_c);
    
    /*prepare the part of the tx packet that is common for all tests*/
    gTxPacket.addr = gGenFskDefaultSyncAddress_c;
    gTxPacket.header.h0Field = gGenFskDefaultH0Value_c;
    gTxPacket.header.h1Field = gGenFskDefaultH1Value_c;
    
    /*set bitrate*/
    GENFSK_RadioConfig(mAppGenfskId, &radioConfig);
    /*set packet config*/
    GENFSK_SetPacketConfig(mAppGenfskId, &pktConfig);
    /*set whitener config*/
    GENFSK_SetWhitenerConfig(mAppGenfskId, &whitenConfig);
    /*set crc config*/
    GENFSK_SetCrcConfig(mAppGenfskId, &crcConfig);
    
    /*set network address at location 0 and enable it*/
    GENFSK_SetNetworkAddress(mAppGenfskId, 0, &ntwkAddr);
    GENFSK_EnableNetworkAddress(mAppGenfskId, 0);
    
    /*set tx power level*/
    GENFSK_SetTxPowerLevel(mAppGenfskId, gGenFskDefaultTxPowerLevel_c);
    /*set channel: Freq = 2360MHz + ChannNumber*1MHz*/
    GENFSK_SetChannelNumber(mAppGenfskId, gGenFskDefaultChannel_c);
}

/****************************************************************************
*****************************Packet error rate*******************************
****************************************************************************/
bool_t CT_PacketErrorRate(ct_event_t evType, void* pAssociatedValue, uint16_t lState)
{
    bool_t bReturnFromSM = FALSE;
    static uint8_t currentTest = 0;
    static uint16_t ledState = 0;
    ledState = lState;
    
    // bReturnFromSM = CT_PacketErrorRateRx(evType, pAssociatedValue, (currentTest != 'R'));
    // currentTest = bReturnFromSM? 0 : 'R';

    bReturnFromSM = CT_PacketErrorRateTx(evType, pAssociatedValue, currentTest != 'T', ledState);
    currentTest = bReturnFromSM? 0 : 'T';

    return bReturnFromSM;
}

/*! *********************************************************************************
* \brief  Handles the Packet error rate RX test
********************************************************************************** */
static bool_t CT_PacketErrorRateRx(ct_event_t evType, 
                                   void* pAssociatedValue, 
                                   bool_t bReInit)
{
    static ct_per_rx_states_t perRxState = gPerRxStateInit_c; 
    static int32_t  i32RssiSum;
    static uint16_t u16ReceivedPackets;
    static uint16_t u16PacketsIndex;  
    static uint16_t u16TotalPackets;
    
    int8_t   i8AverageRssi = 0;
    ct_rx_indication_t* pIndicationInfo = NULL;
    uint8_t* pRxBuffer = NULL;
    bool_t bRestartRx = FALSE;
    bool_t bReturnFromSM = FALSE;
    
    if(bReInit) /* Reset the state machine */
    {
        u16TotalPackets = 0;
        u16ReceivedPackets = 0;
        u16PacketsIndex = 0;
        i32RssiSum = 0;

        Serial_Print(mAppSerId, cu8PerRxMessages[0], gAllowToBlock_d);

        if(gGenfskSuccess_c != GENFSK_StartRx(mAppGenfskId, gRxBuffer, gGenFskDefaultMaxBufferSize_c + crcConfig.crcSize, 0, 0)) {
        	GENFSK_AbortAll();
            Serial_Print(mAppSerId, cu8PerRxMessages[1], gAllowToBlock_d);
            perRxState = gPerRxStateIdle_c;
        }
    }

    /*check if RX related events are fired */
    if(gCtEvtRxDone_c == evType || gCtEvtRxFailed_c == evType || gCtEvtSeqTimeout_c == evType) {
    	/*if rx successful, get packet information */
    	if (gCtEvtRxDone_c == evType) {
                pIndicationInfo = (ct_rx_indication_t*)pAssociatedValue;
                pRxBuffer = pIndicationInfo->pBuffer; /*same as gRxBuffer*/
                
                /*map rx buffer to generic fsk packet*/
                GENFSK_ByteArrayToPacket(mAppGenfskId, pRxBuffer, &gRxPacket);
                if(gRxPacket.payload[4] == gPerOpcode1 && 
                   gRxPacket.payload[5] == gPerOpcode2) /* check if packet payload is PER type */
                {
                    u16TotalPackets = ((uint16_t)gRxPacket.payload[0] <<8) + gRxPacket.payload[1];
                    u16PacketsIndex = ((uint16_t)gRxPacket.payload[2] <<8) + gRxPacket.payload[3];
                    u16ReceivedPackets++;
                    i32RssiSum += (int8_t)(pIndicationInfo->rssi);
                    
                    /* print statistics */
                    PrintPerRxInfo(u16PacketsIndex, u16ReceivedPackets, pIndicationInfo, mAppSerId);
                    
                    bRestartRx = TRUE;
                } 
                else
                {
                    bRestartRx = TRUE;
                }
            }
            else
            {
                bRestartRx = TRUE;
            }

    	/*restart RX immediately with no timeout*/
            if(bRestartRx) {
                if(gGenfskSuccess_c != GENFSK_StartRx(mAppGenfskId, gRxBuffer, gGenFskDefaultMaxBufferSize_c + crcConfig.crcSize, 0, 0)) {
                    GENFSK_AbortAll();
                    Serial_Print(mAppSerId, cu8PerRxMessages[1], gAllowToBlock_d);
                    perRxState = gPerRxStateIdle_c; 
                }
            }  
        }

    if (perRxState == gPerRxStateIdle_c && gCtEvtSelfEvent_c == evType) {
        /* print statistics for PER test */
        i8AverageRssi = u16ReceivedPackets > 0 ? i32RssiSum/u16ReceivedPackets : 0;
        PrintPerRxFinal(u16ReceivedPackets, u16TotalPackets, i8AverageRssi, mAppSerId);
    }

    return bReturnFromSM;      
}

/*! *********************************************************************************
* \brief  Handles the Packet error rate TX test
********************************************************************************** */
static bool_t CT_PacketErrorRateTx(ct_event_t evType, 
                                   void* pAssociatedValue, 
                                   bool_t bReInit,
								   uint16_t ledState)
{
    static ct_per_tx_states_t perTxState = gPerTxStateInit_c;
    static uint32_t miliSecDelay;

    static uint16_t u16TotalPackets = 500;
//    static uint16_t u16SentPackets;
    
    uint16_t buffLen = 0;
    bool_t bReturnFromSM = FALSE;

    if(bReInit) {
        perTxState = gPerTxStateInit_c;
        miliSecDelay = 10;

//        pNotifyAppThread();

        miliSecDelay *= 1000; /*convert into microseconds*/
//        u16SentPackets = 20;
        
        gTxPacket.header.lengthField = (uint16_t)gaConfigParams[3].paramValue.decValue;

        gTxPacket.payload[0] = (u16TotalPackets >> 8);
        gTxPacket.payload[1] = (uint8_t)u16TotalPackets;
        gTxPacket.payload[2] = ((ledState) >> 8);
        gTxPacket.payload[3] = (uint8_t)(ledState);
        gTxPacket.payload[4] = gPerOpcode1;
        gTxPacket.payload[5] = gPerOpcode2;
        
        /*pack everything into a buffer*/
        GENFSK_PacketToByteArray(mAppGenfskId, &gTxPacket, gTxBuffer);
        /*calculate buffer length*/
        buffLen = gTxPacket.header.lengthField+
                    (gGenFskDefaultHeaderSizeBytes_c)+
                        (gGenFskDefaultSyncAddrSize_c + 1);
                
        if(gGenfskSuccess_c != /*start tx at current time + input delay*/
           GENFSK_StartTx(mAppGenfskId, gTxBuffer, buffLen, 0))
        {
            GENFSK_AbortAll();
            Serial_Print(mAppSerId, cu8PerTxMessages[2], gAllowToBlock_d);
            perTxState = gPerTxStateIdle_c;
        }
//        u16SentPackets++;
        Serial_Print(mAppSerId, cu8PerTxMessages[3], gAllowToBlock_d);
        Serial_PrintDec(mAppSerId, (uint32_t)u16TotalPackets);
        
        perTxState = gPerTxStateRunningTest_c;
    }

    if (perTxState == gPerTxStateRunningTest_c) {
        if(gCtEvtTxDone_c == evType) {
            PrintPerTxPackets(ledState,
                              (gGenfskSuccess == *((genfskEventStatus_t*)pAssociatedValue)),
                              mAppSerId);
            
//            if(u16SentPackets == u16TotalPackets) {
//                Serial_Print(mAppSerId, cu8PerTxMessages[4], gAllowToBlock_d);
//                perTxState = gPerTxStateIdle_c;
//            } else {
                gTxPacket.payload[2] = ((ledState) >> 8);
                gTxPacket.payload[3] = (uint8_t)(ledState);
                /*pack everything into a buffer*/
                GENFSK_PacketToByteArray(mAppGenfskId, &gTxPacket, gTxBuffer);
                /*calculate buffer length*/
                buffLen = gTxPacket.header.lengthField+
                    (gGenFskDefaultHeaderSizeBytes_c)+
                        (gGenFskDefaultSyncAddrSize_c + 1);
                
                if(gGenfskSuccess_c != GENFSK_StartTx(mAppGenfskId, gTxBuffer, buffLen, GENFSK_GetTimestamp() + miliSecDelay)) {
                    GENFSK_AbortAll();
                    Serial_Print(mAppSerId, cu8PerTxMessages[5], gAllowToBlock_d);
                    perTxState = gPerTxStateIdle_c;
                }
                
//                u16SentPackets++;
//            }
        }
    } else {
            pNotifyAppThread();
    }
    
    return bReturnFromSM;      
}

