# Commando 9. Cosign

**Mission**: With the party still going, Evie steps away from the celebration and quietly gets to work. One by one, she signs each SBOM attestation and each VEX attestation with her special pen, ensuring their originality. "A document without a signature is just a rumor," she says.

![Evie signing the SBOM and VEX attestations](https://dockersecurity.io/commandos-asgard/asgard-sign.png)

**Real-world context**: Cosign (part of the Sigstore project) lets you cryptographically sign container images and attestations. Consumers can then verify those signatures before running anything.

## Usage

Let's go back to the root of the project and create a directory for the keys:

```bash
cd ~/project
mkdir cosign-keys
cd cosign-keys
```

Generate a key pair:

```bash
cosign generate-key-pair
```

Sign the image you pushed to the registry earlier:

```bash
cosign sign --key cosign.key $DOCKER_USERNAME/flask-server:attest
```

Verify the signature:

```bash
cosign verify --key cosign.pub $DOCKER_USERNAME/flask-server:attest
```

## Cosign SBOM Attestations

In previous sections, we built the `cpp-hello` image locally. Now, let's push it to your Docker Hub registry so we can sign it and attach attestations.

Let's go to the `cpp` directory:

```bash
cd ~/project/cpp
```

Build and push the image:

```bash
docker build -t $DOCKER_USERNAME/cpp-hello:latest --push .
```

Now, let's generate the SBOM locally so we can attach it as an attestation:

```bash
docker buildx build \
  --sbom=true \
  --output type=local,dest=out .
```

### Signing the Image

First, let's sign the image itself:

```bash
cosign sign --key ../cosign-keys/cosign.key $DOCKER_USERNAME/cpp-hello:latest
```

### Attesting the SBOM

Instead of using Docker Scout, we will use Cosign to attach the SBOM as an OCI 1.1 attestation. This command both signs the SBOM and attaches it to the image in the registry:

```bash
cosign attest --key ../cosign-keys/cosign.key \
    --type spdx \
    --predicate out/sbom.spdx.json \
    $DOCKER_USERNAME/cpp-hello:latest
```

### Verifying with ORAS

Now, let's use `oras` to verify that the attestations and signatures are correctly linked to the image as referrers:

```bash
oras discover $DOCKER_USERNAME/cpp-hello:latest
```

If you are on an ARM-based machine (like Apple Silicon) and the image was built for a different platform, you might need to specify it:

```bash
oras discover $DOCKER_USERNAME/cpp-hello:latest --platform linux/amd64
```

## Exercises

- 9.1. Research keyless signing with Sigstore.
