
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  registry_auth {
    address     = "registry-1.docker.io"
    username="rspaceops"
    password = var.dockerhub_pw
  }
}

locals {
  dna_external_port=8082
  document_converter_external_port=8081
  chemistry_external_port=8099
}


resource "docker_container" "chemistry" {
  name  = "chemistry"
  count = length(var.chemistry) > 0 ? 1 :0
  image = docker_image.chem[0].latest
  ports {
    internal = 8060
    external = local.chemistry_external_port
  }
  restart = "unless-stopped"
  mounts {
    source = "chemistry-logs"
    target = "/logs"
    type   = "volume"
  }

}

output "dna_external_port" {
  value = length(docker_container.chemistry) > 0 ? local.dna_external_port: null
}

output "document_converter_external_port" {
  value = length(docker_container.document_converter) > 0 ? local.document_converter_external_port: null
}

output "chemistry_external_port" {
  value = length(docker_container.chemistry) > 0 ?local.chemistry_external_port: null
}

resource "docker_container" "snapgene" {
  name  = "snapgene"
  count = length(var.dna) > 0 ? 1 :0
  image = docker_image.snapgene[0].latest
  ports {
    internal = 8081
    external = local.dna_external_port
  }
  restart = "unless-stopped"
  mounts {
    source = "snapgene-logs"
    target = "/snapgene-working"
    type   = "volume"
  }
}

resource "docker_container" "document_converter" {
  name  = "document_converter"
  count = length(var.document_converter) > 0 ? 1 :0
  image = docker_image.document_converter[0].latest
  ports {
    internal = 8060
    external = local.document_converter_external_port
  }
  restart = "unless-stopped"
  mounts {
    source = "aspose-logs"
    target = "/logs"
    type   = "volume"
  }
}

# Find the latest Ubuntu precise image.
resource "docker_image" "chem" {
  count = length(var.chemistry) > 0 ? 1 :0
  name = "rspaceops/rspace-services:chemistry-web-${var.chemistry}"
}

resource "docker_image" "snapgene" {
  count = length(var.dna) > 0 ? 1 :0
  name = "rspaceops/rspace-services:snapgene-web-${var.dna}"
}

resource "docker_image" "document_converter" {
  count = length(var.document_converter) > 0 ? 1 :0
  name = "rspaceops/rspace-services:aspose-web-${var.document_converter}"
}