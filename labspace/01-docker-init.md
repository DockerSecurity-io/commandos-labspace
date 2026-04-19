# Commando 1. Docker Init

**Mission**: Docker Commandos arrive at Asgard and initiate their mission to contain the outbreak. Gord orders, "Set up a command center for us". Valkyrie and Agent Null start setting up the command center, while Jack and Evie secure the perimeter.

![Docker Commandos setting up the command center](https://dockersecurity.io/commandos-asgard/asgard-init.png)

**Real-world context**: Docker Init creates secure, production-ready Dockerfiles using established best practices, reducing the likelihood of security misconfigurations from day one.

Docker Init is a command to initialize a Docker project with a Dockerfile and other necessary files:

- `Dockerfile`
- `compose.yaml`
- `.dockerignore`
- `README.Docker.md`

## Usage

Go to the `flask` directory and start the application using Docker Compose:

```bash
cd flask
docker compose up
```

The application will be available at [http://localhost:8000](http://localhost:8000).

> [!NOTE]
> After running `docker compose up`, the logs might show an error: Control server error: [Errno 13] Permission denied: '/nonexistent'. This is expected because the control server is trying to write to a directory that doesn't exist in the container. You can ignore this error and still access the application at [http://localhost:8000](http://localhost:8000).

After the `docker compose up` command, a docker image is built with the tag `flask-server:latest`. You can check it with:

```bash
docker images
```

## Docker Init

> [!NOTE]
> The files in this directory were created by `docker init`, which is not available in the Labspace experience. In your local machine, you can navigate to the `flask-uninit` directory and run `docker init` to generate the same files.

To learn about using `docker init` with a Java 26 project, check out the [Dockerize Java 26 with Docker Init](https://www.dockersecurity.io/blog/dockerize-java-26-with-docker-init) post.