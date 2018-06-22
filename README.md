# Stock api server

Parsing daily top 50 turnover from  [聚財網](https://stock.wearn.com/qua.asp) and display it as a stock board.  
<table><tr><td>
    <img src="https://i.imgur.com/sBXH8VY.png" />
</td></tr></table>

## Environment

- Ruby@2.1.5
- Rails@3.2.22.1
- sqlite3

## Dependencies
- [angularjs-rails](https://github.com/hiravgandhi/angularjs-rails): Angular.js wrapper for Rails
- [nokogiri](https://github.com/sparklemotion/nokogiri): Using nokogiri to parse html
- [whenever](https://github.com/javan/whenever): Cron jobs in Ruby
- [rspec-rails](https://github.com/rspec/rspec-rails): Testing framework for Rails
- [jasmine](https://github.com/jasmine/jasmine-gem): Testing framework for Angular

## Testing

**start the Jasmine server at localhost:8888:**
``` bash
rake jasmine
```
**run RSpec:**
``` bash
bundle exec rspec
```

## Build Setup

``` bash
# install dependencies
bundle install

# database migrations
rake db:migrate

# start local serve at localhost:3000
rails server
```