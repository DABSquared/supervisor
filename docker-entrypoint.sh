#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then   
	if [ "$ISDEV" == "false" ]; then
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" doctrine:migrations:migrate --no-interaction || (echo >&2 "Doctrine Migrations Failed" && exit 1)
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" cache:warmup || (echo >&2 "Cache Warmup Dev Failed" && exit 1)
	fi
	
	if [ "$SUPERVISOR_CONF" ]; then
	 	cp /var/www/symfony/$SUPERVISOR_CONF /etc/supervisor/conf.d/supervisord.conf
	 	sed -i "s|REDISPREFIX|$symfony_redis_prefix|g" /etc/supervisor/conf.d/supervisord.conf
	 	sed -i "s|REDISHOST|$symfony_redis_host|g" /etc/supervisor/conf.d/supervisord.conf
	 	sed -i "s|REDISPORT|$symfony_redis_port|g" /etc/supervisor/conf.d/supervisord.conf
		sed -i "s|REDISDB|$symfony_redis_database|g" /etc/supervisor/conf.d/supervisord.conf
 	fi
fi




exec "$@"


