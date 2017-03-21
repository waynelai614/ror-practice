#!/bin/bash
# Start Cron job
whenever --update-crontab
# rake db commads
docker-compose run web rake db:create db:migrate db:test:prepare
