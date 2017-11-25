################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../startup/startup_MKW41Z4.S 

OBJS += \
./startup/startup_MKW41Z4.o 


# Each subdirectory must supply rules for building sources it contributes
startup/%.o: ../startup/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: MCU Assembler'
	arm-none-eabi-gcc -c -x assembler-with-cpp -D__REDLIB__ -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\drivers" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\genfsk" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4\XCVR_Test" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MemManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\freertos" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Keyboard\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\SPI_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Lists" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\common" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\UART_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\board" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\RNG\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\ModuleInfo" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\GPIO" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\CMSIS" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\utilities" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SecLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\OSAbstraction\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\FunctionLib" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Flash\Internal" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Interface\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LowPower\Source\MKW41Z" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\MWSCoexistence\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\XCVR\MKW41Z4" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Messaging\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\TimersManager\Source" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\LED\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\Panic\Interface" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\SerialManager\Source\I2C_Adapter" -I"C:\Users\Samuel Mott\Documents\RTSLab2\LED_Radio\framework\DCDC\Interface" -g3 -mcpu=cortex-m0plus -mthumb -D__REDLIB__ -specs=redlib.specs -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


