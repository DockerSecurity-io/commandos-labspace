# Commando 7. VEX Attestation

**Mission**: Mina issues "Check Exemption" badges for the exempted CVE. "We won't hunt you down anymore with this badge," says Mina to the CVE.

![Mina issues a VEX attestation for the exempted CVE](https://dockersecurity.io/commandos-asgard/asgard-vex.png)

**Real-world context**: VEX attestations are cryptographically signed exemptions that travel with your image, providing tamper-proof vulnerability exception documentation that's verified automatically.

## Usage

One can add a VEX attestation to an image after it was pushed to the registry using Docker Scout. Let's push the `flask-server` image to the registry first, using your own Docker Hub username:

```bash
export DOCKER_USERNAME=your-docker-hub-username
```

Then build the image once more with SBOM and provenance attestations:

```bash
docker build \
    --sbom=true \
    --provenance=true \
    -t $DOCKER_USERNAME/flask-server:attest \
    --push .
```

> [!NOTE]
> Provenance attestations record the build information, such as the build time, builder, and source code repository. This information can be useful for traceability and debugging.

Before adding the VEX attestation, let's check the CVEs for the image to pick a nice high-severity CVE to exempt:

```bash
docker scout cves $DOCKER_USERNAME/flask-server:attest
```

Recreate the VEX statement with the correct PURL for the image being pushed and target the high-severity OpenSSL CVE:

```bash
vexctl create \
  --author="mohammad-ali@aerabi.com" \
  --product="pkg:docker/$DOCKER_USERNAME/flask-server@attest" \
  --subcomponents="pkg:deb/debian/openssl@3.5.5-1~deb13u1" \
  --vuln="CVE-2026-28390" \
  --status="not_affected" \
  --justification="vulnerable_code_not_in_execute_path" \
  --file="vex-statements/CVE-2026-28390.vex.json"
```

![Mina issues a card and gives it to the CVE](https://dockersecurity.io/commandos-asgard/asgard-vex-card.png)

Then, add the VEX attestation to the image:

```bash
docker scout attestation add \
  --file vex-statements/CVE-2026-28390.vex.json \
  --predicate-type https://openvex.dev/ns/v0.2.0 \
  $DOCKER_USERNAME/flask-server:attest
```

Let's check the CVEs for the image again:

```bash
docker scout cves $DOCKER_USERNAME/flask-server:attest
```

The result says:

```
    ✗ HIGH CVE-2026-28390
      https://scout.docker.com/v/CVE-2026-28390
      Affected range : <3.5.5-1~deb13u2                                   
      Fixed version  : 3.5.5-1~deb13u2                                    
      VEX            : not affected [vulnerable code not in execute path] 
                     : mohammad-ali@aerabi.com
```

Now, let's check all the attestations on the image:

```bash
docker scout attestation list $DOCKER_USERNAME/flask-server:attest
```

![Mina found a new warrior when fighting CVEs](https://dockersecurity.io/commandos-asgard/asgard-4.5.png)

## VEX Attestations and OCI Referrers

VEX attestations we created here were Scout-specific. The SBOM attestations we created in Commando 4 were BuildKit attestations. The industry is moving toward a standard format for attestations called OCI Referrers, which are supported by multiple tools and registries.

Let's check the OCI Referrers for a Docker Hardened Image:

```bash
oras pull --include-subject dhi.io/node:25 
oras discover dhi.io/node:25 --platform linux/amd64
```

The output lists the SBOM and VEX attestations for the image, as well as their signatures.

## Exercises

- 7.1. Research OCI referrers and other ways to create VEX attestations.
