# scksunxi

This script automates the process of preparing to work on the kernel, the u- boot and tools sunxi

How to use and how it works

1 Install dependencies , tools and toolchain

2 Download the last tree kernel sunxi

3 Download the last tree u-boot sunxi

4 Download the sunxi-tools

5 compresses the kernel, u- boot and sunxi tools

6 Create scripts:

Reset.sh:

Erase folders linux-sunxi and u-boot and extract kernel and uboot previously compressed

kernel.sh:

compile xconfig menu for to configure it to your liking and compile kernel with modules

u-boot.sh:

Prepare and help to compile u-boot for your board

tools.sh

extract sunxi-tools, compile this and install
