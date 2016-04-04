# scksunxi

## The idea


This script automates the process of preparing the enviroment to build the kernel,the u-boot,sunxi-tools,also compress everything and create the scripts to decompress a kernel,u-boot and sunxi-tools for recompile,this way you do not have to re-download everything again.


## How to use:

Download this script with git:

git clone https://github.com/pietrelinux/scksunxi.git

execute script:

sudo sh scksunxi/bin/sunxi.sh

## How it works:

1 Install dependencies , tools and toolchain

2 Download the last  kernel tree sunxi

3 Download the last tree u-boot sunxi

4 Download the sunxi-tools

5 compresses the kernel, u- boot and sunxi tools

6 Create scripts:

## scripts

### Reset.sh

Erase folders linux-sunxi and u-boot and extract kernel and uboot previously compressed

### kernel.sh

Compile xconfig menu for to configure it to your liking and compile kernel with modules

### u-boot.sh

Prepare and help to compile u-boot for your board.

### tools.sh

Extract sunxi-tools, compile this and install.
