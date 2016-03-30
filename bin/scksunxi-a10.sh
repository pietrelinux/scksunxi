#!/bin/sh
# Descarga dependencias para la compilacion cruzada
sudo apt-get install -y build-essential bin86 kernel-package libqt4-dev wget libncurses5 libncurses5-dev qt4-dev-tools libqt4-dev zlib1g-dev gcc-arm-linux-gnueabihf git debootstrap u-boot-tools device-tree-compiler libusb-1.0-0-dev android-tools-adb android-tools-fastboot
#Descarga kernel sunxi,el u-boot y lsd herramientas de sunxi
git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi.git
git clone -b sunxi https://github.com/linux-sunxi/u-boot-sunxi.git
git clone https://github.com/linux-sunxi/sunxi-tools
#Comprime kernel 
tar -czvf linux-sunxi.tar.gz linux-sunxi/
# Comprime u-boot
tar -czvf uboot.tar.gz u-boot-sunxi/
#Comprime sunxi-tools
sudo  tar -czvf sunxi-tools.tar.gz sunxi-tools/

#Crea script reset
> reset.sh
cat <<+ > reset.sh
#!/bin/sh
rm -r linux-sunxi
rm -r u-boot-sunxi
rm -r sunxi-tools
tar -xzvf linux-sunxi.tar.gz
tar -xzvf uboot.tar.gz  
tar -xzvf sunxi-tools.tar.gz
+

> compile.sh
cat <<+ > compile.sh
#!/bin/sh
cd sunxi-tools
make -j$(nproc)
make install
cd ..
cd linux-sunxi
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
+


