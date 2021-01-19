#!/bin/bash

## F1C100S
#make ARCH=arm CROSS_COMPILE=/mywork/f1c100s/f1c100s-tools/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi- licheepi_nano_spinand_defconfig
#make ARCH=arm CROSS_COMPILE=/mywork/f1c100s/f1c100s-tools/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-

## H3
make ARCH=arm DEBUG=1 CROSS_COMPILE=/work/tools/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- orangepi_zero_defconfig
make ARCH=arm DEBUG=1 CROSS_COMPILE=/work/tools/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-


if [ -f u-boot-sunxi-with-spl.bin ]; then
	UBOOOFFSET=$(cat u-boot.cfg | grep CONFIG_SYS_SPI_U_BOOT_OFFS | awk '{print $3}' | sed -n '1,1p')
	if [ "$UBOOOFFSET" == "0x8000" ]; then
		cp u-boot-sunxi-with-spl.bin uboot-with-spl-usb.bin
		echo "please delete GZYS_USBBURN in include/configs/sunxi-common.h file and rebuild to create spi nand image"
	else
		./f1c100_uboot_spinand.sh uboot-with-spl-spinand.bin u-boot-sunxi-with-spl.bin
		echo "burn uboot-with-spl-spinand.bin to spi nand"
		echo "cmd is sunxi-fel uboot uboot-with-spl-usb.bin write 0x80000000 uboot-with-spl-spinand.bin"
	fi
else
	echo "ERROR"
fi
echo "DONE"





