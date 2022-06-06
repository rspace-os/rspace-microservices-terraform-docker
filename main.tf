

terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

variable "dockerhub_pw" {
  type =string
}

provider "docker" {
   registry_auth {
    address     = "registry-1.docker.io"
    username="rspaceops"
    password = var.dockerhub_pw
    //config_file = pathexpand("~/.docker/config.json")
  }

}

# Start a container
resource "docker_container" "chemistry" {
  name  = "chemistry"
  image = docker_image.chem.latest
  ports {
      internal = 8060
      external = 8099
  }
  restart = "unless-stopped"
  
}

resource "docker_container" "snapgene" {
  name  = "snapgene"
  image = docker_image.snapgene.latest
  ports {
      internal = 8081
      external = 8082
  }
  restart = "unless-stopped"
  
}

# Find the latest Ubuntu precise image.
resource "docker_image" "chem" {
  name = "rspaceops/rspace-services:chemistry-web-1.2.2"
}

resource "docker_image" "snapgene" {
  name = "rspaceops/rspace-services:snapgene-web-0.0.9"
}

