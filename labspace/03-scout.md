# Commando 3. Scout

**Mission**: Gord orders Jack, Agent Null, and Mina to scout the remaining districts of Asgard for hidden CVEs. "Let's hunt some CVEs!" says Null.

![Scout hunting for CVEs](https://dockersecurity.io/commandos-asgard/asgard-3.png)

**Real-world context**: Docker Scout analyzes your images for vulnerabilities by cross-referencing the SBOM with CVE databases, providing actionable security intelligence.

## Usage

To check the vulnerabilities in the image, run:

```bash
docker scout cves flask-server:latest
```

You can also check the vulnerabilities using the Docker Desktop UI. Just go to the "Images" tab, select the image, and click on "Scout".

Try comparing base images for security:

```bash
# Standard Node image
docker scout cves node:25
```

Versus:

```bash
# Alpine Node image
docker scout cves node:25-alpine
```

Which one has fewer vulnerabilities?

## CVEs for Multi-Stage Builds

Let's go to the C++ directory and build the image:

```bash
cd ~/project/cpp
docker build -t cpp-hello .
```

Then check the CVEs:

```bash
docker scout cves cpp-hello
```

The output will show that Scout has "indexed 0 packages". This is because the SBOM generated for this image only includes the final stage, which doesn't have any packages.

## Exercises

- 3.1. Build an application with an old base image (e.g., `node:14`) and compare Scout results with newer versions.
- 3.2. Use the `--details` flag to get more information about specific vulnerabilities.
