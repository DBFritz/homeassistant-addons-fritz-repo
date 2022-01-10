#!/usr/bin/env bashio

EMAIL=$(bashio::config 'email')
PASSWORD=$(bashio::config 'password')

# Set MyJDownloader credentials
CONFIG_FILE="/data/JDownloader/cfg/org.jdownloader.api.myjdownloader.MyJDownloaderSettings.json"

cp -R -u -p /opt/JDownloader/. /data/JDownloader

if [ ! -z "$EMAIL" ] ; then
    bashio::log.info "Using ${EMAIL} as username"

    if [ ! -f "$CONFIG_FILE" ] || [ ! -s "$CONFIG_FILE" ] ; then
        echo '{}' > "$CONFIG_FILE"
    fi

    CFG=$(jq -r --arg EMAIL "$EMAIL" --arg PASSWORD "$PASSWORD" '.email = $EMAIL | .password = $PASSWORD' "$CONFIG_FILE")
    [ ! -z "$CFG" ] && echo "$CFG" > "$CONFIG_FILE"
else
    bashio::log.error "Username not found!"
fi

# Sometimes this gets deleted. Just copy it every time.
mkdir -p /data/JDownloader/libs/
cp /opt/JDownloader/sevenzip* /data/JDownloader/libs/

exec "$@"

# Keep container alive when jd2 restarts
while sleep 3600; do :; done