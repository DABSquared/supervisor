#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then
    if [[ -z "$GIT_REPO" && -z "$GIT_SSH_KEY" ]]
    then
        echo "No GIT Repository defined, not pulling."
        if [ "$WAIT_FOR_PHP" == "true" ]; then
            while true
            do
              [ -f .php_setup ] && break
              sleep 2
            done
        fi
    else
        echo "Pulling GIT Repository to /var/www/symfony"
        mkdir -p ~/.ssh
        eval "$(ssh-agent)" && ssh-agent -s
        echo "$GIT_SSH_KEY" > ~/.ssh/id_rsa
        chmod -R 0600 ~/.ssh/id_rsa
        ssh-add ~/.ssh/id_rsa
        [[ -f /.dockerenv ]] && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
        cd /var/www
        git clone "$GIT_REPO" symfony
        /setup.sh
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


