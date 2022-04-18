ARG BASE_IMAGE=ubuntu:20.04
ARG ESP8266_RTOS_SDK_VERSION=v3.4
ARG XTENSA_LX106_RELEASE=xtensa-lx106-elf-gcc8_4_0-esp-2020r3-linux-amd64

FROM $BASE_IMAGE as distro
RUN apt-get update -y

FROM distro as toolchains
ARG XTENSA_LX106_RELEASE
ADD https://dl.espressif.com/dl/${XTENSA_LX106_RELEASE}.tar.gz /xtensa-lx106.tar.gz
RUN mkdir -p /tmp /toolchains \
    && apt-get install -y tar \
    && tar -xzf /xtensa-lx106.tar.gz -C /tmp/ \
    && mv /tmp/xtensa-lx106-elf /toolchains/lx106

FROM distro as sdk
ARG ESP8266_RTOS_SDK_VERSION
RUN mkdir -p /sdk \
    && apt-get install -y git \
    && git clone --branch "$ESP8266_RTOS_SDK_VERSION" --single-branch https://github.com/espressif/ESP8266_RTOS_SDK.git /sdk \
    && cd /sdk \
    && git submodule update --init --recursive

FROM distro
ARG ESP8266_RTOS_SDK_VERSION
ARG XTENSA_LX106_RELEASE
ENV PATH /opt/toolchains/esp32/bin:/opt/toolchains/lx106/bin:$PATH
ENV IDF_PATH=/opt/sdk
COPY --from=toolchains /toolchains /opt/toolchains
COPY --from=sdk /sdk /opt/sdk
RUN apt-get install -y \
        gcc \
        git \
        wget \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf \
        python3-serial \
        python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10 \
    && pip install --user --upgrade pip \
    && pip install --user -r /opt/sdk/requirements.txt

LABEL ESP8266_RTOS_SDK_VERSION=$ESP8266_RTOS_SDK_VERSION \
      XTENSA_LX106_RELEASE=$XTENSA_LX106_RELEASE