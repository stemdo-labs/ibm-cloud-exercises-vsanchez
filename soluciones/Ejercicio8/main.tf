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
  name = "vpc-valentino-ej05"
  resource_group = var.resource_group
  
}

resource "ibm_is_subnet" "subnet" {
    name = "snet-valentino-ej05"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-1"
    ipv4_cidr_block = "10.251.20.0/24"
    resource_group = var.resource_group
  
}

resource "ibm_is_security_group" "security_group" {
  name = "sg-valentino-ej05"
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

resource "ibm_is_security_group_rule" "outbound_all" {
  group     = ibm_is_security_group.security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_ssh_key" "ssh_key" {
  name       = "ssh-key-valentino-ej05"
  public_key = var.public_key
  resource_group = var.resource_group
}


resource "ibm_is_instance" "vm_valentino_ej05" {
  name              = "vm-valentino-ej05"
  vpc               = ibm_is_vpc.vpc.id
  profile           = "bx2-2x8"
  zone              = "eu-es-1"
  keys = [ibm_is_ssh_key.ssh_key.id]  
  image             = "r050-b98611da-e7d8-44db-8c42-2795071eec24"
  resource_group = var.resource_group
 
  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_security_group.security_group.id]
 
  }
}

resource "ibm_is_floating_ip" "ip_public_valentino_ej05" {
  name   = "ip-public-valentino-ej05"
  target = ibm_is_instance.vm_valentino_ej05.primary_network_interface.0.id
  resource_group = var.resource_group
}

resource "ibm_is_public_gateway" "pgw" {
  name           = "pgw-zona1"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = var.resource_group
  zone           = "eu-es-1"
}


resource "ibm_is_subnet_public_gateway_attachment" "pg_attach1" {
  subnet         = ibm_is_subnet.subnet.id
  public_gateway = ibm_is_public_gateway.pgw.id
}

resource "ibm_resource_instance" "monitoring" {
  name     = "monitoring-name"
  service  = "sysdig-monitor"
  plan     = "lite"
  location = "eu-es"
}


