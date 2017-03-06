FROM dabsquared/php7-fpm

LABEL maintainer "dbrooks@dabsquared.com"

RUN apt-get update && apt-get install -y supervisor

WORKDIR /var/www/symfony

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]

CMD /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf -e debug