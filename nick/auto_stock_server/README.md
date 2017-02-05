

# auto stock server
[![Build Status](https://travis-ci.org/rakuten-f2e/ror-practice.svg?branch=dev/nick)](https://travis-ci.org/rakuten-f2e/ror-practice)
>  auto turnover server parsing data from [here](http://stock.wearn.com/qua.asp)


* [whenever](https://github.com/javan/whenever)
: Cron jobs in Ruby
* [nokogiri](https://github.com/sparklemotion/nokogiri)
: HTML, XML, SAX, and Reader parser
* [rubocop](https://github.com/bbatsov/rubocop)
: A Ruby static code analyzer
* [factory_girl](https://github.com/thoughtbot/factory_girl)
: A library for setting up Ruby objects as test data.

## Environment

* rails 4.2.4
* ruby 2.3.0p0

## Getting started

``` shell
git checkout dev/nick
cd ./nick/auto_stock_server
bundle install
rails s
```

### Listening port
``` 
localhost:3000 
```


## Testing
> Using
[RSpec](https://github.com/rspec/rspec-rails)
as the test framework, and   [observr](https://github.com/kevinburke/observr)
to run the test automatically whenever an observed file is modified.

### Format RSpec output


```shell
$ bundle exec rspec -fd
```

### Continuous testing
```shell
$ observr observr.rb
```

## Todo lists

- [x] restful route design
- [x] auto-select stock info ( no more sending request manually )
- [x] nosql database like mongodb
- [x] test
- [ ] coverage using SimpleCov
- [ ] date-picker
- [ ] view by react/redux
- [ ] seperate view by Web server
- [ ] Docker
