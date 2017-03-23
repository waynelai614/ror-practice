# Stock API Server
[![Build Status](https://travis-ci.org/waynelai614/ror-practice.svg?branch=dev/wayne)](https://travis-ci.org/waynelai614/ror-practice)

### Requirements
Before starting, you'll need to have those below.
* [Docker](https://docs.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

### Environments
* `Ruby@2.1.5`
* `Rails@3.2.11.1`
* `Node@7.7.3`
* `NPM@4.1.2`
* `Angular@^1.5.0`

### Clone the project
```
$ git clone -b dev/wayne git@github.com:waynelai614/ror-practice.git
$ cd ror-practice/wayne/stock_api_server
```
### Running the app
Boot the app with
```
$ docker-compose up -d

# setup start cron job
# create and migrate database
# crawl stock website and save data to database
$ sh ./setup.sh
```
You can list installed cron jobs using `$ crontab -l`

Visit: [http://0.0.0.0:3000](http://0.0.0.0:3000)

### Crawl stock website via API
`
#POST http://0.0.0.0:3000/api/stock/crawl
`

### Developing
Check container name `stockapiserver_web_1` & `stockapiserver_db_1` status is up

`$ docker ps`

Run webpack-dev-server

`$ sh ./webpackDevServer.sh`

* Rails server: [http://0.0.0.0:3000](http://0.0.0.0:3000)
* Angular(webpack-dev-server): [http://0.0.0.0:8080](http://0.0.0.0:8080)

When container is start, webpack compiled static files are already in `stock_api_server/public/stock` directory.
After developing angular web application using `webpack-dev-server`,
you need to run `$ sh ./webpackBuild.sh` to update static files.

Visit: [http://0.0.0.0:3000/stock](http://0.0.0.0:3000/stock), check everything works!

### Testing

* RSpec `$ docker-compose run web rspec spec`
* Karma
  * Single run `$ sh ./test.sh`
  * Live mode `$ sh ./testWatch.sh`
    * Karma server started at [http://0.0.0.0:9876/](http://0.0.0.0:9876/)
