# GRUPO 11
DIEGO ALONSO VILLAJULCA QUISPE
MAURICIO TERRONES ALAYO
LUIS BENJAMIN REYES
JHON MAXIMILIANO VILLANUEVA
MARVIN RIOS TAMAYO
# Infraestructura Docker Contenerizada con Terraform

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)

Este proyecto utiliza **Terraform** para automatizar el aprovisionamiento de una arquitectura de servicios distribuidos, desplegados como contenedores de **Docker**. La configuración define una infraestructura multi-red que segmenta los servicios por su funcionalidad: aplicaciones, persistencia de datos y monitoreo.

##  Arquitectura

El siguiente diagrama ilustra la arquitectura final que se despliega con este proyecto.

![Diagrama de Arquitectura](./assets/architecture.png)
*(Nota: Asegúrate de tener tu imagen del diagrama en una carpeta `assets` para que este enlace funcione)*

---

## 📋 Prerrequisitos

Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas en tu sistema:

1.  **Terraform (v1.0.0 o superior):** Para gestionar la infraestructura como código.
    * [Descargar Terraform](https://www.terraform.io/downloads.html)
2.  **Docker Desktop:** Para ejecutar los contenedores.
    * [Descargar Docker](https://www.docker.com/products/docker-desktop)

> **IMPORTANTE:** Asegúrate de que **Docker Desktop esté en ejecución** antes de ejecutar los comandos de Terraform.

---

## ⚙️ Configuración

Toda la configuración específica del entorno (como contraseñas o puertos) se gestiona a través de un archivo de variables.

1.  **Crear el archivo de variables:**
    Este repositorio incluye un archivo de ejemplo llamado `terraform.tfvars.example`. Para empezar, renómbralo o crea una copia llamada `terraform.tfvars`.

    ```bash
    # En tu terminal, ejecuta este comando para copiar el archivo de ejemplo
    cp terraform.tfvars.example terraform.tfvars
    ```

2.  **Editar las variables:**
    Abre el archivo `terraform.tfvars` y modifica los valores según tus necesidades. Especialmente, asegúrate de establecer una contraseña segura para la base de datos.

    ```hcl
    # terraform.tfvars

    # Puertos para las aplicaciones Nginx
    # Formato: <nombre_workspace> = <puerto>
    nginx_app1_external_port = {
      dev  = 8081
      qa   = 9081
      prod = 80
    }
    # ... (otras variables de nginx)

    # Variables para la capa de persistencia
    postgres_external_port = {
      dev  = 5433 # Se usa 5433 para evitar conflictos con instalaciones locales de Postgres
      qa   = 5434
      prod = 5432
    }
    postgres_password = "tu_contraseña_super_secreta"

    redis_external_port = {
      dev  = 6379
      qa   = 6380
      prod = 6379
    }

    # Variables para la capa de monitoreo
    grafana_external_port = {
      dev  = 3000
      qa   = 3001
      prod = 3000
    }
    ```

---

## 🚀 Despliegue de la Infraestructura

Sigue estos pasos en orden para levantar toda la infraestructura.

### Paso 1: Inicializar Terraform

Este comando prepara tu directorio de trabajo, descargando los proveedores necesarios (en este caso, el proveedor de Docker).

```bash
Paso 2: Crear un Workspace
Los workspaces permiten gestionar múltiples entornos (desarrollo, QA, producción) de forma aislada. Crearemos un workspace dev для nuestro primer despliegue.

Bash

# Crea y cambia al nuevo espacio de trabajo 'dev'
terraform workspace new dev
Si ya existe, puedes cambiar a él con terraform workspace select dev.

Paso 3: Planificar los Cambios
Este comando crea un plan de ejecución. Es un "ensayo" que te muestra exactamente qué recursos se van a crear, modificar o destruir. Es una buena práctica revisar siempre el plan antes de aplicarlo.

Bash

# Muestra los cambios que se realizarán
terraform plan
Paso 4: Aplicar la configuración
Este comando ejecuta el plan y construye la infraestructura. Todos los contenedores y redes serán creados y configurados.

Bash

# Aplica la configuración y construye la infraestructura
# La bandera -auto-approve salta la confirmación manual
terraform apply -auto-approve
✅ Verificación
Una vez que el comando apply termine, puedes verificar que todos los contenedores estén corriendo correctamente.

Abre una terminal y ejecuta:

Bash

# Lista todos los contenedores de Docker en ejecución
docker ps
Deberías ver una lista con todos tus contenedores (nginx, postgres, redis, grafana) en estado "Up". Ahora puedes acceder a los servicios a través de los puertos que definiste en tu archivo terraform.tfvars. Por ejemplo, para el entorno dev:

Aplicación 1 (Nginx): http://localhost:8081

Grafana: http://localhost:3000

Postgres: Conéctate con un cliente de base de datos a localhost:5433

🧹 Limpieza (Destruir la Infraestructura)
Si deseas eliminar todos los recursos creados por Terraform, puedes usar el comando destroy.

ADVERTENCIA: Esta acción es irreversible y eliminará todos los contenedores y redes gestionados por este proyecto en el workspace activo.

Bash

# Destruye todos los recursos del workspace 'dev'
terraform destroy -auto-approve
📂 Estructura de Archivos
main.tf: Define el proveedor de Docker y la versión requerida de Terraform.

network.tf: Contiene las definiciones de las tres redes de Docker (app_net, persistence_net, monitor_net).

persistence.tf: Define los contenedores de la capa de datos (postgres, redis).

nginx.tf: Define los contenedores de las aplicaciones (app1, app2, app3).

grafana.tf: Define el contenedor de monitoreo (grafana).

variables.tf: Declara todas las variables que el proyecto utiliza.

terraform.tfvars: (Creado por el usuario) Contiene los valores asignados a las variables para un despliegue específico.