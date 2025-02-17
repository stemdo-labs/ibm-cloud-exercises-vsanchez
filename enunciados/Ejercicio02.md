# Ejercicio 02: Crear una VPC y una Subred usando comandos de la CLI de IBM Cloud

En este ejercicio, aprenderás a crear una **VPC (Virtual Private Cloud)** y una **subred** asociada utilizando comandos desde el IBM Cloud CLI.

---

## Objetivo del Ejercicio
1. Utilizar el IBM Cloud CLI para interactuar con la plataforma.
2. Crear una nueva **VPC** desde la línea de comandos.
3. Configurar y asignar una **subred** dentro de la **VPC** creada.

---

## Instrucciones

### **1. Configurar tu entorno**

> [!IMPORTANT] 
Sigue las instrucciones sobre la instalación detallada de la IBM CLI desde [este archivo](../auxiliar/IBM_CLI.md)

> [!TIP]
El plugin que gestiona la infraestructura en IBM Cloud es `is` (infrastructure-service).
Ejecuta el comando `ibmcloud is` después de instalarlo para ver su uso.

---

### **2. Crear una VPC**
1. Busca cómo crear una VPC con el IBM Cloud CLI.
2. Asegúrate de dar un nombre descriptivo a la VPC que estás creando, por ejemplo `vpc-<tunombre>-ej02`.
3. Especifica la región y el grupo de recursos (Stemdo_Sandbox) en la que deseas crear la VPC.
4. Verifica que la VPC haya sido creada correctamente.

---

### **3. Crear una Subred**
1. Investiga como crear una subred dentro de la VPC mediante comandos de IBM Cloud CLI.
2. Crea una subred dentro de la VPC, especificando el ID de la VPC creada anteriormente y del grupo de recursos. 
 Además , aseguráte de elegir un rango de direcciones que esté dentro de una de las zonas de la VPC
3. Verifica que la subred haya sido creada correctamente.

---

### **4. Verificación**
1. Lista las VPC creadas y asegúrate de que la tuya esté configurada.
2. Verifica las subredes asociadas a tu subred.

---

