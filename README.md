# pybin-onator

- Python 2.7 script to static binary

### Notes V1

- to get a standalone python you need to link all the modules staticaly
- thius requires a custom build, because its dynamic in nature.
- after the static lib's are overcome you run into some weird legacy code...
- glibc.. a needed component to python is tricky it loads other modules 
- dynamically, and im not sure if the names are hard coded or not.
- from what I understand, depending on the compiler there are 2 flavors of glibc, old/new
- but you need a custom build for each os you want to drop it in.
- so, a cent 5,6,7 build. but maybe diff vers of glibc too?
- more testing to come. research says either way you should have 90% coverage per os
- insanity...


## Description

- This docker creates a static version of python 2.7.16.
- It uses cython to compile the python script into c code.
- It compiles the c code and links it with the static pythoin binarys.
- The output is a static / portable/ standalone binary.

## Environment variables

- PY_SCRIPT=script in mounted volume to compile
- PY_SCRIPT_OUTPOUT=name of the binary to drop into mounted volume

## Use

You must mount a volume to the "/build". This is where you drop your source .py file.

```bash
docker run -it \
           -v $(pwd)/build/:/build/ \
           -e PY_SCRIPT=my_script.py \
           -e PY_SCRIPT_OUTPUT=my_bin \
           pybin-onator
```

## Building the image from scratch

```bash
git clone https://github.com/chris17453/pybin-onator.git
cd pybin-onator
make build
```

## Testing

```bash
make test
```

## Output

- In the mounted directory you will have 4 new files.
- File #1 -> my_script.py.c
- File #2 -> my_bin
- FILE #3 -> cython.output. my_script.py to my_script.py.c
- FILE #4 -> gcc.output. The binary compiler action


### Notes

- these modules need help with deps that are not static, they failed
- these modules dont exist...

```bash
#_bsddb             _codecs_cn         _codecs_hk
#_codecs_iso2022    _codecs_jp         _codecs_kr
#_codecs_tw         _ctypes            _ctypes_test
#_curses            _curses_panel      _hashlib
#_hotshot           _json              _lsprof
#_multibytecodec    _multiprocessing   _socket
#_sqlite3           _ssl               _tkinter
#audioop            bz2                crypt
#dbm                future_builtins    gdbm
#linuxaudiodev      nis                ossaudiodev
#pyexpat            readline           resource
#termios            zlib
```

Author: Charles Watkins
