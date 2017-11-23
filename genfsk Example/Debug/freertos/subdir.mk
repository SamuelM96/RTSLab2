################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../freertos/croutine.c \
../freertos/event_groups.c \
../freertos/fsl_tickless_lptmr.c \
../freertos/fsl_tickless_systick.c \
../freertos/heap_4.c \
../freertos/list.c \
../freertos/port.c \
../freertos/queue.c \
../freertos/tasks.c \
../freertos/timers.c 

OBJS += \
./freertos/croutine.o \
./freertos/event_groups.o \
./freertos/fsl_tickless_lptmr.o \
./freertos/fsl_tickless_systick.o \
./freertos/heap_4.o \
./freertos/list.o \
./freertos/port.o \
./freertos/queue.o \
./freertos/tasks.o \
./freertos/timers.o 

C_DEPS += \
./freertos/croutine.d \
./freertos/event_groups.d \
./freertos/fsl_tickless_lptmr.d \
./freertos/fsl_tickless_systick.d \
./freertos/heap_4.d \
./freertos/list.d \
./freertos/port.d \
./freertos/queue.d \
./freertos/tasks.d \
./freertos/timers.d 


# Each subdirectory must supply rules for building sources it contributes
freertos/%.o: ../freertos/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu99 -DDEBUG -DFSL_RTOS_FREE_RTOS -DFRDM_KW41Z -DFREEDOM -D__MCUXPRESSO -D__USE_CMSIS -DSDK_OS_FREE_RTOS -DCPU_MKW41Z512VHT4 -DCPU_MKW41Z512VHT4_cm0plus -D__REDLIB__ -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\drivers" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\genfsk" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\XCVR\MKW41Z4\XCVR_Test" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\MemManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\freertos" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Keyboard\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\SPI_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Lists" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\common" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\UART_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\board" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\RNG\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\ModuleInfo" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\GPIO" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\CMSIS" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\utilities" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SecLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\OSAbstraction\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\FunctionLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Flash\Internal" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LowPower\Interface\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LowPower\Source\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\MWSCoexistence\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\XCVR\MKW41Z4" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Messaging\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\TimersManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\TimersManager\Source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\LED\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\Panic\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\SerialManager\Source\I2C_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\genfsk Example\framework\DCDC\Interface" -O0 -fno-common -g -Wall -c  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin -imacros "C:/Users/Samuel Mott/Documents/RTSLab2/genfsk Example/source/app_preinclude.h" -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


