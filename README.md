# msx-sdcc-toolchain
Docker-based MSX SDCC Toolchain

## Requirements

- [Docker](https://docs.docker.com/install/)
- [docker-compose](https://docs.docker.com/compose/install/)

## How to use

### SDCC Parameters
The SDCC parameters can be added to a `<source_file_name>.params` file

Ex.:

```
> ls
asm.s
asm.params
file.c
file.params
other.asm
other.params
```

- For executable files:
```
SDCC_ARGS="--code-loc 0x180 --data-loc 0 -mz80 --disable-warning 196 --no-std-crt0 $SDCC_LIB/crt0_msxdos_advanced.rel $SDCC_LIB/printf.rel $SDCC_LIB/putchar_msxdos.rel asm.lib fusion.lib"
TARGET_BIN_FILE="$FILE_NAME.com"
```

- For library files:
```
SDCC_ARGS="--code-loc 0x180 --data-loc 0 -mz80 --disable-warning 196 --no-std-crt0"
TARGET_LIB_FILE="$FILE_NAME.lib"
```

Ps.: You can use environment variables on `.params` file. To get a list of available variables, execute `info` command.

### Docker Run

#### Info
```
docker run --rm \
      rfocosi/msx-sdcc-toolchain:latest \
      info
```

#### Building
To build a single source file, run:
```
docker run --rm \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      build "file.c"
```

To build all project's sources:
```
docker run --rm \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      build "*.c"
```

#### Assembly
```
docker run --rm \
      -e SDAS_BIN=sdasz80 \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      sdasm "asm.s"
```

To build all:
```
docker run --rm \
      -e SDAS_BIN=sdasz80 \
      -v {/host-workspace/}:/workspace/ \
      -v {/host-extra-lib/}:/extra-lib/ \
      -v {/host-extra-include/}:/extra-include/ \
      rfocosi/msx-sdcc-toolchain:latest \
      sdasm "*.s"
```

#### Clean
Removes `build\` and `target\` directories
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

##### Info

```
docker-compose run --rm sdcc info
```

##### Building

To build a single source file, run:

```
docker-compose run --rm sdcc build "file.c"
```

To build all project's sources:

```
docker-compose run --rm sdcc build "*.c"
```

Ps.: The root directory is `$PROJECT_WORKSPACE\src`

##### Assembly

```
docker-compose run --rm sdcc sdasm "asm.s"
```

To build all:
```
docker-compose run --rm sdcc sdasm "*.s"
```

##### Clean

```
docker-compose run --rm sdcc clean
```
