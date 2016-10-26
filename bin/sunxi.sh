#!/bin/sh
# Descarga dependencias para la compilacion cruzada
echo # Descarga dependencias para la compilacion cruzada#
apt-get install -y build-essential bin86 kernel-package libqt4-dev wget libncurses5 libncurses5-dev qt4-dev-tools libqt4-dev zlib1g-dev gcc-arm-linux-gnueabihf git debootstrap u-boot-tools device-tree-compiler libusb-1.0-0-dev android-tools-adb android-tools-fastboot qemu-user-static

mkdir sunxi
mkdir sunxi/kernel/
mkdir sunxi/u-boot/
mkdir sunxi/tools/
mkdir sunxi/rootfs/

mkdir sunxi/kernel/3-4
mkdir sunxi/kernel/3-4/output

mkdir sunxi/kernel/next/
mkdir sunxi/kernel/next/output

mkdir sunxi/kernel/allwinner/
mkdir sunxi/kernel/allwinner/output

mkdir sunxi/kernel/mainline/
mkdir sunxi/kernel/mainline/output

mkdir sunxi/u-boot/sunxi/
mkdir sunxi/u-boot/sunxi/output

mkdir sunxi/u-boot/denx/
mkdir sunxi/u-boot/denx/output

mkdir sunxi/u-boot/allwinner/
mkdir sunxi/u-boot/allwinner/output

mkdir sunxi/rootfs/output

mkdir sunxi/tools/sunxi
mkdir sunxi/tools/chip



#Descarga las distintas versiones de kernel para allwinner disponibles,así como el u-boot y las herramientas de sunxi
echo #Descarga las distintas versiones de kernel para allwinner disponibles,así como el u-boot y las herramientas de sunxi


# sunxi-tools
git clone https://github.com/linux-sunxi/sunxi-tools sunxi/tools/sunxi/sunxi-tools
tar -czvf sunxi-tools.tar.gz sunxi/tools/sunxi/sunxi-tools/
mv sunxi-tools.tar.gz sunxi/tools/sunxi/

# script tools x86
> sunxi/tools/sunxi/toolsx86.sh
cat <<+ > sunxi/tools/sunxi/toolsx86.sh
#!/bin/sh
rm -r sunxi/tools/sunxi/sunxi-tools/
tar -xzvf sunxi-tools.tar.gz
cd sunxi-tools
make -j$(nproc)
make install
+
# kernel 

# kernel Sunxi 3.4
git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi.git sunxi/kernel/3-4/linux-sunxi
tar -czvf linux-sunxi.tar.gz sunxi/kernel/3-4/linux-sunxi
mv linux-sunxi.tar.gz sunxi/kernel/3-4/

# Script kernel Sunxi 3.4
> sunxi/kernel/3-4/linux-sunxi.sh
cat <<+ > sunxi/kernel/3-4/linux-sunxi.sh
#!/bin/sh
rm -r linux-sunxi
tar -xzvf linux-sunxi.tar.gz
cd linux-sunxi
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
cp arch/arm/boot/uImage sunxi/kernel/3-4/output 
cp output/lib sunxi/kernel/3-4/output
+

# Kernel Next
git clone git://github.com/linux-sunxi/linux-sunxi.git -b sunxi/kernel/next/linux-sunxi
tar -czvf linux-sunxi.tar.gz sunxi/kernel/next/linux-sunxi/
mv linux-sunxi.tar.gz sunxi/kernel/next/
# Script Kernel Next 
> sunxi/kernel/next/linux-sunxi.sh
cat <<+ > sunxi/kernel/next/linux-sunxi.sh
#!/bin/sh
rm -r linux-sunxi
tar -xzvf linux-sunxi.tar.gz
cd linux-sunxi
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
cp arch/arm/boot/uImage sunxi/kernel/next/output 
cp -r output/lib sunxi/kernel/next/output
+

# Kernel Allwinner
git clone  https://github.com/allwinner-zh/linux-3.4-sunxi.git sunxi/kernel/allwinner/linux-3.4-sunxi
tar -czvf linux-3.4-sunxi.tar.gz sunxi/kernel/allwinner/linux-3.4-sunxi
mv linux-3.4-sunxi.tar.gz sunxi/kernel/allwinner/

# Script Kernel Allwinner  
> sunxi/kernel/allwinner/allwinner.sh
cat <<+ > sunxi/kernel/allwinner/allwinner.sh
#!/bin/sh
rm -r linux-3.4-sunxi
tar -xzvf linux-3.4-sunxi.tar.gz
cd linux-3.4-sunxi
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
cp arch/arm/boot/uImage sunxi/kernel/allwinner/output 
cp -r output/lib sunxi/kernel/allwinner/output
+

# Kernel Mainline
git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  sunxi/kernel/mainline/linux
tar -czvf linux.tar.gz sunxi/kernel/mainline/linux
mv linux.tar.gz sunxi/kernel/mainline/
# Script Kernel mainline
> sunxi/kernel/mainline/linux.sh
cat <<+ > sunxi/kernel/mainline/linux.sh
#!/bin/sh
rm -r linux
tar -xzvf linux.tar.gz
cd linux
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage dtbs
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
+
# u-boot 

# u-boot Sunxi
git clone -b sunxi https://github.com/linux-sunxi/u-boot-sunxi.git sunxi/u-boot/sunxi/u-boot-sunxi 
tar -czvf u-boot-sunxi.tar.gz  sunxi/u-boot/sunxi/u-boot-sunxi
mv u-boot-sunxi.tar.gz sunxi/u-boot/sunxi/

# script U-boot sunxi
> sunxi/u-boot/sunxi/u-boot.sh
cat <<+ > sunxi/u-boot/sunxi/u-boot.sh
#!/bin/sh
rm -r u-boot-sunxi
tar -xzvf u-boot-sunxi
cd u-boot-sunxi
+
# u-boot Denx
git clone git://git.denx.de/u-boot-sunxi.git sunxi/u-boot/denx/u-boot-sunxi
tar -czvf u-boot-sunxi.tar.gz  sunxi/u-boot/denx/u-boot-sunxi
mv u-boot-sunxi.tar.gz  sunxi/u-boot/denx/

# script U-boot denx
> sunxi/u-boot/denx/u-boot.sh
cat <<+ > sunxi/u-boot/denx/u-boot.sh
#!/bin/sh
rm -r u-boot-sunxi
tar -xzvf u-boot-sunxi
cd u-boot-sunxi
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
+
# u-boot allwinner
git clone https://github.com/allwinner-zh/bootloader.git sunxi/u-boot/allwinner/bootloader
tar -czvf bootloader.tar.gz sunxi/u-boot/allwinner/bootloader
mv bootloader.tar.gz sunxi/u-boot/allwinner/
# script U-boot allwinner
> sunxi/u-boot/allwinner/allwinner.sh
cat <<+ > sunxi/u-boot/allwinner/allwinner.sh
#!/bin/sh
rm -r u-bootloader
tar -xzvf bootloader
cd bootloader
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
+
# sacar .config a output
# rootfs

git clone https://github.com/pietrelinux/rootfs sunxi/rootfs

