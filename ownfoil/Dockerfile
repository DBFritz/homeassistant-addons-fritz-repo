ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --update --no-cache nginx openssl python3 py3-pip
RUN pip3 install --no-cache --upgrade jsonc-parser

RUN set -e \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir /app

ADD https://raw.githubusercontent.com/a1ex4/ownfoil/master/libs/gen_shop.py /app/gen_shop.py
ADD https://raw.githubusercontent.com/a1ex4/ownfoil/master/libs/consts.py /app/consts.py
ADD https://raw.githubusercontent.com/a1ex4/ownfoil/master/nginx.conf /etc/nginx/http.d/default.conf

RUN touch /etc/nginx/.htpasswd

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh" ]