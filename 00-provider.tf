terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

provider "aws" {
        region = "eu-west-3"
        access_key = "<##ACCESS_KEY##>"
        secret_key = "<##SECRET_KEY##>"
}