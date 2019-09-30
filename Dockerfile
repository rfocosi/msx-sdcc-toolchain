FROM debian:bullseye
MAINTAINER Roberto Focosi, roberto.focosi@msx2cas.com

ENV WORKSPACE_ROOT=/workspace
ENV HOME=${WORKSPACE_ROOT}

ENV SRC_PATH=${WORKSPACE_ROOT}/src
ENV BUILD_PATH=$WORKSPACE_ROOT/build
ENV TARGET_PATH=$WORKSPACE_ROOT/target

ARG SDCC_LIB_MAIN_PATH=/usr/share/sdcc

RUN apt-get update && apt-get install -y sdcc gettext-base binutils

ENV SDCC_INCLUDE_MAIN=${SDCC_LIB_MAIN_PATH}/include
ENV SDCC_LIB_MAIN=${SDCC_LIB_MAIN_PATH}/lib
ENV SDCC_LIB_Z80=${SDCC_LIB_MAIN}/z80
ENV SDCC_INCLUDE_Z80=${SDCC_INCLUDE_MAIN}/z80
ENV SDCC_LIB=/extra-lib
ENV SDCC_INCLUDE=/extra-include

ARG Z80_LIB=${SDCC_LIB_Z80}/z80.lib

RUN sdar -d $Z80_LIB printf.rel && \
    sdar -d $Z80_LIB sprintf.rel && \
    sdar -d $Z80_LIB vprintf.rel && \
    sdar -d $Z80_LIB putchar.rel && \
    sdar -d $Z80_LIB getchar.rel


RUN mkdir -p $SDCC_LIB_MAIN/z80 && \
    mkdir -p $SDCC_INCLUDE_MAIN/z80 && \
    mkdir -p $SDCC_LIB && \
    mkdir -p $SDCC_INCLUDE && \
    mkdir -p $SRC_PATH

ADD fusion-c/fusion-c-include.tar.bz2 $SDCC_INCLUDE_MAIN/z80/

ADD fusion-c/fusion-c-lib.tar.bz2 $SDCC_LIB_MAIN/z80/

ADD bin/src/* /usr/local/bin/

RUN chmod +x /usr/local/bin/build && \
    chmod +x /usr/local/bin/clean && \
    chmod +x /usr/local/bin/info && \
    rm -rf /tmp/*

WORKDIR ${WORKSPACE_ROOT}

CMD ["info"]
