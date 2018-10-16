#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then   
	if [ "$ISDEV" == "false" ]; then
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" doctrine:migrations:migrate --no-interaction || (echo >&2 "Doctrine Migrations Failed" && exit 1)
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" cache:warmup || (echo >&2 "Cache Warmup Dev Failed" && exit 1)
	fi
	
	if [ "$SUPERVISOR_CONF" ]; then
	 	cp /var/www/symfony/$SUPERVISOR_CONF /etc/supervisord.conf
	 	sed -i "s|REDISPREFIX|$REDIS_PREFIX|g" /etc/supervisord.conf
	 	sed -i "s|REDISHOST|$REDIS_HOST|g" /etc/supervisord.conf
	 	sed -i "s|REDISPORT|$REDIS_PORT|g" /etc/supervisord.conf
		sed -i "s|REDISDB|$REDIS_DATABASE|g" /etc/supervisord.conf
 	fi
fi




exec "$@"


