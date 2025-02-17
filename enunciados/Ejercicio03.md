# Ejercicio 03

## Objetivo

- Parametrizar un módulo raíz básico de Terraform.
- Introducción al uso de bloques "data" en Terraform.

## Pre-requisitos

- Usuario en IBM Cloud.
- Terraform instalado.

## Enunciado

Desarrolla un módulo de terraform que permita desplegar una **Virtual Private Cloud (VPC)** y una **subnet** sobre un Resource Group pre-existente en IBM Cloud. Para esto, crea los ficheros:

- `main.tf`, para los recursos de terraform.
- `variables.tf`, para la definición de las variables de entrada.
- `terraform.tfvars`, para los valores de las variables de entrada.

El módulo debe contener una parametrización adecuada para aceptar el contenido del siguiente fichero `terraform.tfvars` (adapta los valores entre los símbolos `< >`):

_**VPC**_
```hcl
resource_group = "<ID_de_un_rg_ya_existente>"
name = "vpc-<tunombre>-ej01"
```
_**Subnet**_
```hcl
name = "snet-<tunombre>-ej01"
vpc = "ID_de_la_vpc_anterior"
zone = "Zona_de_despliegue"
ipv4_cidr_block = "RangoIP"
```

Despliega el recurso en la nube de IBM utilizando el módulo desarrollado, documentando el proceso en el entregable.

> [!WARNING]
 Al finalizar el ejercicio, ejecuta el comando `terraform destroy` para eliminar todos los recursos creados y poder empezar en el siguiente ejercicio sin conflictos de recursos preexistentes.

## Entregables

> [!CAUTION]
 ¡Cuidado con exponer los valores sensibles! `(terraform.tfstate, terraform.tfvars ...)`

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).