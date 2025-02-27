terraform {
  required_version = ">=1.0.0, <2.0"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region         
}

resource "ibm_is_vpc" "vpc" {
  name = "vpc-valentino-ej03"
  resource_group = var.resource_group
}

resource "ibm_is_subnet" "subnet" {
    name = "snet-valentino-ej03"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-1"
    ipv4_cidr_block = var.ipv4_cidr_block
    resource_group = var.resource_group
  
}