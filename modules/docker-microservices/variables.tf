
variable "chemistry" {
  description = "Version of Chemistry ms to install"
  default = ""
  type = string
  validation {
    condition = length(regexall("(\\d+)?(\\.(\\d+))?(\\.(\\d+))?(([\\.|\\-])(\\S+))?", var.chemistry)) > 0
    error_message = "Please supply a valid semantic version string."
  }
}


variable "document_converter" {
  description = "Version of Aspose document converter ms to install"
  default = ""
  type = string
  validation {
    condition = length(regexall("(\\d+)?(\\.(\\d+))?(\\.(\\d+))?(([\\.|\\-])(\\S+))?", var.document_converter)) > 0
    error_message = "Please supply a valid semantic version string."
  }
}

variable "dna" {
  description = "Version of Snapgene DNA visualizer ms to install"
  default = ""
  type = string
  validation {
    condition = length(regexall("(\\d+)?(\\.(\\d+))?(\\.(\\d+))?(([\\.|\\-])(\\S+))?", var.dna)) > 0
    error_message = "Please supply a valid semantic version string."
  }
}

variable "dockerhub_pw" {
  description = "A password or access key for the ResearchSpace Dockerhub account"
  type = string
}