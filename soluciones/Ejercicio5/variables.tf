variable "ibmcloud_api_key" {
  description = "API Key de IBM Cloud"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Región de IBM Cloud"
  type        = string
}

variable "zone" {
  description = "Zona de disponibilidad"
  type        = string
  
}

variable "resource_group" {
  description = "Grupo de recursos de IBM Cloud"
  type        = string
  sensitive = true
}

variable "public_key" {
  description = "Clave pública para la instancia"
  type        = string
  sensitive = true
  
}



