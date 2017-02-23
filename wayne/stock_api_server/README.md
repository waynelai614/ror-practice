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
$ git clone git@github.com:waynelai614/ror-practice.git \
$ cd wayne/stock_api_server
```
### Run
Boot the app with
`$ docker-compose up`

after see some PostgreSQL output, you need to create the database in another terminal.
Run: `$ docker-compose run web rake db:create`

Visit: [http://0.0.0.0:3000](http://0.0.0.0:3000)

Note: If you stop the example application and attempt to restart it, you might get the following error: web_1 | A server is already running. Check [PROJECT]/tmp/pids/server.pid. One way to resolve this is to delete the file tmp/pids/server.pid, and then re-start the application with docker-compose up.
