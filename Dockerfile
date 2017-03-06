FROM dabsquared/php7-fpm

LABEL maintainer "dbrooks@dabsquared.com"

RUN apt-get update && apt-get install -y supervisor

WORKDIR /var/www/symfony

ENV SUPERVISOR_CONF ""

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD supervisord -n -c /etc/supervisor/conf.d/supervisord.conf -e debug