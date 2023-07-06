#!/usr/bin/env make
#
# csilence - determine CSILENCE values for cc, gcc and clang
#
# Copyright (c) 2023 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

#############
# utilities #
#############

CC= cc
CHMOD= chmod
CP= cp
INSTALL= install
RM= rm
SHELL= bash

#CFLAGS= -O3 -g3 --pedantic -Wall -Werror
CFLAGS= -O3 -g3 --pedantic -Wall

######################
# target information #
######################

DESTDIR= /usr/local/bin

TARGETS= csilence

######################################
# all - default rule - must be first #
######################################

all: ${TARGETS}

csilence:
	${CHMOD} +x $@

#################################################
# .PHONY list of rules that do not create files #
#################################################

.PHONY: all configure clean clobber install

###################################
# standard Makefile utility rules #
###################################

configure:
	@echo nothing to configure

clean:
	@echo rule to clean or empty rule if nothing is built

clobber: clean
	@echo rule to clobber or empty rule if nothing is built

install: all
	${INSTALL} -m 0555 ${TARGETS} ${DESTDIR}