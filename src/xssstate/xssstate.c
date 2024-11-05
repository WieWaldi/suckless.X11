/*
 * See LICENSE file for copyright and license details.
 */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdbool.h>
#include <libgen.h>
#include <X11/extensions/scrnsaver.h>

#include "arg.h"

char *argv0;

void
die(const char *errstr, ...) {
	va_list ap;

	va_start(ap, errstr);
	vfprintf(stderr, errstr, ap);
	va_end(ap);
	exit(EXIT_FAILURE);
}

void
usage(void)
{
	die("usage: %s [-istv]\n", basename(argv0));
}

int
main(int argc, char *argv[]) {
	XScreenSaverInfo *info;
	Display *dpy;
	int base, errbase;
	Bool showstate, showtill, showidle;

	showstate = false;
	showtill = false;
	showidle = false;

	ARGBEGIN {
	case 'i':
		showidle = true;
		break;
	case 's':
		showstate = true;
		break;
	case 't':
		showtill = true;
		break;
	case 'v':
		die("xssstate-"VERSION", © 2008-2016 xssstate engineers"
				", see LICENSE for details.\n");
	default:
		usage();
	} ARGEND;

	if (!showstate && !showtill && !showidle)
		usage();

	if (!(dpy = XOpenDisplay(0)))
		die("Cannot open display.\n");

	if (!XScreenSaverQueryExtension(dpy, &base, &errbase))
		die("Screensaver extension not activated.\n");

	info = XScreenSaverAllocInfo();
	XScreenSaverQueryInfo(dpy, DefaultRootWindow(dpy), info);

	if (showstate) {
		switch(info->state) {
		case ScreenSaverOn:
			printf("on\n");
			break;
		case ScreenSaverOff:
			printf("off\n");
			break;
		case ScreenSaverDisabled:
			printf("disabled\n");
			break;
		}
	} else if (showtill) {
		switch(info->state) {
		case ScreenSaverOn:
			printf("0\n");
			break;
		case ScreenSaverOff:
			printf("%lu\n", info->til_or_since);
			break;
		case ScreenSaverDisabled:
			printf("-1\n");
			break;
		}
	} else if (showidle) {
		printf("%lu\n", info->idle);
	}


	XCloseDisplay(dpy);

	return 0;
}

