# With database_cleaner,
# the following are about setup and cleaning the database between each unit test and test suite.
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end 