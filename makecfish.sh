#!/bin/bash
# makecfish.sh
#
# Build the Windows Vafra Cfish executables for the supported CPU
# architectures and create the corresponding Fritz engine-logo BMP files.
#
# Fritz expects the logo bitmap to have the same base filename as the
# engine executable, for example:
#
#   cfish_v15.1_x86-64-avx2_win.exe
#   cfish_v15.1_x86-64-avx2_win.bmp
#
# The source logo used for Vafra Cfish 15.1 is:
#
#   src/cfish0.bmp


# ---------------------------------------------------------------------------
# Build configuration
# ---------------------------------------------------------------------------

VERSION="v15.1"
LOGO="cfish0.bmp"


# ---------------------------------------------------------------------------
# Install required build tools if they are not already available
# ---------------------------------------------------------------------------

if ! command -v unzip > /dev/null 2>&1; then
    pacman -S --noconfirm unzip
fi

if ! command -v make > /dev/null 2>&1; then
    pacman -S --noconfirm make
fi

if ! command -v g++ > /dev/null 2>&1; then
    pacman -S --noconfirm mingw-w64-x86_64-gcc
fi


# ---------------------------------------------------------------------------
# Move to the Cfish source directory
# ---------------------------------------------------------------------------

cd src || exit 1


# ---------------------------------------------------------------------------
# Verify that the Fritz logo source file exists
# ---------------------------------------------------------------------------

if [ ! -f "$LOGO" ]; then
    echo
    echo "ERROR: Fritz engine logo not found:"
    echo "       src/$LOGO"
    echo
    exit 1
fi


# ---------------------------------------------------------------------------
# Build one Cfish executable and create its matching Fritz logo
# ---------------------------------------------------------------------------

build_cfish()
{
    ARCH="$1"

    EXE="cfish_${VERSION}_${ARCH}_win.exe"
    BMP="cfish_${VERSION}_${ARCH}_win.bmp"

    echo
    echo "============================================================"
    echo "Building Vafra Cfish ${VERSION}: ${ARCH}"
    echo "============================================================"
    echo

    make clean

    if ! make build ARCH="$ARCH"; then
        echo
        echo "ERROR: Build failed for architecture: $ARCH"
        echo
        exit 1
    fi

    mv cfish.exe "$EXE"
    cp "$LOGO" "$BMP"

    echo
    echo "Created:"
    echo "  $EXE"
    echo "  $BMP"
}


# ---------------------------------------------------------------------------
# Build all supported Windows architectures
# ---------------------------------------------------------------------------

build_cfish "x86-64-vnni"

build_cfish "x86-64-avx512"

build_cfish "x86-64-avx2"

build_cfish "x86-64-sse41"


# ---------------------------------------------------------------------------
# Final cleanup
# ---------------------------------------------------------------------------

make clean


# ---------------------------------------------------------------------------
# Return to the repository root
# ---------------------------------------------------------------------------

cd .. || exit 1


# ---------------------------------------------------------------------------
# Finished
# ---------------------------------------------------------------------------

echo
echo "============================================================"
echo "Vafra Cfish ${VERSION} build complete"
echo "============================================================"
echo
