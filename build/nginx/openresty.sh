#! /bin/bash
if [ -z $OPENRESTY_VERSION ]; then
	OPENRESTY_VERSION=1.13.6.2
fi

apt-get update
apt-get install -y build-essential libssl-dev libpcre++-dev automake autoconf libtool unzip zip git
wget https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz
git clone https://github.com/google/ngx_brotli
git clone https://github.com/bagder/libbrotli
cd libbrotli; ./autogen.sh && ./configure && make -j4 install && ldconfig; cd ..
tar zxf openresty-$OPENRESTY_VERSION.tar.gz
cd openresty-$OPENRESTY_VERSION
./configure -j4 --user=www-data --group=www-data --with-file-aio --with-ipv6 --with-pcre-jit --with-http_realip_module --with-http_stub_status_module --with-http_v2_module --add-module=../ngx_brotli
sed -ie "s/openresty/nginx/g" build/nginx-*/src/http/ngx_http_header_filter_module.c
sed -ie "s/openresty\/\".*/nginx\"/g" build/nginx-*/src/core/nginx.h
sed -ie "s/define NGINX_VERSION.*/define NGINX_VERSION      \"stable\"/g" build/nginx-*/src/core/nginx.h
make -j4 install
ln -s /usr/local/openresty/nginx/sbin/nginx /usr/sbin/nginx
ldconfig
