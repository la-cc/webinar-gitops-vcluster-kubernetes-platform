terraform {
  required_version = ">=1.9.3"

  backend "s3" {
    bucket = "blueprint-demo-tfstate"
    key    = "tfstate-demo"
    endpoints = {
      s3 = "https://object.storage.eu01.onstackit.cloud"
    }
    region                      = "eu01"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    skip_requesting_account_id  = true
    secret_key                  = "REPLACE-ME"
    access_key                  = "REPLACE-ME"
  }
  required_providers {
    terraform = {
      source = "terraform.io/builtin/terraform"
    }
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.40.0"
    }
  }
}

provider "stackit" {
  region                   = var.project_region
  service_account_key_path = var.service_account_key_path
  private_key_path         = var.private_key_path

}
