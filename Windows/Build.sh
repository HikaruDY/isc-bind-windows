#!/bin/sh
cd ..
./configure --enable-backtorace=no --enable-threads --disable-atomic --disable-doh --disable-static --enable-shared --with-host=no --with-ecdsa=no --with-libxml2=no --with-zlib=no --with-gssapi=no --without-python
make CFLAGS="-I${PWD}/lib/isc/include" -I"${PWD}/lib/dns/include" -I"${PWD}/lib/isccfg/include" STD_LDFLAGS=-Wl,--export-all-symbols 
