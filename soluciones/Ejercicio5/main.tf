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

resource "ibm_is_ssh_key" "example" {
  name       = "ssh-key-valentino-ej04"
  public_key = var.public_key
}

resource "ibm_is_virtual_network_interface" "example"{
    name                                    = "vni-valentino-ej04"
    allow_ip_spoofing               = false
    enable_infrastructure_nat   = true
    primary_ip {
        auto_delete       = false
    address             = var.ipv4_cidr_block
    }
    subnet   = ibm_is_subnet.example.id
}

resource "ibm_is_instance" "example" {
  name             = "mv-valentino-ej04"
  image            = var.image
  profile          = "bx2-2x8"
  resource_group   = var.resource_group
  vpc              = ibm_is_vpc.vpc.id
  primary_network_interface {
    network = ibm_is_virtual_network_interface.example.id
  }
  keys             = [ibm_is_ssh_key.example.id]
  zone             = "eu-es-1"
}