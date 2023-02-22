#!/bin/bash

#仅适用于NDK r25，其他版本的请注意交叉编译工具路径（CROSS_PREFIX）！！！
#armv7-a 
API=21
ARCH=arm
CPU=armv7-a

# 静态/动态库输出路径
PREFIX=./android-ffmpeg/$CPU

# NDK路径
NDK=/home/docker/Tool/android-ndk-r25c

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
CROSS_PREFIX=$TOOLCHAIN/bin/llvm-
SYSROOT=$TOOLCHAIN/sysroot
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU"
# ADDI_LDFLAGS=$NDK/android-21/arch-arm/usr/lib
# 如果使用静态库必须是 17，否则编译Android项目时会报:  error: undefined reference to ‘atof’

./configure \
--prefix=$PREFIX \
--enable-shared \
--disable-static \
--enable-jni \
--disable-mediacodec \
--enable-small \
--disable-doc \
--disable-avdevice \
--enable-asm \
--disable-symver \
--disable-vulkan \
--enable-cross-compile \
--target-os=android \
--cross-prefix=$CROSS_PREFIX \
--arch=$ARCH \
--cpu=$CPU \
--cc=$CC
--cxx=$CXX
--sysroot=$SYSROOT \
--extra-cflags="-mno-stackrealign -Os $OPTIMIZE_CFLAGS -fPIC"


make clean
make -j8
make install


# armv8-a
# ARCH=arm64
# CPU=armv8-a
# CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
# CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
# CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
# OPTIMIZE_CFLAGS="-march=$CPU"
# ADDI_LDFLAGS=$NDK/android-21/arch-arm64/usr/lib