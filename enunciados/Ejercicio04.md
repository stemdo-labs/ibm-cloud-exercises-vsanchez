# Ejercicio 04: Crear una VPC y una Subred usando IBM Schematics

En este ejercicio, aprenderás a desplegar una **VPC (Virtual Private Cloud)** y una **subred** asociada utilizando IBM Schematics con un archivo de configuración Terraform.

---

## Objetivo del Ejercicio

1. Utilizar IBM Schematics para gestionar y desplegar infraestructura.
2. Crear una nueva **VPC** y una **subred**, junto a un **grupo de seguridad** y añadirle reglas mediante un archivo de configuración Terraform.
3. Verificar los recursos desplegados.

---

## Instrucciones

### **1. Configurar tu entorno de schematics**

> [!IMPORTANT]
> Sigue las instrucciones sobre la configuración de IBM Schematics desde [este archivo](../auxiliar/IBM_Schematics.md).


### **2. Despliega los siguientes recursos mediante Schematics**

1. Una **_VPC_**. 
2. Una **_subnet_** dentro de esa **_VPC_**. 
3. Un **_grupo de seguridad_** para esa **_subred_** junto con una regla que permita el tráfico entrante para **_SSH_**. 

### **3.Verificación**

Verifica que tus recursos se han creado correctamente comprobándolo desde el portal web de IBM Cloud.

> [!WARNING]
 Al finalizar el ejercicio, ejecuta el comando `terraform destroy` para eliminar todos los recursos creados y poder empezar en el siguiente ejercicio sin conflictos de recursos preexistentes.


## Entregables

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).