this is a dockerized version of the [install & usage instructions of esp8266-rtos-sdk](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/latest/get-started/index.html)


The following instructions are valid for ESP8266 chips

# Prerequisites

## Project directory structure

It is important that your project's root directory has the following files and folders:

```
/
|-> main/
    |-> ... source files ...
    |-> CMakeLists.txt
    |-> component.mk
|-> CMakeLists.txt
|-> Makefile
```

see the [SDK's example projects](https://github.com/espressif/ESP8266_RTOS_SDK/tree/master/examples) for more details these files

## Build the toolchain docker image
`docker build . -t esp-rtos-sdk`

# Usage
## Build your project
`docker run -it --rm -v $PWD:/project -w /project esp-rtos-sdk make`

## Flash your ESP chip
`docker run -it --rm -v $PWD:/project --privileged -v /dev:/dev -w /project esp-rtos-sdk make flash`

## Monitor the ESP chip's serial output
`docker run -it --rm -v $PWD:/project --privileged -v /dev:/dev -w /project esp-rtos-sdk make monitor`