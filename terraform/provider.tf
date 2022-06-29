terraform {
    required_version = ">= 0.13"
    required_providers{
        aws ={
            source = "hashicorp/aws"
            version = "~> 3.14.1"
        }

        helm ={
            source  = "hashicorp/helm"
            version = ">= 1.0"
        }

        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = ">= 2.10"
        }
    }
    backend "s3" {
        bucket = "stav-project"
        key = "terraform.tfstate"
        region = "eu-west-1"
    }
}

provider "aws" {
    region = "eu-west-1"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
