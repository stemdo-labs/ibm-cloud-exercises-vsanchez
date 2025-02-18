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
  name = "vpc-valentino-ej04"
  resource_group = var.resource_group
  
}

resource "ibm_is_subnet" "subnet" {
    name = "snet-valentino-ej04"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-1"
    ipv4_cidr_block = var.ipv4_cidr_block
    resource_group = var.resource_group
  
}

resource "ibm_is_security_group" "security_group" {
  name = "sg-valentino-ej04"
  vpc  = ibm_is_vpc.vpc.id
  resource_group = var.resource_group
}

resource "ibm_is_security_group_rule" "ssh" {
  group = ibm_is_security_group.security_group.id
  direction      = "inbound"
  tcp {
    port_min = 22
    port_max = 22
  }

} 