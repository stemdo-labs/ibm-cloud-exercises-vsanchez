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

resource "ibm_is_subnet" "subnet1" {
    name = "snet-valentino-ej06-1"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-1"
    ipv4_cidr_block = "10.251.20.0/24"
    resource_group = var.resource_group
  
}
resource "ibm_is_subnet" "subnet2" {
    name = "snet-valentino-ej06-2"
    vpc = ibm_is_vpc.vpc.id
    zone = "eu-es-2"
    ipv4_cidr_block = "10.251.70.0/24"
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

resource "ibm_is_security_group_rule" "http" {
  group = ibm_is_security_group.security_group.id
  direction      = "inbound"
  remote         = "0.0.0.0/0" 
  ip_version     = "ipv4"
  tcp {
    port_min = 80
    port_max = 80
  }

} 

resource "ibm_is_ssh_key" "ssh_key" {
  name       = "ssh-key-valentino-ej06"
  public_key = var.public_key
  resource_group = var.resource_group
}


resource "ibm_is_instance" "vm_valentino_ej06_1" {
  name              = "vm-valentino-ej06-1"
  vpc               = ibm_is_vpc.vpc.id
  profile           = "bx2-2x8"
  zone              = "eu-es-1"
  keys = [ibm_is_ssh_key.ssh_key.id]  
  image             = "r050-b98611da-e7d8-44db-8c42-2795071eec24"
  resource_group = var.resource_group
 
  primary_network_interface {
    subnet          = ibm_is_subnet.subnet1.id
    security_groups = [ibm_is_security_group.security_group.id]
 
  }
}

resource "ibm_is_instance" "vm_valentino_ej06_2" {
  name              = "vm-valentino-ej06-2"
  vpc               = ibm_is_vpc.vpc.id
  profile           = "bx2-2x8"
  zone              = "eu-es-2"
  keys = [ibm_is_ssh_key.ssh_key.id]  
  image             = "r050-b98611da-e7d8-44db-8c42-2795071eec24"
  resource_group = var.resource_group
 
  primary_network_interface {
    subnet          = ibm_is_subnet.subnet2.id
    security_groups = [ibm_is_security_group.security_group.id]
 
  }
}


resource "ibm_is_floating_ip" "ip_public_valentino_ej06_1" {
  name   = "ip-public-valentino-ej06-1"
  target = ibm_is_instance.vm_valentino_ej06_1.primary_network_interface.0.id
  resource_group = var.resource_group
}

resource "ibm_is_floating_ip" "ip_public_valentino_ej06_2" {
  name   = "ip-public-valentino-ej06-2"
  target = ibm_is_instance.vm_valentino_ej06_2.primary_network_interface.0.id
  resource_group = var.resource_group
}

resource "ibm_is_lb" "load_balancer" {
  resource_group = var.resource_group
  name    = "load-balancer"
  subnets = [ibm_is_subnet.subnet1.id, ibm_is_subnet.subnet2.id]
}