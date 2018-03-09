#!/bin/bash
PHP_VERSION=5.6.34
PHP_ROOT=~/.local/php/$PHP_VERSION
PHPIZE=$PHP_ROOT/bin/phpize
PHP_CONFIG=$PHP_ROOT/bin/php-config
DOWNLOAD_BASE=~/Downloads

cd $DOWNLOAD_BASE/

if [ ! -f php-$PHP_VERSION.tar.gz ]; then
wget http://cn2.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror -O $DOWNLOAD_BASE/php-$PHP_VERSION.tar.gz
fi

tar zxf php-$PHP_VERSION.tar.gz
cd php-$PHP_VERSION/
./configure --prefix=$PHP_ROOT \
--with-config-file-path=$PHP_ROOT/etc \
--with-config-file-scan-dir=$PHP_ROOT/etc/php.ini.d/ \
--enable-fpm \
--with-zlib-dir \
--with-freetype-dir \
--enable-cgi \
--enable-mbstring \
--with-libxml-dir=/usr \
--with-curl \
--with-mcrypt \
--with-zlib \
--with-gd \
--enable-inline-optimization \
--with-bz2 \
--with-zlib \
--enable-sockets \
--enable-mbregex \
--with-mhash \
--enable-zip \
--with-pcre-regex \
--with-mysql \
--with-pdo-mysql \
--with-mysqli \
--with-jpeg-dir=/usr \
--with-png-dir=/usr \
--enable-gd-native-ttf \
--with-openssl \
--with-libdir=lib64 \
--with-libxml-dir=/usr \
--enable-exif \
--with-gettext
make && make install

mkdir $PHP_ROOT/etc/php.ini.d/
cp ./php.ini-development $PHP_ROOT/etc/php.ini
cp $PHP_ROOT/etc/php-fpm.conf.default $PHP_ROOT/etc/php-fpm.conf


cd $DOWNLOAD_BASE
if [ ! -f ./redis-3.1.6.tgz ]; then
    wget https://pecl.php.net/get/redis-3.1.6.tgz -P $DOWNLOAD_BASE
fi
tar zxf redis-3.1.6.tgz
cd redis-3.1.6
$PHPIZE
./configure --with-php-config=$PHP_CONFIG
make && make install
cat > $PHP_ROOT/etc/php.ini.d/redis.ini <<EOL
extension=redis.so
EOL

cd $DOWNLOAD_BASE
if [ ! -f ./memcached-2.2.0.tgz ]; then
    wget https://pecl.php.net/get/memcached-2.2.0.tgz -P $DOWNLOAD_BASE
fi
tar zxf memcached-2.2.0.tgz
cd memcached-2.2.0
$PHPIZE
./configure --with-php-config=$PHP_CONFIG
make && make install
cat > $PHP_ROOT/etc/php.ini.d/memcached.ini <<EOL
extension=memcached.so
EOL

cd $DOWNLOAD_BASE

if [ ! -f ./xdebug-2.5.5.tgz ]; then
    wget https://xdebug.org/files/xdebug-2.5.5.tgz -P $DOWNLOAD_BASE
fi
tar zxf xdebug-2.5.5.tgz
cd xdebug-2.5.5
$PHPIZE
./configure --with-php-config=$PHP_CONFIG
make && make install
cat > $PHP_ROOT/etc/php.ini.d/xdebug.ini <<EOL
zend_extension=$PHP_ROOT/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so
EOL


