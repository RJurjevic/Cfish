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
mv cfish.exe cfish_v12.4_x86-64_vnni_windows.exe
cp cfish.bmp cfish_v12.4_x86-64_vnni_windows.bmp
make clean
make build ARCH=x86-64-avx512
mv cfish.exe cfish_v12.4_x86-64_avx512_windows.exe
cp cfish.bmp cfish_v12.4_x86-64_avx512_windows.bmp
make clean
make build ARCH=x86-64-avx2 
mv cfish.exe cfish_v12.4_x86-64_avx2_windows.exe
cp cfish.bmp cfish_v12.4_x86-64_avx2_windows.bmp
make clean
make build ARCH=x86-64-sse41
mv cfish.exe cfish_v12.4_x86-64_sse41_windows.exe
cp cfish.bmp cfish_v12.4_x86-64_sse41_windows.bmp
make clean
cd ..
