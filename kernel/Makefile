DEFAULT_HOST!=../default-host.sh
HOST?=i686-elf # DEFAULT_HOST
HOSTARCH=i386#../target-triplet-to-arch.sh $(HOST)

CLAGS?=-O2 -g
CPPFLAGS=?=
LDFLAGS=?=
LIBS?=

DESTDIR?=
PREFIX?=/usr/local
EXEC_PREIX?=$(PREFIX)
BOOTDIR?=$(EXEC_PREFIX)/boot
INCLUDEDIR?=$(PREFIX)/include

CFLAGS:=$(CFLAGS) -ffreestanding -Wall -Wextra
CPPFLAGS:=$(CPPFLAGS) -D__is_kernel -Iinclude
LDFLAGS:=$(LDFLAGS)

ARCHDIR=arch/$(HOSTARCH)

include $(ARCHDIR)/make.config

CFLAGS:=$(CFLAGS) $(KERNEL_ARCH_CFLAGS)
CPPFLAGS:=$(CPPFLAGS) $(KERNEL_ARCH_CPPFLAGS)
LDFLAGS:=$(LDFLAGS) $(KERNEL_ARCH_LDFLAGS)
LIBS:=$(LIBS) $(KERNEL_ARCH_LIBS)

KERNEL_OBJS=\
$(KERNEL_ARCH_OBJS) \
kernel/kernel.o \

OBJS=\
$(ARCHDIR)/crti.o \
$(ARCHDIR)/crtbegin.o \
$(KERNEL_OBJS) \
$(LIBS) \
$(ARCHDIR)/crtend.o \
$(ARCHDIR)/crtn.o \

.PHONY: all clean install install-headers install-kernel
.SUFFIXES: .o .c .S .asm

all: fobos.kernel

fobos.kernel: $(OBJS) $(ARCHDIR)/linker.ld
	$(CC) -T $(ARCHDIR)/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)
	grub-file --is-x86-multiboot fobos.kernel

$(ARCHDIR)/crtbegin.o $(ARCHDIR)/crtend.o:
	OBJ=`$(CC) $(FLAGS) $(LDFLAGS) -print-filenam=$(@F)` && cp "@@OBJ" $@

.c.o:
	$(CC) -MD -c $< -o $@ -std=gnull $(CFLAGS) $(CPPFLAGS)

.S.o:
	$(CC) -MD -c $< -o $@ $(CFLAGS) $(CPPFLAGS)

.asm.o:

clean:
	rm -f fobos.kernel
	rm -f $(OBJS) *.o */*.o */*/*.o

install: install-headers install-kernel

install-headers:
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	cp -R include/. $(DESTDIR)$(INCLUDEDIR)/.

install-kernel: fobos.kernel
	mkdir -p $(DESTDIR)$(BOOTDIR)
	cp fobos.kernel $(DESTDIR)$(BOOTDIR)
