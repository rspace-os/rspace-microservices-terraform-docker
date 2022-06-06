
module "rspace" {
  source = "./modules/docker-microservices"
  ## Mandatory. ResearchSpace will supply an access token on request
  dockerhub_pw = var.dockerhub_pw

  ## just include the services you want - comment out those you don't.
  chemistry = "1.2.2"
  document_converter = "0.0.12"
  //dna = "0.0.9"
}






