#!/bin/sh
sudo apt-get install -y build-essential bin86 kernel-package libqt4-dev wget libncurses5 libncurses5-dev qt4-dev-tools libqt4-dev zlib1g-dev gcc-arm-linux-gnueabihf git debootstrap u-boot-tools device-tree-compiler 
git clone -b sunxi-3.4 https://github.com/linux-sunxi/linux-sunxi.git
tar -czvf linux-sunxi.tar.gz linux-sunxi/
> reset.sh
cat <<+ > reset.sh
#!/bin/sh
rm -r linux-sunxi
tar -xzvf linux-sunxi.tar.gz
cd linux-sunxi
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
+
> compile.sh
cat <<+ > compile.sh
#!/bin/sh
make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install
cd linux-sunxi
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- xconfig
