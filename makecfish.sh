#!/bin/bash
# makecfish.sh

# install packages if not already installed
unzip -v &> /dev/null || pacman -S --noconfirm unzip
make -v &> /dev/null || pacman -S --noconfirm make
g++ -v &> /dev/null || pacman -S --noconfirm mingw-w64-x86_64-gcc

cd src

# build Cfish executable
make clean
make build ARCH=x86-64-vnni
mv cfish.exe cfish_v15.0_x86-64-vnni_win.exe
cp cfish.bmp cfish_v15.0_x86-64-vnni_win.bmp
make clean
make build ARCH=x86-64-avx512
mv cfish.exe cfish_v15.0_x86-64-avx512_win.exe
cp cfish.bmp cfish_v15.0_x86-64-avx512_win.bmp
make clean
make build ARCH=x86-64-avx2 
mv cfish.exe cfish_v15.0_x86-64-avx2_win.exe
cp cfish.bmp cfish_v15.0_x86-64-avx2_win.bmp
make clean
make build ARCH=x86-64-sse41
mv cfish.exe cfish_v15.0_x86-64-sse41_win.exe
cp cfish.bmp cfish_v15.0_x86-64-sse41_win.bmp
make clean
cd ..
