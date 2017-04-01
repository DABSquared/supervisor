#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then
	if [ "$SUPERVISOR_CONF" ]; then
        cp $SUPERVISOR_CONF /etc/supervisor/conf.d/supervisord.conf
        sed -i "s|REDISPREFIX|$symfony_redis_prefix|g" /etc/supervisor/conf.d/supervisord.conf
        sed -i "s|REDISHOST|$symfony_redis_host|g" /etc/supervisor/conf.d/supervisord.conf
        sed -i "s|REDISPORT|$symfony_redis_port|g" /etc/supervisor/conf.d/supervisord.conf
        sed -i "s|REDISDB|$symfony_redis_database|g" /etc/supervisor/conf.d/supervisord.conf
    fi
fi

exec "$@"


