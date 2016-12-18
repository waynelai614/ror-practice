def init
  puts 'now start continuous testing :)'
  run_rspec_with_doc
end

def run_rspec_default
  puts '============= the following are testing info ======================'

  # By default the above will run all _spec.rb files in the spec directory.
  system "date && bundle exec rspec"
end

def run_rspec_with_doc
  puts '============= the following are testing info ======================'

  # By default the above will run all _spec.rb files in the spec directory.
  system "date && bundle exec rspec -fd"
end

# init and run rspec first 
init

# observe all file in 'spec' folder
watch('^spec/.*/*_spec\.rb') do |match|
  run_rspec_with_doc
end
