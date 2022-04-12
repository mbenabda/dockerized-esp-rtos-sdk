This is a dockerized version of the [install & usage instructions of esp8266-rtos-sdk](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/latest/get-started/index.html). 

You can get the image from dockerhub, at [mbenabda/esp8266-rtos-sdk](https://hub.docker.com/r/mbenabda/esp8266-rtos-sdk)

Its tags are aligned with versions of the SDK (tag v3.3 of the image holds v3.3 of the SDK)

Please refer to [the esp8266-rtos-sdk documentation](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/latest/api-guides/build-system.html#example-project) for more details on the build system

# Usage
Given `$PROJECT_ROOT_DIR` holds the absolute path to your project's codebase:

## Build your project
`docker run -it --rm -v $PROJECT_ROOT_DIR:/project -w /project mbenabda/esp8266-rtos-sdk make`

## Flash your ESP chip
`docker run -it --rm -v $PROJECT_ROOT_DIR:/project --privileged -v /dev:/dev -w /project mbenabda/esp8266-rtos-sdk make flash`

## Monitor the ESP chip's serial output
`docker run -it --rm -v $PROJECT_ROOT_DIR:/project --privileged -v /dev:/dev -w /project mbenabda/esp8266-rtos-sdk make monitor`

## Build the toolchain docker image
- clone this repository
- run
    ```sh
    docker build \
        --build-arg=ESP8266_RTOS_SDK_VERSION=v3.3 \
        --build-arg=XTENSA_LX106_RELEASE=xtensa-lx106-elf-linux64-1.22.0-100-ge567ec7-5.2.0 \
        --build-arg=XTENSA_ESP32_RELEASE=xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0 \
        . \
        -t esp8266-rtos-sdk
    ```
