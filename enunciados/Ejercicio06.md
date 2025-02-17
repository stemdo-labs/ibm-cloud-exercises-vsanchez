# Ejercicio 06: Alta Disponibilidad y Servidores Web con Balanceador de Carga en IBM Cloud VPC

En este ejercicio, ampliarás la infraestructura del ejercicio 5 para lograr alta disponibilidad y configurar servidores web en las máquinas virtuales. Aprenderás a distribuir el tráfico mediante un balanceador de carga y a personalizar el acceso a tus instancias.

---

## Objetivo del Ejercicio

1. Crear una **VPC** con dos **subredes** en zonas de disponibilidad distintas.
2. Asignar una **puerta de enlace pública (Public Gateway)** a cada subred.
3. Desplegar dos **instancias de máquina virtual**, una en cada subred, con IPs públicas.
4. Configurar un **balanceador de carga** para distribuir tráfico HTTP.
5. Instalar y personalizar un **servidor web (Nginx)** en cada máquina virtual.
6. Verificar el acceso a las páginas web mediante el balanceador de carga.

---

## Instrucciones

### **1. Despliegue de la Infraestructura (Guía Paso a Paso)**

#### **A. VPC y Subredes**
   - **Reutiliza el código de la VPC del ejercicio 5**, pero **modifícalo** para crear **dos subredes**:
     - Cada subred debe estar en una **zona de disponibilidad diferente** (ej: `eu-es-1` y `eu-es-2`).
     - Asegúrate de que cada subred tenga un **rango de IP único** (ej: `10.10.1.0/24` y `10.10.2.0/24`).
> [!TIP]
> Puedes usar `total_ipv4_address_count = 256`


#### **B. Puertas de Enlace Públicas**
   - Crea **dos puertas de enlace públicas**, una por cada subred.
   - **Asígnalas** a las subredes correspondientes (esto se hace con otro recurso).
   - Ten cuidado con las zonas.

#### **C. Máquinas Virtuales (VMs)**
   - **Reutiliza el código del ejercicio 5** para crear dos instancias:
     - Cada VM debe estar en una subred distinta.
     - Usa la misma **clave SSH** y **grupo de seguridad** (recuerda que el grupo debe permitir tráfico en los puertos **22 (SSH)** y **80 (HTTP)** y el tráfico saliente).
     - Asocia una **IP pública flotante** a cada VM (igual que en el ejercicio 5).

#### **D. Balanceador de Carga**
   - **Crea un balanceador de carga público** en la VPC:
     - Configura un **grupo de backend** con las **IPs privadas** de ambas VMs.
     - Define un **listener** en el puerto **80** (HTTP) para redirigir el tráfico al grupo de backend.
   - **Consejo útil:** Revisa la documentación de Terraform para [IBM Cloud Load Balancer](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) para estructurar correctamente el recurso.

---

### **2. Configuración de los Servidores Web (Guía Orientativa)**

#### **A. Acceso a las Máquinas Virtuales**
   - Usa SSH para conectarte a cada VM usando sus IPs públicas flotantes:
     ```bash
     ssh -i <ruta_clave_privada_ssh> root@<ip_vm1>
     ssh -i <ruta_clave_privada_ssh> root@<ip_vm2>
     ```

#### **B. Instalación de Nginx**
   - **Comprobar internet** haciendo un ping (`ping 8.8.8.8`).
   - **Actualiza los repositorios** de paquetes en cada VM (`sudo apt update`).
   - **Instala Nginx** (`sudo apt install nginx`).
   - **Comprobar el servicio** con `systemctl status nginx` e inicialo si no lo está.

#### **C. Personalización de la Página Web**
   - Crea un archivo HTML simple en cada VM:
     - En la **VM1**, escribe "¡Hola desde Máquina 1!".
     - En la **VM2**, escribe "¡Hola desde Máquina 2!".
   - **Guarda el archivo** en el directorio predeterminado de nginx (`/var/www/html`).
   - **Reinicia nginx** para aplicar los cambios.

---

### **3. Verificación Final**

1. **Prueba el Balanceador de Carga:**
   - Obtén el **hostname del balanceador** desde el portal de IBM Cloud.
   - Usa el navegador web para acceder.
   - **¿Qué ocurre?** Deberías ver alternarse las respuestas de "Máquina 1" y "Máquina 2" al refrescar varias veces.

2. **Verifica la Configuración de las Puertas de Enlace:**
   - Asegúrate en el portal que cada subred tiene asignada su puerta de enlace pública.

> [!TIP]
> Si el balanceador no responde:
> - Revisa que el **grupo de seguridad** permite tráfico HTTP (puerto 80).
> - Comprueba que Nginx está activo en ambas VMs (`systemctl status nginx`).

---

## Entregables

- **Código de Terraform** completo (VPC, subredes, gateways, VMs, balanceador).
- **Documentación** con:
  - Capturas de las VMs, balanceador y puertas de enlace.
  - Salida de los comandos `curl` al balanceador mostrando ambas respuestas.
  - Capturas de las páginas web personalizadas accesibles desde las IPs públicas de las VMs.

---

### **Recursos Clave**

- **[Balanceador de Carga en IBM Cloud](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb)**
- **[Configuración de Nginx en Ubuntu](https://ubuntu.com/tutorials/install-and-configure-nginx#1-overview)** (guía externa para orientación general).

---
