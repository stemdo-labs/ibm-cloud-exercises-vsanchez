terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

provider "ibm" {

  region = "eu-es"
  ibmcloud_api_key=var.ibmcloud_api_key

}
 

resource "ibm_is_vpc" "vpc" {
  name = "vpc-valentino-ej04"
  resource_group = var.resource_group
  
}

resource "ibm_is_subnet" "subnet" {
    name = "snet-valentino-ej04"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-1"
    ipv4_cidr_block = "10.251.20.0/24"
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
  remote         = "0.0.0.0/0" 
  ip_version     = "ipv4"
  tcp {
    port_min = 22
    port_max = 22
  }

} 

resource "ibm_is_ssh_key" "ssh_key" {
  name       = "ssh-key-valentino-ej04"
  public_key = var.public_key
  resource_group = var.resource_group
}


resource "ibm_is_instance" "mv-instance" {
  name             = "mv-valentino-ej04"
  image            = "r050-b98611da-e7d8-44db-8c42-2795071eec24"
  profile          = "bx2-2x8"
  resource_group   = var.resource_group
  vpc              = ibm_is_vpc.vpc.id
  keys             = [ibm_is_ssh_key.ssh_key.id]
  zone             = var.zone
  primary_network_interface {
    subnet  = ibm_is_subnet.subnet.id
    security_groups  = [ibm_is_security_group.security_group.id]
  }

}