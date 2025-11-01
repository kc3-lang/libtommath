## kc3
## Copyright from 2022 to 2025 kmx.io <contact@kmx.io>
##
## Permission is hereby granted to use this software granted the above
## copyright notice and this permission paragraph are included in all
## copies and substantial portions of this software.
##
## THIS SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY GUARANTEE OF
## PURPOSE AND PERFORMANCE. IN NO EVENT WHATSOEVER SHALL THE
## AUTHOR BE CONSIDERED LIABLE FOR THE USE AND PERFORMANCE OF
## THIS SOFTWARE.

all:
	${MAKE} build
	if ${HAVE_GCOV}; then ${MAKE} cov; fi
	${MAKE} debug
	if ${HAVE_ASAN}; then ${MAKE} asan; fi

include config.mk
include sources.mk

asan: ${OBJECTS_ASAN}

build: ${OBJECTS}

cov: ${OBJECTS_COV}

debug: ${OBJECTS_DEBUG}

gcovr:
	gcovr --gcov-executable ${GCOV} --html-details libtommath.html

install:
	${INSTALL} -o ${OWNER} -g ${GROUP} -m 0755 -d ${DESTDIR}${prefix}/include/libtommath
	${INSTALL} -o ${OWNER} -g ${GROUP} -m 0644 ${SRC_DIR}/*.h ${DESTDIR}${prefix}/include/libtommath/

uninstall:
	rm -rf ${prefix}/include/libtommath

test:

.PHONY: all asan build cov debug test uninstall
