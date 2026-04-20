
# Pre-Workshop Setup: Docker Commandos

The workshop runs entirely inside a container with all required tools pre-installed (`vexctl`, `oras`, `trivy`, `cosign`, `docker scout`, etc.). No local tool installation is needed.

## Pull the Images

To avoid slow downloads during the workshop, pre-pull all required images:

```bash
make pull
```

That's it. You're ready.