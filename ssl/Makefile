OPENSSL_VERSION := "3.2.0"
OPENSSL_MIRROR := "https://www.openssl.org/source"

LIBRESSL_VERSION := "3.8.2"
LIBRESSL_MIRROR := "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL"


default: openssl libressl assets

openssl: dl_openssl build_openssl

.PHONY: dl_openssl
dl_openssl:
	wget ${OPENSSL_MIRROR}/openssl-${OPENSSL_VERSION}.tar.gz
	tar -xzf openssl-${OPENSSL_VERSION}.tar.gz
	mv openssl-${OPENSSL_VERSION} openssl

.PHONY: build_openssl
build_openssl:
	cd openssl && \
		./config no-shared no-deprecated && \
		make -j4 build_libs

libressl: dl_libressl build_libressl

.PHONY: dl_libressl
dl_libressl:
	wget ${LIBRESSL_MIRROR}/libressl-${LIBRESSL_VERSION}.tar.gz
	tar -xzf libressl-${LIBRESSL_VERSION}.tar.gz
	mv libressl-${LIBRESSL_VERSION} libressl

.PHONY: build_libressl
build_libressl:
	cd libressl && \
		mkdir build && cd build && \
		cmake .. && make -j4

.PHONY: assets
assets:
	mkdir -p assets/openssl
	mkdir -p assets/libressl
	cp -a openssl/*.a assets/openssl/ 
	cp -a openssl/include assets/openssl/ 
	cp -a libressl/build/crypto/libcrypto.a assets/libressl/
	cp -a libressl/build/ssl/libssl.a assets/libressl/
	cp -a libressl/include assets/libressl/ 
	tar -cvzf assets.tar.gz assets

clean:
	rm -Rf openssl*
	rm -Rf libressl*
	rm -Rf assets*
