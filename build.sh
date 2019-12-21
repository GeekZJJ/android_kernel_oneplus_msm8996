#!/bin/bash

#export PATH="/usr/lib/ccache:$PATH"
export USE_CCACHE=1

#export PATH=$PATH:/root/aarch64-linux-android-4.9/bin
export CROSS_COMPILE="ccache aarch64-linux-android-"

export ARCH=arm64
export SRCARCH=arm64
export SUBARCH=arm64

#make -j1 V=1 O=out
#exit
mkdir -p out && make clean O=out && make mrproper O=out && make msm-perf_defconfig O=out && time make -j5 O=out INSTALL_MOD_STRIP=1
make O=out/ INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=release/ modules_install
mkdir -p release/
rm release/*.ko release/Image.gz-dtb release/geekzjj-oos-pie.zip
find out/release/lib -name "*.ko" | xargs -i cp {} release/
cp out/arch/arm64/boot/Image.gz-dtb release/
cp out/arch/arm64/boot/Image.gz-dtb release/zip/kernel/
cd release/zip
zip -r ../geekzjj-oos-pie.zip *
