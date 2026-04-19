# Commando 8. Docker Bake

**Mission**: As the Commandos defeated the CVEs in Asgard, they decided to throw a party to celebrate their victory, and discuss the security measures they can implement systematically.

![The Commandos celebrate their victory](https://dockersecurity.io/commandos-asgard/asgard-5.png)

**Real-world context**: Docker Bake allows you to define complex build configurations in files, making security practices repeatable, reviewable, and automated across your entire organization.

## Usage

In the previous section, we rebuilt the `flask-server` image with a rather long build command:

```bash
docker build \
    --sbom=true \
    --province=true \
    -t $DOCKER_USERNAME/flask-server:attest \
    --push .
```

Adding more options to the build command, such as multi-platform builds, can make it even more unwieldy. Docker Bake allows you to define all these options in a file and run the build with a simple command.

Examine the `docker-bake.hcl` file:

```hcl
target "default" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["flask-server:tasty"]

  attest = [
    {
      type = "sbom"
    }
  ]
}
```

Run the build with Bake:

```bash
docker bake
```

Alter the `docker-bake.hcl` file to include multi-platform builds:

```hcl
target "default" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["flask-server:tasty"]
  platforms = ["linux/amd64", "linux/arm64"]
  
  attest = [
    {
      type = "sbom"
    }
  ]
}
```

## Exercises

- 8.1. Add provenance attestations to the bake file.
- 8.2. Check the [bake reference docs](https://docs.docker.com/build/bake/reference/) for more options to include in the `docker-bake.hcl` file, and try them out!

