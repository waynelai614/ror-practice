set :output, 'log/cron.log'
set :environment, :development
# custom job template for docker-compose
set :job_template, "bash -l -c 'cd :path && :environment_variable=:environment :job'"

every 1.day, at: '10:00 am' do
  command 'docker-compose run web rails runner Crawler.crawl_data_to_db'
end
