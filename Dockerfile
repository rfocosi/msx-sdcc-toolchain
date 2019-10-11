ARG FROM_VERSION=2.1-SDCC-3.8.0

FROM rfocosi/sdcc-toolchain:${FROM_VERSION}
MAINTAINER Roberto Focosi, roberto.focosi@msx2cas.com

ENV TOOLCHAIN_VERSION=2.1.1-MSX

ENV SDCC_LIB_Z80=${SDCC_LIB_MAIN}/z80
ENV SDCC_INCLUDE_Z80=${SDCC_INCLUDE_MAIN}/z80

ENV SDAS_BIN=sdasz80

ARG Z80_LIB=${SDCC_LIB_Z80}/z80.lib

RUN sdar -d $Z80_LIB printf.rel && \
    sdar -d $Z80_LIB sprintf.rel && \
    sdar -d $Z80_LIB vprintf.rel && \
    sdar -d $Z80_LIB putchar.rel && \
    sdar -d $Z80_LIB getchar.rel

RUN mkdir -p $SDCC_LIB_MAIN/z80 && \
    mkdir -p $SDCC_INCLUDE_MAIN/z80

ADD fusion-c/fusion-c-include.tar.bz2 $SDCC_INCLUDE_MAIN/z80/

ADD fusion-c/fusion-c-lib.tar.bz2 $SDCC_LIB_MAIN/z80/
