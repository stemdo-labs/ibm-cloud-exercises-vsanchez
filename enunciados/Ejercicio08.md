# Ejercicio 08: Monitorización

## Objetivo

- Reutilizar la infraestructura del **Ejercicio 05** (VPC, subred, MV).
- Asegurar que la máquina virtual (MV) tiene acceso a internet configurado desde Terraform, añadiendo una IP pública y una Public Gateway.
- Incorporar **IBM Cloud Monitoring (Sysdig)** para monitorizar el desempeño de contenedores y VMs.
- Configurar alertas y paneles de control para métricas críticas (CPU, memoria, red, logs).

---

## Pasos del Ejercicio

### 1. Reutilización de la Infraestructura del Ejercicio 05

#### Recursos a Reutilizar:

- **VPC**: La red virtual privada configurada previamente.
- **Subred**: La subred dentro de la VPC.
- **Máquina Virtual (MV)**: La instancia de VM desplegada en la subred.

#### Configuración Adicional:

Para garantizar que la MV tenga acceso a internet, es necesario configurar una puerta de enlace pública y asociarla a la subred correspondiente. Esto se debe realizar mediante Terraform, añadiendo los siguientes recursos:

```hcl
# Puerta de enlace pública
resource "ibm_is_public_gateway" "pgw" {
  name           = "pgw-zona1"
  vpc            = ibm_is_vpc.vpc_module_rgonzalez.id
  resource_group = var.resource_group
  zone           = "eu-es-1"
}

# Asociación de la puerta de enlace a la subred
resource "ibm_is_subnet_public_gateway_attachment" "pg_attach1" {
  subnet         = ibm_is_subnet.subnet_module_rgonzalez.id
  public_gateway = ibm_is_public_gateway.pgw.id
}

# Regla de seguridad para tráfico saliente
resource "ibm_is_security_group_rule" "outbound_all" {
  group     = ibm_is_security_group.ssh_rgonzalez_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
```

> **Nota**: Esta configuración debería estar incluida en la respuesta del ejercicio anterior. Si no es así, asegúrese de implementarla para proporcionar acceso a internet a la MV.

---

### 2. Incorporación del Servicio de Monitorización

#### A. Creación del Servicio IBM Cloud Monitoring

Solo un miembro del equipo debe crear una instancia del servicio IBM Cloud Monitoring, ya que todos utilizarán el mismo servicio. Aunque se proporciona un ejemplo de cómo hacerlo con Terraform, se recomienda realizar esta configuración directamente desde el portal de IBM Cloud para evitar que cada miembro cree instancias redundantes.

Ejemplo de creación con Terraform:

```hcl
resource "ibm_resource_instance" "monitoring" {
  name     = "monitoring-name"
  service  = "sysdig-monitor"
  plan     = "lite"
  location = var.region
}
```

> **Nota**: Este ejemplo es solo para referencia. No es necesario que cada miembro lo implemente en su configuración de Terraform.

---

#### B. Instalación del Agente de Monitorización en las VMs

Cada miembro debe instalar el agente de monitorización en su MV siguiendo estos pasos:

1. **Acceder al Servicio de IBM Cloud Monitoring**: Navegue al recurso de IBM Cloud Monitoring creado previamente.

2. **Obtener la Clave de Acceso**:
   - Haga clic en "Acciones" y seleccione "Gestionar Clave".
   - Cree una nueva clave si es necesario y cópiela para su uso posterior.

3. **Instalar el Agente en la MV**:
   - En el recurso de IBM Cloud Monitoring, vaya a "Supervisión de Orígenes".
   - Seleccione "Linux" y copie el script proporcionado en "Punto final privado".
   - Ejecute el script en su MV para instalar y configurar el agente.

> [!WARNING]
> Asegúrese de que su MV tiene acceso a internet para descargar e instalar el agente correctamente.

---

### 3. Configuración de Alertas y Dashboards

#### A. Crear un Dashboard

1. **Acceder al Panel de Control**: Inicie sesión en la interfaz web de IBM Cloud Monitoring.

2. **Crear un Nuevo Dashboard**:
   - Navegue a la sección de dashboards y cree uno nuevo.
   - Añada dos paneles con las siguientes métricas:
     - **Uso de CPU (%)**: Monitorea el porcentaje de uso de la CPU de la MV.
     - **Tráfico Saliente (Bytes)**: Monitorea la cantidad de datos salientes de la MV en bytes.


#### B. Definir Alertas y Configurar Notificaciones en Teams

1. **Crear Alertas**:
   - Desde el dashboard o la sección de alertas, cree nuevas alertas para las métricas críticas.
   - Por ejemplo, configure una alerta que se active si el uso de CPU supera un umbral específico durante un período determinado.

2. **Configurar Notificaciones en Microsoft Teams**:
   - En la configuración de la alerta, añada un canal de notificación.
   - Seleccione Microsoft Teams como el canal y proporcione la información necesaria para integrar las alertas con su equipo de Teams.

---

### 4. Validación Final

#### Prueba de Alertas

Para verificar que las alertas están configuradas correctamente:

1. **Simular Alta Carga de CPU**:
   - Conéctese a su MV.
   - Ejecute el siguiente comando para generar carga en la CPU durante 5 minutos:
     ```bash
     stress-ng --cpu 4 --timeout 300s
     ```
   - Este comando utilizará 4 núcleos de CPU al 100% durante 300 segundos.

2. **Verificar Notificaciones**:
   - Monitoree el dashboard en IBM Cloud Monitoring para observar el aumento en el uso de CPU.
   - Verifique que se haya activado la alerta y que haya recibido una notificación en Microsoft Teams.

3. **Detener la carga de la CPU**
   - Detén el comando ejecutado (CTRL+c) y verifica en el Dashboard que el uso de CPU vuelve a valores normales 

---

## Entregables

### 1. Código Terraform

- Archivos de configuración para:
  - Infraestructura (VPC, subred, MV, puerta de enlace pública, etc.).
  - Configuración de seguridad y acceso a internet.

### 2. Documentación y Capturas de Pantalla

- **Dashboards**:
  - Captura del dashboard con las métricas en tiempo real.
- **Alertas**:
  - Evidencia de las alertas configuradas y las notificaciones recibidas en Microsoft Teams.

> **Nota**: Asegúrese de que toda la documentación esté clara y que las capturas de pantalla sean legibles y relevantes.

---
 
