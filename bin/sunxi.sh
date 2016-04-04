#!/bin/sh
# Descarga dependencias para la compilacion cruzada
sudo apt-get install -y build-essential bin86 kernel-package libqt4-dev wget libncurses5 libncurses5-dev qt4-dev-tools libqt4-dev zlib1g-dev gcc-arm-linux-gnueabihf git debootstrap u-boot-tools device-tree-compiler libusb-1.0-0-dev android-tools-adb android-tools-fastboot qemu-user-static
#Descarga kernel sunxi,el u-boot y lsd herramientas de sunxi
git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi.git
git clone git://git.denx.de/u-boot-sunxi.git
git clone https://github.com/linux-sunxi/sunxi-tools
#Comprime kernel 
tar -czvf linux-sunxi.tar.gz linux-sunxi/
# Comprime u-boot
tar -czvf u-boot-sunxi.tar.gz  u-boot-sunxi/
#Comprime sunxi-tools
tar -czvf sunxi-tools.tar.gz sunxi-tools/

#Crea script reset
> reset.sh
cat <<+ > reset.sh
#!/bin/sh
rm -r linux-sunxi
rm -r u-boot-sunxi
rm -r sunxi-tools
tar -xzvf linux-sunxi.tar.gz
tar -xzvf u-boot-sunxi.tar.gz
tar -xzvf sunxi-tools.tar.gz
+

> kernel.sh
cat <<+ > kernel.sh
#!/bin/sh
echo "Remember,in xconfig menu load defconfig for your board click in load and locate in /arch/arm/configs"
sleep 5
cd linux-sunxi
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
+

> u-boot.sh
cat <<+ > u-boot.sh
#!/bin/sh
cd u-boot-sunxi/
echo "Now select your board configs to the folder and make CROSS_COMPILE=arm-linux-gnueabihf- <board_name>_defconfig"
sleep 5
cd u-boot-sunxi/
ls configs
echo "Remember,make -j$(nproc) CROSS_COMPILE=arm-linux-gnueabihf- <board_name>_defconfig"
+

> tools.sh
cat <<+ > tools.sh
#!/bin/sh
cd sunxi-tools
make -j$(nproc)
make install

