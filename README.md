this is a dockerized version of the [install & usage instructions of esp8266-rtos-sdk](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/latest/get-started/index.html)


The following instructions are valid for ESP8266 chips

Refer to [the esp8266-rtos-sdk documentation](https://docs.espressif.com/projects/esp8266-rtos-sdk/en/latest/api-guides/build-system.html#example-project) for more details on the build system

## Build the toolchain docker image
`docker build . -t esp-rtos-sdk`

# Usage
## Build your project
`docker run -it --rm -v $HOME/path/to/your/project/root_directory:/project -w /project esp-rtos-sdk make`

## Flash your ESP chip
`docker run -it --rm -v $HOME/path/to/your/project/root_directory:/project --privileged -v /dev:/dev -w /project esp-rtos-sdk make flash`

## Monitor the ESP chip's serial output
`docker run -it --rm -v $HOME/path/to/your/project/root_directory:/project --privileged -v /dev:/dev -w /project esp-rtos-sdk make monitor`
