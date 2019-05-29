# Author: Charles Watkins
# Desc: builds a static python binary for use with embedding in compiled python scripts.
# ex a single static exe, no deps 
FROM centos:7

VOLUME /build

RUN yum install make gcc gcc-c++ yum-utils glibc-static wget Cython tar tee -y
RUN yum-builddep python -y
RUN wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz 
RUN tar -xzvf Python-2.7.16.tgz  
RUN rm Python-2.7.16.tgz
WORKDIR /Python-2.7.16

COPY Python-2.7.16/Setup Modules/Setup
RUN mkdir bin
RUN ./configure     --disable-shared \
                    --enable-optimizations\
                    --prefix="/python" \
                    LDFLAGS="-Wl,-no-export-dynamic -static -static-libgcc" \
                    CPPFLAGS="-static -fPIC" \
                    LINKFORSHARED=" " \
                    DYNLOADFILE="dynload_stub.o"

RUN make
RUN make altinstall
COPY pybin /

# who knew you couldnt use single quotes in ENTRYPOINT... wth?
ENTRYPOINT ["/pybin"]
