#!/bin/sh

set -e

WHOAMI=$(whoami)

if [ "$WHOAMI" = "root" ]; then

    PHP_CONF="/usr/local/etc/php/conf.d/zzz.ini"
    if [ ! -f "$FPM_CONF" -a ! -f "$PHP_CONF" ]; then
        env | sort | while IFS='=' read name value ; do
            case $name in
                PHP__*)
                    name=${name#PHP__}
                    name=${name//__/.}  #   __ =>  .
                    name=${name//../__} # ____ => __
                    echo "$name = $value" >> "$PHP_CONF"
                    ;;
            esac
        done
    fi

    if [ "$XDEBUG" = 'On' ]; then
        #docker-php-ext-enable xdebug
        echo "zend_extension=$(php -r 'echo ini_get("extension_dir");')/xdebug.so" > "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini"
    fi
fi

exec "$@"
