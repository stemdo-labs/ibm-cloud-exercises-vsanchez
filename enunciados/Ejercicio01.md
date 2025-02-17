# Ejercicio 01

En este ejercicio, aprenderás a crear una **VPC (Virtual Private Cloud)** y una **subred** asociada utilizando el portal web de IBM. Sigue las instrucciones paso a paso.

---

## Objetivo del Ejercicio
1. Acceder al portal web de IBM Cloud.
2. Crear una nueva **VPC**.
3. Configurar y asignar una **subred** dentro de la **VPC** creada.

---

## Instrucciones

### **1. Acceder al Portal de IBM Cloud**
1. Abre tu navegador web e inicia sesión [IBM Cloud](https://cloud.ibm.com/).
2. Inicia sesión con tus credenciales de IBM Cloud.

---

### **2. Crear una VPC**
1. Busca y selecciona **Virtual Private Cloud (VPC)**.
2. Haz clic en el botón **Crear** para comenzar con la configuración de la VPC.
3. Proporciona los siguientes detalles:
   - **Nombre de la VPC**: Asigna un nombre descriptivo (por ejemplo, `vpc-<tunombre>-ej01`).
   - **Región**: Selecciona la región donde deseas crear la VPC.
   - **Etiquetas**: Añade las etiquetas que creas necesarias.
4. Haz clic en **Crear** para finalizar la creación de la VPC.

> [!NOTE]
De momento , no es necesario que habilites SSH o ping. 


---

### **3. Crear una Subred dentro de la VPC**
1. Busca la subred y entra en su página de configuración.
2. En la sección **Subredes**, haz click en  **Crear una subred**.
3. Configura los siguientes detalles:
   - **Nombre de la subred**: Proporciona un nombre para la subred (por ejemplo, `snet-<tunombre>-ej01`).
   - **Zona**: Selecciona una zona disponible dentro de la región de la VPC.
4. Selecciona un rango de direcciones IP entre los disponibles.
5. Verifica las configuraciones y haz clic en **Crear** para agregar la subred a tu VPC.
---

### **4. Verificación**
1. Navega a la página principal de la VPC.
2. Asegúrate de que la subred aparece en la lista de subredes.
3. Comprueba que el rango de direcciones IP configurado y la zona sean correctos.
---
