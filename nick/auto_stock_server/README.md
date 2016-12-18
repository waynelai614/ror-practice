## Overview
> parse stock turnover from [here](http://stock.wearn.com/qua.asp)


## How to use

First, u have to install Rails

#### start server

``` shell
git checkout dev/Nick
cd ./nick/auto_stock_server
bundle install
rake db:migrate
rails s
```

#### Listening ports
localhost:3000

## Testing
using
[RSpec](https://github.com/rspec/rspec-rails)
as the test framework, and using [observr](https://github.com/kevinburke/observr)
to run the test automatically whenever an observed file is modified.

#### Usage
``` shell
$ observr observr.rb
``` 

## Todo lists

- [ ] restful route design
- [ ] auto-select stock info ( no more sending request manually )
- [ ] date-picker
- [ ] data validation
- [ ] view by react
- [ ] nosql database like mongodb
