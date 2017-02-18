# ror-practice
Ruby on Rails Practice Repo

### Goals
- Need to know how to write a RESTful
- Need to know how to interact with database
- Need to know how to interact with file system

### Implementation
* Get daily top 50 turnover(成交量) and save to database
  * Check [this](http://stock.wearn.com/qua.asp) to find the turnover everyday
  * You have to save following stock informations to database
    ![Alt text](http://i.imgur.com/fqem08U.png)
  * You can provide a RESTful API to do this job or another way you think better

* Give a RESTful API which can get the turnover by ```date(日期)``` and ```ID(代號)```(OR condition)
* Give a RESTful API which can sort by any stock information and save the result as a file

### System Requirement
* `Angular 1.x` (`1.2` will be better)
  * Try to use directive to wrap the widget
* `Ruby@2.1.5`
* `Rails@3.2.22.1`
* Write test is necessary, both for angular and Ruby
  * Use `RSpec` and `factory_girl` for ROR
  * Use `Karma` and any BDD testing framework you like for Angular
  * Write test if your component or function is in incubating instead of finish
* Your Development/Production is supposed to be setted up in the `Docker`
  * Before development, bootstrap your application in the `Docker` instead of your host
* Deploy your code to `Travis CI`
* Don't push a huge commit, you are supposed to be sliced your commit by each task

### Advance practice
No idea, any suggestion is welcome :)
