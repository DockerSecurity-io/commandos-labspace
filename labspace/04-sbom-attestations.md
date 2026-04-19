# Commando 4. SBOM Attestations

**Mission**: The Valkyrie sets up a camera with face recognition and says, "I can generate an ID card for everyone in Asgard, and attach it to their database face record. That way, we can verify their identity at the checkpoints."

![SBOM Attestations](https://dockersecurity.io/commandos-asgard/asgard-checkpoint.png)

**Real-world context**: SBOM attestations are SBOMs generated during build time and cryptographically signed, providing tamper-proof component information that travels with your image.

## Usage

Make sure you're in the `cpp` directory:

```bash
cd ~/project/cpp
```

SBOM attestations are generated during the build:

```bash
docker buildx build --sbom=true -t cpp-hello:with-sbom .
```

Now, let's check the CVEs with Docker Scout:

```bash
docker scout cves cpp-hello:with-sbom
```

It will say:

```
SBOM obtained from attestation, 0 packages found
```

The SBOM attestation is loaded, but it still has no packages.
To include the build stage packages in the SBOM, add the following line to the beginning of the `Dockerfile`:

```dockerfile
ARG BUILDKIT_SBOM_SCAN_STAGE=true
```

Now, rebuild the image:

```bash
docker buildx build --sbom=true -t cpp-hello:with-build-stage .
```

Check the SBOM attestations for the image again:

```bash
docker scout cves cpp-hello:with-build-stage
```

Scout should say:

```
SBOM obtained from attestation, 208 packages found
```

![SBOM Attestations](https://dockersecurity.io/commandos-asgard/asgard-3.1.png)

## Exercises

- 4.1. To store the BuildKit SBOM locally, you can set the output format to `local` and specify the destination directory. Use the following command to build the image and save the SBOM in the current directory:

    ```bash
    docker buildx build \
      --sbom=true \
      --output type=local,dest=out .
    ```

    The generated SBOM can be used later.