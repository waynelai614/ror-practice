## Overview
> parse stock turnover from [here](http://stock.wearn.com/qua.asp)


## How to use

First, u have to install Rails

#### start server

``` shell
git checkout dev/Nick
cd ./nick/auto_stock_server
bundle install
rails s
```

#### Listening ports
localhost:3000

## Testing
using
[RSpec](https://github.com/rspec/rspec-rails)
as the test framework, and using [observr](https://github.com/kevinburke/observr)
to run the test automatically whenever an observed file is modified.
Besides, cleaning the database between each unit test and test suite with
[database_cleaner](https://github.com/DatabaseCleaner/database_cleaner).

#### Usage
``` shell
$ observr observr.rb
```

## Todo lists

- [x] restful route design
- [x] auto-select stock info ( no more sending request manually )
- [x] nosql database like mongodb
- [ ] test
- [ ] date-picker
- [ ] view by react/redux
- [ ] seperate view by Web server
- [ ] Docker
