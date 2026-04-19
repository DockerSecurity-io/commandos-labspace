target "default" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["flask-server:tasty"]

  attest = [
    {
      type = "sbom"
    }
  ]
}
