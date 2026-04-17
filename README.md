# Docker Commandos Labspace

This repository contains the content and configuration for the **Docker Commandos: Asgard Mission** labspace. This labspace is designed to be run in interactive environments similar to Killercoda.

## Structure

- `labspace.yaml`: The main configuration file defining the metadata, title, and sequence of sections.
- `*.md`: Markdown files for each section of the lab, following the Docker Commandos storyline.

## Launch the Labspace

### OCI Artifact (recommended)

No clone needed, run directly from the published OCI artifact:

```bash
docker compose -f oci://docker.io/aerabi/docker-commandos-labspace up -d
```

Then open your browser at `http://localhost:3030`.

### Docker Desktop extension

To use the Docker Desktop extension, you need to have the Labspace extension installed. If not:

```bash
docker extension install dockersamples/labspace-extension
```

Then [click this link](https://open.docker.com/dashboard/extension-tab?extensionId=dockersamples/labspace-extension&location=aerabi/docker-commandos-labspace&title=Docker%20Commandos%3A%20Asgard%20Mission) to launch the Labspace.

### Local development (from clone)

If you want to run the Labspace from a local clone, you can do so with Docker Compose. First, clone the repository:

```bash
git clone https://github.com/DockerSecurity-io/commandos-labspace.git
cd commandos-labspace
```

Then run:

```bash
docker compose up -d
```

Then open your browser at `http://localhost:3030`.

## Content Overview

The lab walks through 10 security "Commandos":
1. **Docker Init**: Secure project initialization.
2. **SBOM**: Software Bill of Materials.
3. **Scout**: Vulnerability scanning.
4. **SBOM Attestations**: Build-time metadata.
5. **Hardened Images**: Using `dhi.io`.
6. **Exempted CVEs**: VEX statements.
7. **VEX Attestation**: Signed exemptions.
8. **Docker Bake**: Complex build automation.
9. **Cosign**: Cryptographic signing.
0. **Zero-Day**: Defense-in-depth.
