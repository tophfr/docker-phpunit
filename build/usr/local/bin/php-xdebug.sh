#!/bin/sh

set -e

PHP=php
EXTENSION_DIR="$("$PHP" -r 'echo ini_get("extension_dir");')"
IS_XDEBUG_LOADED="$("$PHP" -r 'echo extension_loaded("xdebug");')"
OPTIONS=""

if [ "$IS_XDEBUG_LOADED" != "1" ]; then
    OPTIONS="$OPTIONS -dzend_extension=$EXTENSION_DIR/xdebug.so"
fi

exec "$PHP" $OPTIONS "$@"
