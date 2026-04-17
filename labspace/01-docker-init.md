# Commando 1. Docker Init

**Mission**: Docker Commandos arrive at Asgard and initiate their mission to contain the outbreak. Gord orders, "Set up a command center for us". Valkyrie and Agent Null start setting up the command center, while Jack and Evie secure the perimeter.

![Docker Commandos setting up the command center](https://dockersecurity.io/commandos-asgard/asgard-init.png)

**Real-world context**: Docker Init creates secure, production-ready Dockerfiles using established best practices, reducing the likelihood of security misconfigurations from day one.

Docker Init is a command to initialize a Docker project with a Dockerfile and other necessary files:

- `Dockerfile`
- `compose.yaml`
- `.dockerignore`
- `README.Docker.md`

### Usage

> [!NOTE]  
> The command `docker init` is not available in the Labspace experience, so you can go to `flask-init` directly to see the generated files, and carry out the rest of the lab from there.

On the repo, go to the Flask example directory:

```bash
cd flask
```

Then, run the Docker Init command:

```bash
docker init
```

The command will ask you 4 questions, accept the defaults except for the Python version, that you should set to 3.14.3:

- ? What application platform does your project use? **Python**
- ? What version of Python do you want to use? **3.14.3**
- ? What port do you want your app to listen on? **8000**
- ? What is the command you use to run your app? **gunicorn 'hello:app' --bind=0.0.0.0:8000**

Then, start Docker Compose with build:

```bash
docker compose up --build
```

The application will be available at [http://localhost:8000](http://localhost:8000).
