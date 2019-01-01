FROM ubuntu:18.04
LABEL Maintainer Kenta Nakajima <knknkn1162@gmail.com>
LABEL Description "verilog playground with icarus-verilog"

ENV VERSION=v10_2
ENV APP_PATH=/app
ENV WORK_PATH=/verilog

WORKDIR ${APP_PATH}

RUN apt-get update -y && \
  apt-get install -y git build-essential autoconf gperf flex bison && \
  git clone --depth 1 -b ${VERSION} --single-branch https://github.com/steveicarus/iverilog.git . && \
  sh autoconf.sh && \
  ./configure && \
  make -j $(grep -c ^processor /proc/cpuinfo 2>/dev/null) && \
  make install

WORKDIR ${WORK_PATH}
