################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../framework/ModuleInfo/ModuleInfo.c 

OBJS += \
./framework/ModuleInfo/ModuleInfo.o 

C_DEPS += \
./framework/ModuleInfo/ModuleInfo.d 


# Each subdirectory must supply rules for building sources it contributes
framework/ModuleInfo/%.o: ../framework/ModuleInfo/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -std=gnu99 -DDEBUG -DFSL_RTOS_FREE_RTOS -DFRDM_KW41Z -DFREEDOM -D__MCUXPRESSO -D__USE_CMSIS -DSDK_OS_FREE_RTOS -DCPU_MKW41Z512VHT4 -DCPU_MKW41Z512VHT4_cm0plus -D__REDLIB__ -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\drivers" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\genfsk" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4\XCVR_Test" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MemManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\freertos" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Keyboard\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\SPI_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Lists" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\common" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\UART_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\board" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\RNG\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\ModuleInfo" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\GPIO" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\CMSIS" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\utilities" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SecLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\OSAbstraction\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\FunctionLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Flash\Internal" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Interface\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Source\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MWSCoexistence\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Messaging\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LED\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Panic\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\I2C_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\DCDC\Interface" -O0 -fno-common -g -Wall -c  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin -imacros "C:/Users/Samuel Mott/Documents/RTSLab2/LED_Radio/source/app_preinclude.h" -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


