## Overview
> parse stock turnover from [here](http://stock.wearn.com/qua.asp)


## How to use

First, u have to install Rails

#### start server

```
git checkout dev/Nick
cd ./nick/auto_stock_server
bundle install
rake db:migrate
rails s
```

#### get stock message
localhost:3000 

#### update stock message
localhost:3000/stock/update

## Todo lists

- [ ] restful route design
- [ ] auto-select stock info ( no more sending request manually )
- [ ] date-picker
- [ ] data validation
- [ ] view by react
- [ ] nosql database like mongodb
