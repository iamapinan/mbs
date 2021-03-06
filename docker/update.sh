#!/usr/bin/env bash

docker exec -it -d mbs-php-fpm sh -c "php /var/www/mbs-web/artisan down"

git pull
docker exec -it mbs-php-fpm sh -c "cd /var/www/mbs-web/ && php artisan clear"
docker exec -it mbs-php-fpm sh -c "cd /var/www/mbs-web/ && composer install --optimize-autoloader --no-dev"
docker exec -it mbs-php-fpm sh -c "cd /var/www/mbs-web/ && php artisan migrate"
docker exec -it mbs-php-fpm sh -c "cd /var/www/mbs-web/ && php artisan clear && php artisan cache:clear && php artisan view:cache && php artisan optimize"
docker restart mbs-php-fpm

docker exec -it -d mbs-php-fpm sh -c "php /var/www/mbs-web/artisan up"
