################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ant_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ble_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_common_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p3_h_0p5_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p32_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p5_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p7_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_1p0_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p7_h_0p5_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_mode_datarate_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_msk_config.c \
../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_zgbe_config.c 

OBJS += \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ant_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ble_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_common_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p3_h_0p5_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p32_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p5_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p7_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_1p0_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p7_h_0p5_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_mode_datarate_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_msk_config.o \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_zgbe_config.o 

C_DEPS += \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ant_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_ble_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_common_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p3_h_0p5_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p32_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p5_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_0p7_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p5_h_1p0_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_gfsk_bt_0p7_h_0p5_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_mode_datarate_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_msk_config.d \
./framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/fsl_xcvr_zgbe_config.d 


# Each subdirectory must supply rules for building sources it contributes
framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/%.o: ../framework/XCVR/MKW41Z4/cfgs_kw4x_3x_2x/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu99 -DDEBUG -DFSL_RTOS_FREE_RTOS -DFRDM_KW41Z -DFREEDOM -D__MCUXPRESSO -D__USE_CMSIS -DSDK_OS_FREE_RTOS -DCPU_MKW41Z512VHT4 -DCPU_MKW41Z512VHT4_cm0plus -D__REDLIB__ -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\drivers" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\genfsk" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4\XCVR_Test" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MemManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\freertos" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Keyboard\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\SPI_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Lists" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\common" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\UART_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\board" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\RNG\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\ModuleInfo" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\GPIO" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\CMSIS" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\utilities" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SecLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\OSAbstraction\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\FunctionLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Flash\Internal" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Interface\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Source\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MWSCoexistence\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Messaging\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LED\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Panic\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\I2C_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\DCDC\Interface" -O0 -fno-common -g -Wall -c  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin -imacros "C:/Users/Samuel Mott/Documents/RTSLab2/LED_Radio/source/app_preinclude.h" -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


