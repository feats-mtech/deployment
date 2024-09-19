# Deployment

This repository contains the files for local, testing and production deployment. This includes the following files:

`docker-compose-yml`: for local deployment

(Other files WIP)

## Commands

```sh
# starts up services in listed in `docker-compose.yml`
docker-compose up

# starts up services detached listed in `docker-compose.yml`
docker-compose up -d

# stops the services listed in `docker-compose.yml`
docker-compose down
```