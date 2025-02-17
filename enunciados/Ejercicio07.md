# Ejercicio 07: Web Estático con Contenedores y COS en IBM Cloud

En este ejercicio, ampliamos la infraestructura de alta disponibilidad del ejercicio 06 para servir contenido estático desde **IBM Cloud Object Storage** (COS) a través de un **contenedor Docker**, alojado en máquinas virtuales de la misma **VPC** y gestionado en **IBM Cloud Container Registry**. Además, seguiremos utilizando el **balanceador de carga** para distribuir el tráfico y garantizar la disponibilidad.

---

## Objetivo del Ejercicio

1. **Reutilizar la VPC** y las **subredes** en zonas de disponibilidad diferentes del ejercicio 06.  
2. **Crear un Bucket en IBM Cloud Object Storage (COS)** para almacenar contenido estático.  
3. **Construir una imagen Docker** que sirva el contenido estático desde COS y **publicarla** en **IBM Cloud Container Registry**.  
4. **Desplegar contenedores** en las VMs existentes, usando la imagen creada.  
5. **Configurar el balanceador de carga** para redirigir el tráfico al contenedor en ejecución.  
6. **Validar** que el contenido estático se sirva correctamente a través del balanceador.

---

## Instrucciones

### **1. Despliegue de la Infraestructura (Reutilización)**

#### **A. Reutilizar la VPC y Subredes**
- Utiliza la **VPC** del ejercicio 06 con sus **dos subredes** en diferentes zonas de disponibilidad.  
- Asegúrate de que los recursos (VPC, subredes, puertas de enlace públicas, grupo de seguridad) se mantengan tal y como los dejaste.

#### **B. Máquinas Virtuales (VMs) Existentes**
- Mantén las **dos VMs** en cada subred.  
- Recuerda tener configurado el **grupo de seguridad** para permitir tráfico en los puertos **22 (SSH)** y **80 (HTTP)**.  
- Cada VM debe conservar su **IP pública flotante** y **clave SSH**.

#### **C. Balanceador de Carga Existente**
- **Reaprovecha** el **balanceador de carga**.  
- Asegúrate de que el **listener en puerto 80 (HTTP)** siga activo.

---

### **2. Creación y Configuración de IBM Cloud Object Storage**

#### **A. Creación del Bucket**
- **Crea un nuevo bucket** en IBM Cloud Object Storage.
- Configura una **región** o **zona** que coincida (o sea cercana) a tus subredes, para optimizar la latencia.
- Establece los permisos del bucket de forma que puedas **acceder** al contenido estático desde tu contenedor.
> [!TIP]
> Comprueba la [documentación](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket):  
> - Echa un vistazo a los recursos **ibm_resource_instance** e **ibm_cos_bucket**.

#### **B. Carga de Contenido Estático**
- Sube al menos un **archivos HTML**, imágenes u otro contenido estático que desees.  
- Opcionalmente, crea carpetas o subcarpetas para organizar el contenido.

---

### **3. Creación de la Imagen Docker y Publicación en Container Registry**

#### **A. Preparación de la Imagen**
- **Crea un Dockerfile** que incluya un servidor web ligero (ej. **Nginx**).  
- Añade la configuración necesaria para **apuntar** al contenido en COS (por ejemplo, mediante variables de entorno que indiquen el endpoint y el bucket del que se descargará o servirá el contenido).
> [!TIP]
> - Necesitarás un archivo de configuración para nginx que deberá contener una linea similar a esta: `proxy_pass https://$COS_ENDPOINT/$COS_BUCKET/$COS_OBJECT;`.
> - El archivo final que irá en **/etc/nginx/conf.d/** tendrá que tener las variables sustituidas por el valor adecuado.

#### **B. Conexión a IBM Cloud Container Registry**
- Asegúrate de **loguearte** en IBM Cloud Container Registry (usando la CLI de IBM Cloud o la CLI Docker con credenciales).  
- **Construye** la imagen localmente (`docker build`).  
- **Publica** (push) la imagen en tu **Container Registry** con la etiqueta correspondiente (ej. `es.icr.io/<namespace>/<imagen>:<tag>`).

---

### **4. Despliegue del Contenedor en las VMs**

#### **A. Instalación de Docker (o Actualización)**
- En cada VM, verifica o [instala **Docker**](https://docs.docker.com/engine/install/ubuntu/).  

#### **B. Descarga y Ejecución del Contenedor**
- En cada VM, haz **pull** de la imagen desde Container Registry.  
- Ejecuta el contenedor, exponiendo el puerto **80**, por ejemplo:  
  ```bash
  docker run -d -p 80:80 \
    -e COS_ENDPOINT=<endpoint_COS> \
    -e COS_BUCKET=<nombre_bucket> \
    -e COS_OBJECT=<nombre_object
    --name servidor-web \
    <registry>/<namespace>/<imagen>:<tag>
  ```
- Ajusta las variables de entorno según la configuración de tu bucket y endpoint.

---

### **5. Configuración del Balanceador de Carga**

- En el **balanceador de carga**, actualiza o crea el **grupo de backend** apuntando a las IPs privadas de las VMs (puerto 80).  
- Comprueba que ambas VMs aparecen como “**healthy**” en el estado del balanceador.  
- Mantén el **listener** HTTP en el **puerto 80** para redirigir el tráfico al contenedor.

---

### **6. Verificación Final**

1. **Acceso vía Balanceador**  
   - Usa el **hostname** o la **dirección pública** del balanceador en tu navegador.  
   - Verifica que el contenido estático del bucket de COS se muestre correctamente.

2. **Acceso Directo a cada VM**  
   - Conéctate a la IP pública de cada VM para ver si el contenedor está sirviendo la aplicación.

3. **Validación de Logs (Opcional)**  
   - Ejecuta `docker logs servidor-web` en cada VM para comprobar que no haya errores y que las peticiones se estén registrando.

> [!TIP]
> Si no ves el contenido estático:  
> - Verifica que tu contenedor tiene las variables de entorno correctas.  
> - Asegúrate de que el **bucket** y los **objetos** tengan permisos suficientes para ser leídos.  
> - Comprueba la configuración de red en tu Dockerfile (tal vez necesites librerías o SDK para acceder a COS).

---

## Entregables

- **Código de Terraform** (o la parte relevante del despliegue/ajustes).  
- **Dockerfile** y/o repositorio con la configuración para acceder a COS.  
- **Capturas de Pantalla** mostrando:  
  1. El bucket de COS con el contenido estático.  
  2. La imagen en IBM Cloud Container Registry.  
  3. Los contenedores corriendo en cada VM.  
  4. El balanceador de carga y su estado de salud (health checks).  
  5. Acceso exitoso a la aplicación web vía balanceador.
  6. Cualquier otra captura que consideres importante.

- **Pruebas** de la aplicación:  
  - Salida de `curl` o navegador confirmando que se sirve el contenido estático.  
  - Logs (opcional) del contenedor demostrando el tráfico.

---

### **Recursos Clave**

- **[IBM Cloud Object Storage](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket)**
- **[IBM Cloud Container Registry](https://cloud.ibm.com/docs/Registry)**
- **[Docker Documentation](https://docs.docker.com/)**  

¡Con esto habrás creado una solución de alta disponibilidad que integra contenedores, un balanceador de carga y almacenamiento en la nube para contenido estático!
