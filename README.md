# msx-sdcc-toolchain
Docker based MSX SDCC Toolchain

## Requirements

- Docker (https://docs.docker.com/install/)
- docker-compose (https://docs.docker.com/compose/install/)

## How to use

### Setup

##### Download `docker-compose.yml`:

Download `docker-composer.yml` to your project root:
```
> curl -L "https://raw.githubusercontent.com/rfocosi/msx-sdcc-toolchain/master/docker-compose.yml" -O docker-compose.yml
```

##### Create a `.env`:

Create your `.env` on your project's root:
```
> cat <<EOF > .env
PROJECT_WORKSPACE=./workspace
PROJECT_EXTRA_LIBS=./share/lib
PROJECT_EXTRA_INCLUDES=./share/include
EOF
```

Where:
- `PROJECT_WORKSPACE`: Your project source files' root directory
- `PROJECT_EXTRA_LIBS`: Directory of your library files, if any (\*.lib, \*.rel)
- `PROJECT_EXTRA_INCLUDES`: Directory of your include files, if any (\*.h)

##### Build the container:

`docker-compose build`

### Running

##### Get Info

`docker-compose run --rm sdcc info`

##### Building

To build a source file, run:

`docker-compose run --rm sdcc build <source.c>`

Ex.:

`docker-compose run sdcc build src/file.c`

Ps.: The root directory is `$PROJECT_WORKSPACE`

###### SDCC Parameters
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
