# README

We recommend using [Docker](https://docs.docker.com/) to run this project, once you have it installed you can go through the following steps:

```shell
# Build Docker image to run the project
docker-compose build

# Create the database in the Docker image
docker-compose run web rake db:create

# Create database tables
docker-compose run web rake db:migrate

# Start the Rails application
docker-compose up
```

Now the Rails application should be available at [localhost:3001](http://localhost:3001/)

In order to run the automated test suite, you can type:

```shell
docker-compose run web rails test
```
