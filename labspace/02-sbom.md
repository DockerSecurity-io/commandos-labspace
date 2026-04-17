# Commando 2. SBOM

**Mission**: Rothütle asks Thor for a list of all Asgard residents. Now the Commandos can cross-reference with the CVE database to identify which residents are CVEs.

![Rothütle asking for the SBOM](https://dockersecurity.io/commandos-asgard/asgard-2.png)

**Real-world context**: SBOM (Software Bill of Materials) lists all components, libraries, and dependencies in your software. Essential for identifying vulnerabilities in your supply chain.

### Usage

In the Docker Init step, we built an image with tag `flask-server:latest`. Let's check the SBOM for this image:

```bash
docker scout sbom flask-server:latest --format list
```

The output will show the SBOM in a table format. Try to export it to a SPDX file:

```bash
docker sbom flask-server:latest --format spdx --output sbom.spdx.json
```

If you investigate the file, you will see that it contains a list of all the packages used in the image, their versions, and the licenses.

### Exercises

- 2.1. Use `docker scout sbom --help` to check available formats for the SBOM output.
- 2.2. Compare different base images: `docker sbom node:22` vs `docker sbom node:22-alpine` - which has fewer packages?
