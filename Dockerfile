ARG ESP8266_RTOS_SDK_VERSION=master

FROM ubuntu:16.04 as distro
RUN apt-get update
    



FROM distro as toolchain
ARG XTENSA_LX106_RELEASE=1.22.0-100-ge567ec7-5.2.0
ARG XTENSA_ESP32_RELEASE=1.22.0-80-g6c4433a-5.2.0

ADD https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-${XTENSA_LX106_RELEASE}.tar.gz /xtensa-lx106.tar.gz
ADD https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-${XTENSA_ESP32_RELEASE}.tar.gz /xtensa-esp32.tar.gz

RUN mkdir -p /tmp /toolchains \
    && apt-get install -y tar \
    && tar -xzf /xtensa-lx106.tar.gz -C /tmp/ \
    && tar -xzf /xtensa-esp32.tar.gz -C /tmp/ \
    && mv /tmp/xtensa-lx106-elf /toolchains/lx106 \
    && mv /tmp/xtensa-esp32-elf /toolchains/esp32


FROM distro as sdk
ARG ESP8266_RTOS_SDK_VERSION=
RUN mkdir -p /sdk \
    && apt-get install -y git \
    && git clone --recursive https://github.com/espressif/ESP8266_RTOS_SDK.git /sdk \
    && cd /sdk \
    && git checkout "$ESP8266_RTOS_SDK_VERSION"





FROM distro

ARG ESP8266_RTOS_SDK_VERSION=

COPY --from=toolchain /toolchains /opt/toolchains
COPY --from=sdk /sdk /opt/sdk

ENV PATH /opt/toolchains/esp32/bin:/opt/toolchains/lx106/bin:$PATH
ENV IDF_PATH=/opt/sdk

RUN apt-get install -y \
        gcc \
        git \
        wget \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf \
        python \
        python-serial\
        python-pip \
    && python -m pip install --user -r /opt/sdk/requirements.txt

LABEL ESP8266_RTOS_SDK_VERSION=$ESP8266_RTOS_SDK_VERSION
