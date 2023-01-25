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

asan: libtommath.asan.la libtommath.asan.a

clean:
	rm -rf ${CLEANFILES}

clean_cov:
	rm -rf ${CLEANFILES_COV}

cov: libtommath.cov.la libtommath.cov.a

debug: libtommath.debug.la libtommath.debug.a

distclean:
	rm -rf ${DISTCLEANFILES}

gcovr:
	gcovr --gcov-executable ${GCOV} --html-details libtommath.html

libtommath.a: libtommath.la
	cp .libs/libtommath.a ./

libtommath.asan.a: libtommath.asan.la
	cp .libs/libtommath.asan.a ./

libtommath.cov.a: libtommath.cov.la
	cp .libs/libtommath.cov.a ./

libtommath.debug.a: libtommath.debug.la
	cp .libs/libtommath.debug.a ./

test:

.PHONY: all asan build clean cov debug distclean test

include config.mk
include sources.mk
