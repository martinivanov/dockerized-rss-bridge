FROM rssbridge/rss-bridge:latest

ENV APACHE_DOCUMENT_ROOT=/app

RUN apt-get update && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY whitelist.txt /app/
COPY config.ini.php.tmpl /tmp/

ENTRYPOINT ["dockerize", "-template", "/tmp/config.ini.php.tmpl:/app/config.ini.php", "/app/docker-entrypoint.sh"]
