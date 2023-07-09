# csilence - determines `CSILENCE` values for `cc`, `gcc` and `clang`

This tool, which uses the [pfmt tool](https://github.com/lcn2/pfmt), determines
for the [winning entries](https://github.com/ioccc-src/winner) of the
[IOCCC](https://www.ioccc.org) Makefiles.

It runs `make clobber` and then tries `make all` and `make alt` with gcc and
clang to determine what warnings should be disabled.


## Note about warnings that cannot be disabled

It should be noted that in some systems including macOS and linux there are
warnings that cannot be disabled. There is nothing that can be done about this
unless they're only enabled by say `-Wall` and you don't specify `-Wall` but
that kind of defeats the purpose of warnings :-)

# Installing

To install this to `/usr/local/bin` first make sure that `csilence.sh` is copied
to `csilence` like so:

```sh
make
```

and then run as root or via sudo:

```sh
make install
```


# Usage

To get the syntax of the tool, use the `-h` option like so:

```sh
$ csilence -h
usage: /usr/local/bin/csilence [-h] [-v level] [-V] [arg ..]

	-h		print help message and exit
	-v level	set verbosity level (def level: 0)
	-V		print version string and exit

	-C		try make with CC unset
	-c		do not try make using CC=clang
	-g		do not try make using CC=gcc

	-p path		path to pfmt (def: /usr/local/bin/pfmt)
	-P		print CSILENCE= on CC=clang and CC=gcc runs (def: print CSILENCE+=)

	arg		make args

	NOTE: Try /usr/local/bin/csilence -v 1 clobber all

Exit codes:
     0	    all OK
     2	    -h and help string printed or -V and version string printed
     3	    command line error
     4	    cannot find pfmt (HINT: For pfmt see https://github.com/lcn2/pfmt)
 >= 10	    internal error

csilence version: 1.0.2 2023-07-07
```


# Example use

To get a list of changes necessary to silence warnings in the Makefiles of the
winning entries for the `all` rule and the `alt` rule, filtered with `less(1)`, try the below from the top level
directory of the winning entries:

```sh
find ???? -mindepth 1 -maxdepth 1 -type d | while read dir; do
(cd "$dir"; echo =-=-= "$dir" =-=-= ; csilence -v 1 clobber all ; echo ; csilence -v 1 clobber alt)
done 2>&1 | less
```

The top level directory has subdirectories in the form of `YYYY/winner` which is
why the path specified for `find(1)` is `????`. See below for example output.


## Example output

XXX - update the below and remove this XXX note once the [temp-test-ioccc
repo](https://github.com/ioccc-src/temp-test-ioccc) has been folded into the
[winner repo](https://github.com/ioccc-src/winner) - XXX

### Example output when the warnings are silenced

Because no warnings are actually triggered for
[1984/mullender](https://github.com/ioccc-src/temp-test-ioccc/tree/master/1984/mullender)
(which is one of Landon's all time favourite entries to this day), one will see
something like:


```sh
=-=-= 1984/mullender =-=-=
/usr/local/bin/csilence: debug[1]: make clobber all

/usr/local/bin/csilence: debug[1]: make clobber all CC=clang
/usr/local/bin/csilence: debug[1]: make clobber all CC=gcc

/usr/local/bin/csilence: debug[1]: make clobber alt

/usr/local/bin/csilence: debug[1]: make clobber alt CC=clang
/usr/local/bin/csilence: debug[1]: make clobber alt CC=gcc

```

except that more blank lines were removed.

If warnings are triggered, say as in
[1984/laman](https://github.com/ioccc-src/winner/blob/master/1984/laman/laman.c),
it might look like:

```sh
=-=-= 1984/laman =-=-=
/usr/local/bin/csilence: debug[1]: make clobber all

CSILENCE= -Wno-deprecated-non-prototype

/usr/local/bin/csilence: debug[1]: make clobber all CC=clang

CSILENCE+= -Wno-deprecated-non-prototype

/usr/local/bin/csilence: debug[1]: make clobber all CC=gcc

CSILENCE+= -Wno-deprecated-non-prototype

/usr/local/bin/csilence: debug[1]: make clobber alt
/usr/local/bin/csilence: debug[1]: make clobber alt CC=clang
/usr/local/bin/csilence: debug[1]: make clobber alt CC=gcc
```

# Conclusion

Thanks for reading and thanks for all the fish; we hope this document was useful
in understanding the `csilence` tool!

