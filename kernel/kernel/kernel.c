#include <stdio.h>

#include <kernel/tty.h>

void kenel_main(void) {
	terminal_initialize();
	printf("Fobos v0.1\n");
}
