#program name
PROG = xclickroot

# paths
PREFIX = ${HOME}/.local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# includes and libs
INCS = -I${X11INC}
LIBS = -L${X11LIB} -lX11

# flags
CPPFLAGS =
CFLAGS = -Wall -Wextra ${INCS}
LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
