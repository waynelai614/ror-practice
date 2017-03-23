#!/bin/bash
# Start Cron job
whenever --update-crontab
# rake db commads
docker-compose run web rake db:create db:migrate db:test:prepare
# crawl_data_to_db
docker-compose run web rails runner Crawler.crawl_data_to_db
