# Use this file to easily define all of your cron jobs.
set :output, 'log/cron_log.log'
every 1.day, at: [
  '9:00 am', '10:00 am', '11:00 am', '12:00 pm', '1:00 pm', '2:00 pm'
  ] do
  runner 'Crawler.data_to_db'
end