#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then
	if [ "$SUPERVISOR_CONF" ]; then
        cp $SUPERVISOR_CONF /etc/supervisor/conf.d/supervisord.conf
        sed -e "s|REDISPREFIX|$symfony.redis_prefix|g" /etc/supervisor/conf.d/supervisord.conf > /etc/supervisor/conf.d/supervisord.conf
        sed -e "s|REDISHOST|$symfony.redis_host|g" /etc/supervisor/conf.d/supervisord.conf > /etc/supervisor/conf.d/supervisord.conf
        sed -e "s|REDISPORT|$symfony.redis_port|g" /etc/supervisor/conf.d/supervisord.conf > /etc/supervisor/conf.d/supervisord.conf
        sed -e "s|REDISDB|$symfony.redis_database|g" /etc/supervisor/conf.d/supervisord.conf > /etc/supervisor/conf.d/supervisord.conf
    fi
fi

exec "$@"


