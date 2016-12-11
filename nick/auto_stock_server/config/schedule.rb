# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

# testing
# every 1.minute do 
#   runner "Crawler.crawl_data_to_db"
#   command "open ~/Desktop"
# end

every '0,30 22,23 * * *' do
  runner "Crawler.crawl_data_to_db"
end

# Learn more: http://github.com/javan/whenever
