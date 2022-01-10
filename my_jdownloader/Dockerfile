ARG BUILD_FROM
FROM $BUILD_FROM

# Create directory, and start JD2 for the initial update and creation of config files.
RUN apk update && apk upgrade && \
    apk add openjdk11 && \
    apk add --no-cache --quiet tini su-exec shadow ffmpeg jq && \
    mkdir -p /opt/JDownloader/libs && \
    wget -O /opt/JDownloader/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar && \
    java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar

COPY common/* /opt/JDownloader/
RUN chmod +x /opt/JDownloader/entrypoint.sh

RUN mkdir -p /data/JDownloader
WORKDIR /data/JDownloader

ENTRYPOINT ["tini", "-g", "--", "/opt/JDownloader/entrypoint.sh"]
# Run this when the container is started
CMD ["java", "-Djava.awt.headless=true", "-jar", "/data/JDownloader/JDownloader.jar"]