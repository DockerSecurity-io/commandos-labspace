# Commando 7. VEX Attestation

**Mission**: Mina issues "Check Exemption" badges for the exempted CVE. "We won't hunt you down anymore with this badge," says Mina to the CVE.

![Mina issues a VEX attestation for the exempted CVE](https://dockersecurity.io/commandos-asgard/asgard-vex.png)

**Real-world context**: VEX attestations are cryptographically signed exemptions that travel with your image, providing tamper-proof vulnerability exception documentation that's verified automatically.

## Usage

One can add a VEX attestation to an image after it was pushed to the registry using Docker Scout. Let's push the `flask-server` image to the registry first, using your own Docker Hub username:

```bash
export $DOCKER_USERNAME=your-docker-hub-username
```

Then let's push the image:

```bash
docker tag flask-server:latest $DOCKER_USERNAME/flask-server:latest
docker push $DOCKER_USERNAME/flask-server:latest
```

Add VEX attestation to image:

```bash
docker scout attestation add \
  --file vex-statements/CVE-2025-45582.vex.json \
  --predicate-type https://openvex.dev/ns/v0.2.0 \
  $DOCKER_USERNAME/flask-server:latest
```

Next time, you won't need to pass the VEX statement to the Scout scan, as it is already attached to the image:

```bash
docker scout cves $DOCKER_USERNAME/flask-server:latest
```

![Mina found a new warrior when fighting CVEs](https://dockersecurity.io/commandos-asgard/asgard-4.5.png)

## VEX Attestations and OCI Referrers

VEX attestations we created here were Scout-specific. The SBOM attestations we created in Commando 4 were BuildKit attestations. The industry is moving toward a standard format for attestations called OCI Referrers, which are supported by multiple tools and registries.

Let's check the OCI Referrers for a Docker Hardened Image:

```bash
oras pull --include-subject dhi.io/node:20 
oras discover dhi.io/node:20 --platform linux/amd64
```

The output lists the SBOM and VEX attestations for the image, as well as their signatures.

## Exercises

- 7.1. Research OCI referrers and other ways to create VEX attestations.
