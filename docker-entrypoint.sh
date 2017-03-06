#!/bin/bash
set -e

if [ "$1" = 'supervisor' ]; then
	if [ "$SUPERVISOR_CONF" ]; then
        cp $SUPERVISOR_CONF /etc/supervisor/conf.d/supervisord.conf
    fi
fi

exec "$@"


