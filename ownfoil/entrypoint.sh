#!/usr/bin/with-contenv bashio

ln -sfT "$(bashio::config 'path')" /games

nginx -g "daemon on;"
python3 /app/gen_shop.py /games