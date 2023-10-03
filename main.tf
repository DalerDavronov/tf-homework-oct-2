terraform {
  cloud {
    organization = "Ziyotek_Terraform_Class_Summer_Cloud"

    workspaces {
      name = "infra-workspaces"
    }
  }
}
terraform {
  required_providers {
    tfe = {
      version = "~> 0.49.1"
    }
  }
}
provider "tfe" {
  hostname = "app.terraform.io" # Optional, defaults to Terraform Cloud `app.terraform.io`
  version  = "~> 0.49.1"
}

locals {
  infra-components = [
    "vpc",
    "subnet",
    "ec2"
  ]
  exec_type = "local"
}

resource "tfe_workspace" "test" {
  for_each       = toset(local.infra-components)
  name           = "infra-${each.key}"
  organization   = data.tfe_organization.summer-cloud.name
  execution_mode = local.exec_type

}
data "tfe_organization" "summer-cloud" {
  name = "Ziyotek_Terraform_Class_Summer_Cloud"
}
