# Commando 6. The Exempted CVEs

**Mission**: Mina is patroling the district and finds a CVE that seems to be depressed. "This CVE is not a threat to us, it can be exempted from our extermination list," says Mina to herself.

![Mina finds a depressed CVE](https://dockersecurity.io/commandos-asgard/asgard-useless.png)

**Real-world context**: Not all CVEs are exploitable in your specific context. VEX (Vulnerability Exploitability eXchange) allows you to mark CVEs as not applicable to reduce alert noise and focus on real threats.

## Usage

Let's go back to the `flask` directory:

```bash
cd ~/project/flask
```

Let's check the CVEs in the `flask-server` image again:

```bash
docker scout cves flask-server
```

Scroll down to find the CVE-2025-45582, which has no fixed version (at the time of writing) and is marked as "medium".

Create a VEX statement for one of the CVEs:

```bash
vexctl create \
  --author="your-email@example.com" \
  --product="pkg:docker/flask-server@latest" \
  --subcomponents="pkg:deb/debian/tar@1.35+dfsg-3.1" \
  --vuln="CVE-2025-45582" \
  --status="not_affected" \
  --justification="vulnerable_code_not_in_execute_path" \
  --file="CVE-2025-45582.vex.json"
```

Apply the VEX statement to Scout scan:

```bash
mkdir vex-statements
mv CVE-2025-45582.vex.json vex-statements/

docker scout cves flask-server --vex-location ./vex-statements
```

The output will flag the CVE as "not affected [vulnerable code not in execute path]".

## Exercises

- 6.1. Identify a CVE in your application that's not exploitable and create a proper VEX statement.
- 6.2. Research VEX justification categories and determine which applies to your use case.
