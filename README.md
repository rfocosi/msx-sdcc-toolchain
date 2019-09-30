# msx-sdcc-toolchain
Docker based MSX SDCC Toolchain

## Requirements

- Docker (https://docs.docker.com/install/)
- docker-compose (https://docs.docker.com/compose/install/)

## How to use

- Pull the container:

`docker-compose pull rfocosi/msx-sdcc-toolchain:latest`

### Docker Run

#### Get Info
```
docker run --rm \
      rfocosi/msx-sdcc-toolchain:latest \
      info
```

#### Build
```
docker run --rm \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      build file.c
```

#### Build All
```
docker run --rm \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      build-all
```

#### Assembly
```
docker run --rm \
      -e SDAS_BIN=sdasz80 \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      sdasm file.asm
```

#### Clean
Removes `build\` directory
```
docker run --rm \
      -v {/host-workspace/}:/workspace/ \
      rfocosi/msx-sdcc-toolchain:latest \
      clean
```

### Setup with docker-compose

- Create a `docker-composer.yml` on your project's root:

```
version: '3'

services:
  sdcc:
    image: rfocosi/msx-sdcc-toolchain:latest
    environment:
      - SDAS_BIN=sdasz80
    volumes:
      - ${PROJECT_WORKSPACE}:/workspace
      - ${PROJECT_EXTRA_LIBS}:/extra-lib
      - ${PROJECT_EXTRA_INCLUDES}:/extra-include
```

- Create a `.env` on your project's root:

```
# Your project source files' root directory
PROJECT_WORKSPACE=./workspace

# Directory of your library files, if any (\*.lib, \*.rel)
PROJECT_EXTRA_LIBS=./share/lib

# Directory of your include files, if any (\*.h)
PROJECT_EXTRA_INCLUDES=./share/include
```

#### Running

##### Get Info

`docker-compose run --rm sdcc info`

##### Building

To build a source file, run:

`docker-compose run --rm sdcc build <source.c>`

To build all project's sources:

`docker-compose run --rm sdcc build-all`

Ps.: The root directory is `$PROJECT_WORKSPACE\src`

##### Assembly

```
docker-compose run --rm sdcc sdasm file.asm
```

##### Clean

`docker-compose run --rm sdcc clean`


### SDCC Parameters
The SDCC parameters can be added to a `<source_file_name>.params` file

Ex.:

```
> ls
file.c
file.params

> cat file.params
--code-loc 0x180 --data-loc 0 -mz80 --disable-warning 196 --no-std-crt0 $SDCC_LIB_Z80/crt0_msxdos_advanced.rel $SDCC_LIB_Z80/printf.rel $SDCC_LIB_Z80/putchar_msxdos.rel asm.lib fusion.lib
```

Ps.: You can use the environment variables on `.params` file.
