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

Two SBOM files will be generated in the `out` directory. The one we care about is `sbom-build.spdx.json`, which contains the build stage dependencies. The other one, `sbom.spdx.json`, only contains the final stage dependencies, which are empty in this case because we used `FROM scratch` in the final stage.

We want to attest the `sbom-build.spdx.json` file to the image, so that it travels with the image and can be verified by consumers.

First, let's sign the image itself:

```bash
export IMAGE_DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' $DOCKER_USERNAME/cpp-hello:latest)
cosign sign --key ../cosign-keys/cosign.key $IMAGE_DIGEST
```

Now let's attest the SBOM file to the image. We will use the `spdxjson` predicate type, which is compatible with the SPDX SBOM format that BuildKit generates:

```bash
cosign attest --key ../cosign-keys/cosign.key \
    --type spdxjson \
    --predicate out/sbom-build.spdx.json \
    $IMAGE_DIGEST
```

To verify the attestation is there and correctly linked to the image, we use `oras`, which is a tool for working with OCI artifacts and their referrers (attestations):

```bash
oras discover docker.io/$IMAGE_DIGEST
```

The output should show a tree where the image digest is the root, and the Cosign bundle (containing your signature and SBOM attestation) is listed as a referrer. It verifies that the SBOM attestation is correctly linked to the image and signed by you.

> [!NOTE]
> This is promise of the workshop: to have a signed SBOM attestation that includes dependencies also from the build stage. BuildKit can't sign the image, and Cosign can't generate the SBOM.

## Exercises

- 9.1. Research keyless signing with Sigstore.
