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
cosign sign --key cosign.key $DOCKER_USERNAME/flask-server:latest
```

Verify the signature:

```bash
cosign verify --key cosign.pub $DOCKER_USERNAME/flask-server:latest
```

## Cosign SBOM Attestations

In exercise 4.1, we built the `cpp-hello` image with BuildKit SBOM attestations and saved the SBOM locally.

Let's go to the `cpp` directory:

```bash
cd ~/project/cpp
```

If the SBOM file is not there, build the image again with the `local` output format:

```bash
docker buildx build --sbom=true --sbom-output=type=local,dest=. -t test-image .`
```

Now, let's attach the SBOM attestation to the image:

```bash
docker scout attestation add \
    --file sbom-attestations/sbom.spdx.json \
    $DOCKER_USERNAME/flask-server:latest
```

Now, let's sign the SBOM attestation with Cosign:

```bash
cosign sign --key ../cosign-keys/cosign.key \
    --type attestation \
    --predicate-type https://spdx.dev/ \
    $DOCKER_USERNAME/flask-server:latest
```

> [!NOTE]
> Cosign will ask you to use the image SHA256 digest instead of the image tag.

Now, let's check the OCI Referrers for the image:

```bash
oras pull --include-subject $DOCKER_USERNAME/flask-server:latest
oras discover $DOCKER_USERNAME/flask-server:latest --platform linux/amd64
```

If you're building on Apple Silicon, make sure to specify the platform when pulling the image:

```bash
oras pull --include-subject --platform linux/amd64 $DOCKER_USERNAME/flask-server:latest
```

## Exercises

- 9.1. Research keyless signing with Sigstore.
