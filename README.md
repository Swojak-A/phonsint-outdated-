# Phonsint v. 0.1.0

_Phonsint brief description..._

App is based on Flask 2.0.2 in python:3.9-slim docker image.

## How to start?

### 1. Install Docker

For this project it is advice to use [Docker](https://www.docker.com/get-started).
Install the latest version of Docker software dedicated for your operating system.
For development purposes Docker version 20.10.8, build 3967b7d was used.

### 2. Create `.env` file:

Go into the project directory and copy the content of `.env.example` file into `.env` file. 
You can use this shell command:

```shell
cp ./.env.example ./.env
```

### 3. Build docker image

Now you have to create a Docker image using command:

```shell
docker build . -t phonsint
```

The command will take a Dockerfile that is present inside the given directory and 
create brand, new docker image with tagged as: `phonsint`

#### Passing custom args to docker build

You may also want to pass build args into the build to modify its creation.
Currently, Dockerfile will look for 2 args:
- APP_ENV
- DOCKER_USER_UID

To pass custom args use command:

```shell
docker build . -t phonsint --build-arg APP_ENV=prod --build-arg DOCKER_USER_UID=999 --no-cache
```

### 4. Run docker container

Now you can run docker container:

```shell
docker run -d -p 5000:5000 --env-file ./.env phonsint
```

You can also pass `--name <custom-name>` args to use explicitly name your container.

You can skip `-d` arg to see logs in terminal.

### Alternative: use `docker compose`

This repo also included `docker-compose.yml` file for everyone who is accustomed to this way of running containers.
Use `docker-compose build` to build image and `docker-compose up -d` to run container.

## Useful commands

#### Logging into running container

To log into existing container use command:

```shell
docker exec -it <container-name> bash
```