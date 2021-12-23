#!/bin/bash 

# Environment variables

APP_ROOT="/home/dongho/apps";

# Environment variables for nginx install

NGINX_APP="nginx_install.tar.xz";
NGINX_FOLDER="./nginx_install/nginx-1.20.2";

NGINX_PREFIX="$APP_ROOT/nginx-1.20.2";
ZLIB_FOLDER="../zlib-1.2.11";
PCRE_FOLDER="../pcre-8.45"
OPENSSL_FOLDER="../openssl-1.1.1m"

# Environment variables for logrotate

POPT_APP="popt-1.16.tar.gz";
POPT_FOLDER="popt-1.16";
POPT_PREFIX="$APP_ROOT/popt-1.16"

LOGROTATE_APP="logrotate-3.11.0.tar.xz";
LOGROTATE_FOLDER="logrotate-3.11.0";
LOGROTATE_PREFIX="$APP_ROOT/logrotate-3.11.0";

# core numbers

CORE_NUMBER=`grep -c processor /proc/cpuinfo`

function nginx_install() {
	tar xvJf $NGINX_APP;
	cd $NGINX_FOLDER;

	./configure --with-zlib=$ZLIB_FOLDER \
				--with-pcre=$PCRE_FOLDER \
				--with-openssl=$OPENSSL_FOLDER \
				--with-http_stub_status_module \
				--with-http_ssl_module \
				--prefix=$NGINX_PREFIX \
				--with-http_realip_module

	make -j$CORE_NUMBER && make install 

	cd ../..
}

function logrotate_install() {
	tar xvzf $POPT_APP;
	cd $POPT_FOLDER;
	./configure --prefix=$POPT_PREFIX 
	make -j$CORE_NUMBER && make install

	cd ..

	tar xvJf $LOGROTATE_APP;
	cd $LOGROTATE_FOLDER;
	./configure --prefix=$LOGROTATE_PREFIX LDFLAGS="-L$POPT_PREFIX/lib" CPPFLAGS="-I$POPT_PREFIX/include"
	make -j$CORE_NUMBER && make install 
}

function make_symbolic_nginx() {
	cd $APP_ROOT;

	ln -s $NGINX_PREFIX nginx
}

nginx_install

make_symbolic_nginx
