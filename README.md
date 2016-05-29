Scksunxi es un script que se encarga de descargar y preparar el entorno de compilación adecuado para instalat linux en dispositivos allwinner, este script genera 4 carpetas centrales

Kernel
U-Boot
Rootfs
sunxi-Tools

Dentro de cada una de estas carpetas estan los direferentes versiones de kernel,u-boot,el script de instalación de un rootfs.img con un sistema completo Lubuntu 14 y por ultimo las sunxi tools así como las tools modificadas de chip 

Todas las carpetas tienen una misma estructura

script.sh (Elimina codigo fuente original, descomprime el codigo fuente y compila de nuevo el codigo con la salida a la carpeta output)
Codigo-fuente
Fuentes comprimidas.tar.gz
output (el resultado de la compilación del script)

├── kernel
│   ├── 3-4
│   │   ├── kernel3-4.sh
│   │   ├── linux-sunxi
│   │   ├── linux-sunxi.tar.gz
│   │   └── output
│   ├── allwinner
│   │   ├── allwinner.sh
│   │   ├── linux-3.4-sunxi
│   │   ├── linux-3.4-sunxi.tar.gz
│   │   └── output
│   ├── mainline
│   │   ├── linux
│   │   ├── linux.tar.gz
│   │   ├── mainline.sh
│   │   └── output
│   └── next
│       ├── linux-sunxi.tar.gz
│       ├── next.sh
│       └── output
├── rootfs
│   ├── LICENSE
│   ├── output
│   ├── README.md
│   └── rootfs.sh
├── tools
│   ├── chip
│   └── sunxi
│       ├── sunxi-tools.tar.gz
│       └── toolsx86.sh
└── u-boot
    ├── allwinner
    │   ├── allwinner.sh
    │   ├── bootloader
    │   ├── bootloader.tar.gz
    │   └── output
    ├── denx
    │   ├── output
    │   ├── u-boot.sh
    │   ├── u-boot-sunxi
    │   └── u-boot-sunxi.tar.gz
    └── sunxi
        ├── output
        ├── u-boot.sh
        └── u-boot-sunxi.tar.gz
