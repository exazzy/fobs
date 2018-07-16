#!/bin/sh
set -e
. ./build.sh
 
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub
 
cp sysroot/boot/fobos.kernel isodir/boot/forobs.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "fobos" {
	multiboot /boot/fobos.kernel
}
EOF
grub-mkrescue -o fobos.iso isodir
