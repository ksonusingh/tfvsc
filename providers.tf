terraform {
  /*cloud {
    organization = "sonuterraform"

    workspaces {
      name = "terraform-function-poc"
    }
  } */

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  region  = var.my_region
}
provider "aws" {
  region = var.my_region
  alias ="secondary"
}

