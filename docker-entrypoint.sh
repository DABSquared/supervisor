#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then   
	if [ "$ISDEV" == "false" ]; then
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" doctrine:migrations:migrate --no-interaction || (echo >&2 "Doctrine Migrations Failed" && exit 1)
		php -d newrelic.appname="$symfony_app_name" bin/console --env="$ENVIRONMENT" cache:warmup || (echo >&2 "Cache Warmup Dev Failed" && exit 1)
	fi
fi




exec "$@"


