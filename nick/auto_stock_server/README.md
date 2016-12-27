## Overview
> parse stock turnover from [here](http://stock.wearn.com/qua.asp)


* [whenever](https://github.com/javan/whenever)
: Cron jobs in Ruby
* [nokogiri](https://github.com/sparklemotion/nokogiri)
: HTML, XML, SAX, and Reader parser

## How to use

First, u have to install Rails

#### start server

``` shell
git checkout dev/nick
cd ./nick/auto_stock_server
bundle install
rails s
```

#### Listening ports
localhost:3000

## Testing
Using
[RSpec](https://github.com/rspec/rspec-rails)
as the test framework, and   [observr](https://github.com/kevinburke/observr)
to run the test automatically whenever an observed file is modified.
Besides, clean the database between each unit test and test suite with
[database_cleaner](https://github.com/DatabaseCleaner/database_cleaner).

#### Usage

###### Format RSpec output


```shell
$ bundle exec rspec -fd
```

###### Continuous testing
```shell
$ observr observr.rb
```

## Todo lists

- [x] restful route design
- [x] auto-select stock info ( no more sending request manually )
- [x] nosql database like mongodb
- [ ] test
- [ ] rcov for test coverage
- [ ] date-picker
- [ ] view by react/redux
- [ ] seperate view by Web server
- [ ] Docker
