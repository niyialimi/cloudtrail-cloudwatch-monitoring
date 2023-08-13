provider "aws" {
  region     = var.AWS_REGION

  default_tags {
    tags = {
      project     = "cloudtrail-cloudwatch-monitoring"
      environment = "dev"
      managedby   = "terraform"
      owner       = "Niyi-Alimi"
    }
  }
}