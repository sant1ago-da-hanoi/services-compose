#!/bin/bash

composer install --ignore-platform-reqs

ENV_FILE=${SOURCE_PATH}/.env

if [ ! -f ".env" ]; then
    echo "Creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exists."
fi

php artisan optimize clear
php artisan view:clear
php artisan route:clear
php artisan storage:link
php artisan log-viewer:publish
php artisan view:cache

php-fpm -D
nginx -g "daemon off;"

# Start cron supervisord and services
crond && /usr/bin/supervisord -n -c /etc/supervisord.conf