# Docker

Docker can be used for test and development.

Background reading: https://docs.docker.com/compose/rails/

Multiple Compose files are used to cater for different environments as per

https://docs.docker.com/compose/extends/

## Sample development commands

Build the project

```
docker-compose build
```

Install gems - development
```
docker-compose run --rm app bundle install
# uncomment BUNDLE_GEMFILE in docker-compose.override.yml to trigger @next_upgrade
```

Update a gem
```
docker-compose run --rm app bundle update rails
```

Install gems - test
```
docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app bundle install
```

Setup the database - development
```
docker-compose run --rm app bundle exec rake db:create db:schema:load
```

Setup the database - test
```
docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app bundle exec rake db:create db:schema:load
```

Run specs

```
docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app bundle exec rspec
```

Run rails server accessible on http://localhost:3000/

```
docker-compose up
```

Open bash inside the application container

```
docker-compose run --rm app /bin/bash
```
