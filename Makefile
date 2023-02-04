## c3
## Copyright 2022,2023 kmx.io <contact@kmx.io>
##
## Permission is hereby granted to use this software excepted
## on Apple computers granted the above copyright notice and
## this permission paragraph are included in all copies and
## substantial portions of this software.
##
## THIS SOFTWARE IS PROVIDED "AS-IS" WITHOUT ANY GUARANTEE OF
## PURPOSE AND PERFORMANCE. IN NO EVENT WHATSOEVER SHALL THE
## AUTHOR BE CONSIDERED LIABLE FOR THE USE AND PERFORMANCE OF
## THIS SOFTWARE.

CLEANFILES = *.a *.gcno *.la .libs libtommath.la *.lo *.o

CLEANFILES_COV = *.css *.gcda *.html .libs/*.gcda
CLEANFILES += ${CLEANFILES_COV}

DISTCLEANFILES = ${CLEANFILES} config.mk

build: libtommath.la libtommath.a

all:
	${MAKE} build
	if ${HAVE_GCOV}; then ${MAKE} cov; fi
	${MAKE} debug
	if ${HAVE_ASAN}; then ${MAKE} asan; fi

asan: libtommath_asan.la libtommath_asan.a

clean:
	rm -rf ${CLEANFILES}

clean_cov:
	rm -rf ${CLEANFILES_COV}

cov: libtommath_cov.la libtommath_cov.a

debug: libtommath_debug.la libtommath_debug.a

distclean:
	rm -rf ${DISTCLEANFILES}

gcovr:
	gcovr --gcov-executable ${GCOV} --html-details libtommath.html

libtommath.a: libtommath.la
	cp .libs/libtommath.a ./

libtommath_asan.a: libtommath_asan.la
	cp .libs/libtommath_asan.a ./

libtommath_cov.a: libtommath_cov.la
	cp .libs/libtommath_cov.a ./

libtommath_debug.a: libtommath_debug.la
	cp .libs/libtommath_debug.a ./

test:

.PHONY: all asan build clean cov debug distclean test

include config.mk
include sources.mk
