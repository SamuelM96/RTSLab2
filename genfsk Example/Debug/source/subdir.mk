################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../source/genfsk.c \
../source/led_radio.c \
../source/ppp-webserver.c \
../source/sha1.c 

OBJS += \
./source/genfsk.o \
./source/led_radio.o \
./source/ppp-webserver.o \
./source/sha1.o 

C_DEPS += \
./source/genfsk.d \
./source/led_radio.d \
./source/ppp-webserver.d \
./source/sha1.d 


# Each subdirectory must supply rules for building sources it contributes
source/%.o: ../source/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu99 -DDEBUG -DFSL_RTOS_FREE_RTOS -DFRDM_KW41Z -DFREEDOM -D__MCUXPRESSO -D__USE_CMSIS -DSDK_OS_FREE_RTOS -DCPU_MKW41Z512VHT4 -DCPU_MKW41Z512VHT4_cm0plus -D__REDLIB__ -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\drivers" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\genfsk" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\XCVR\MKW41Z4\XCVR_Test" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\MemManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\freertos" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Keyboard\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\SPI_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Lists" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\common" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\UART_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\board" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\RNG\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\ModuleInfo" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\GPIO" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\CMSIS" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\utilities" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SecLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\OSAbstraction\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\FunctionLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Flash\Internal" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LowPower\Interface\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LowPower\Source\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\MWSCoexistence\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\XCVR\MKW41Z4" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Messaging\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\TimersManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\TimersManager\Source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LED\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Panic\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\I2C_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\DCDC\Interface" -O0 -fno-common -g -Wall -c  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin -imacros "C:/Users/Samuel Mott/Documents/RTSLab2/genfsk Example/source/app_preinclude.h" -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


