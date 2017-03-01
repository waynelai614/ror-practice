# Stock API Server

### Requirements
Before starting, you'll need to have those below.
* [Docker](https://docs.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)

### Environments
* `Ruby@2.1.5`
* `Rails@3.2.11.1`

### Clone the project
```
$ git clone -b dev/wayne git@github.com:waynelai614/ror-practice.git
$ cd ror-practice/wayne/stock_api_server
```
### Run
Boot the app with
`$ docker-compose up`

after see some PostgreSQL output:
```
web_1  | [2017-02-23 10:22:47] INFO  WEBrick 1.3.1
web_1  | [2017-02-23 10:22:47] INFO  ruby 2.1.5 (2014-11-13) [x86_64-linux]
web_1  | [2017-02-23 10:22:47] INFO  WEBrick::HTTPServer#start: pid=1 port=3000
```
and then you need to create the database in another terminal.
Run: `$ docker-compose run web rake db:create`

Visit: [http://0.0.0.0:3000](http://0.0.0.0:3000)

> Note: If you stop the example application and attempt to restart it, you might get the following error: 
> web_1 | A server is already running. Check [PROJECT]/tmp/pids/server.pid. 
> One way to resolve this is to delete the file **tmp/pids/server.pid**, and then re-start the 
> application with `$ docker-compose up`.
