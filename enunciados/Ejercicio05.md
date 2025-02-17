# Ejercicio 05: Desplegar una Instancia de Máquina Virtual usando IBM Schematics

En este ejercicio, aprenderás a crear una **instancia de máquina virtual** dentro de la **VPC** previamente creada en el ejercicio anterior, asociando una **IP pública** y una **clave SSH** para poder acceder a la máquina.

---

## Objetivo del Ejercicio

1. Utilizar IBM Schematics para desplegar una **máquina virtual (VM)** dentro de una **VPC**.
2. Asociar una **IP pública** a la instancia.
3. Crear y asociar una **clave SSH** para la conectividad.
4. Verificar que la máquina virtual esté accesible mediante SSH.

---

## Instrucciones



### **1. Despliega los siguientes recursos mediante Schematics**

Aprovechando los recursos creados en el ejercicio anterior **_(VPC, subred y grupo de seguridad)_**, sigue estos pasos para crear la máquina virtual:

1. **Instancia de máquina virtual (VM):** Despliega una instancia de máquina virtual en la subred creada en la VPC. Esta máquina puede ser Linux (por ejemplo, Ubuntu o CentOS). 
**_[Enlace a la documentación del recurso de máquina virtual](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance)_**
2. **Asociación de IP pública:** Asegúrate de asociar una IP pública a la VM para poder acceder a ella desde Internet. 
**_[Enlace a la documentación del recurso de IP Pública](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_floating_ip)_**
3. **Clave SSH:** **Genera una clave SSH en tu máquina local** y añádela a la configuración para poder conectarte a la instancia de forma segura.
**_[Enlace a la documentación del recurso de clave SSH](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_ssh_key)_**
> [!NOTE]
En este enlace está disponible la documentación sobre todos los recursos que se pueden crear en IBM Cloud mediante Terraform. 
**_[Enlace a la documentación](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)_**

### **3. Verificación**

1. Accede al portal web de IBM Cloud y verifica que la máquina virtual se haya creado correctamente dentro de la VPC y esté asociada a la IP pública.
2. Utiliza la clave SSH generada para acceder a la máquina virtual desde tu terminal:

   ```bash
   ssh -i <ruta_a_tu_clave_ssh_generada> <usuario>@<IP_publica>
   ```
3. Comprueba que puedes acceder a la máquina

> [!CAUTION]
Ten en cuenta siempre el coste de los recursos , e intenta usar solo lo que necesites, por ejemplo, el `'profile'` de la instancia de máquina virtual puede ser de varios tipos, algunos más costosos y otros menos, usa el que mejor se adapte a lo que necesites en cada momento.


## Entregables

- Documentación del proceso (con capturas de pantalla).
- Código de Terraform utilizado (como un directorio propio dentro del entregable).