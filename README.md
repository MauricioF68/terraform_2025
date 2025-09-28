Laboratorio 04: Infraestructura Automatizada con Terraform y Ansible
Integrantes del Grupo 11

DIEGO ALONSO VILLAJULCA QUISPE

MAURICIO TERRONES ALAYO

LUIS BENJAMIN REYES

JHON MAXIMILIANO VILLANUEVA

OLAZABAL AVILA FERNANDO DAVID

 Introducción
Este proyecto despliega una arquitectura de microservicios contenerizada utilizando herramientas de Infraestructura como Código (IaC) y Gestión de Configuración.



 Arquitectura Final
El siguiente diagrama ilustra la arquitectura final que se despliega, la cual incluye una capa de proxy para el balanceo de carga, múltiples aplicaciones de backend, servicios de persistencia y monitoreo.

<img width="481" height="432" alt="image" src="https://github.com/user-attachments/assets/3cbfcc98-cede-4033-8277-902a509b2d58" />

Parte 1: Preparación del Entorno (Instalación Única)
Antes de desplegar el proyecto, es necesario instalar y configurar las siguientes herramientas en tu máquina con Windows.

1.1 Instalar WSL (Subsistema de Windows para Linux)
Ansible requiere un entorno Linux. WSL nos permite ejecutar una terminal de Ubuntu directamente en Windows.

Abre PowerShell como Administrador (Menú Inicio > Escribe "PowerShell" > Clic derecho > Ejecutar como administrador).

Ejecuta el siguiente comando para instalar WSL y la distribución Ubuntu:

PowerShell

wsl --install

Reinicia tu computadora cuando te lo pida.

Al finalizar, abre la nueva aplicación "Ubuntu" desde el Menú Inicio. La primera vez, se tomará un momento para configurarse y luego te pedirá que crees un nombre de usuario y una contraseña para tu nuevo entorno de Linux.

1.2 Instalar Docker Desktop y Configurar la Integración con WSL
Docker es la plataforma que ejecutará nuestros contenedores.

Descarga e instala Docker Desktop desde su sitio web oficial.

Una vez instalado, abre Docker Desktop. Ve a Settings (Configuración) ⚙️ > Resources (Recursos) > WSL Integration.

Asegúrate de que el interruptor para Ubuntu esté activado.

Haz clic en el botón Apply & Restart.


Paso 1: Descargar y Preparar Terraform 📥
Ve a la página de descargas oficial:
https://developer.hashicorp.com/terraform/downloads
Descarga la versión correcta:
Busca la sección de Windows.
Haz clic en el botón de descarga para la versión AMD64. Se descargará un archivo .zip.
Crea una "Casa" para Terraform:
Ve a tu disco C: en el Explorador de Archivos.
Crea una nueva carpeta y nómbrala Terraform. La ruta final será C:\Terraform.
Descomprime el archivo .zip que descargaste. Dentro solo habrá un archivo: terraform.exe.
Mueve el archivo terraform.exe a la carpeta que acabas de crear (C:\Terraform).
 Paso 2: Añadir Terraform  ( PATH)
Ahora le diremos a Windows dónde encontrar a Terraform.
Abre la configuración del sistema:
Presiona la tecla de Windows, escribe variables de entorno y selecciona la opción que dice "Editar las variables de entorno del sistema".
Accede a las Variables de Entorno:
En la ventana de "Propiedades del sistema" que se abre, haz clic en el botón de abajo a la derecha que dice "Variables de entorno...".
Selecciona la Variable Path:
En la nueva ventana, verás dos secciones. En la sección de abajo, llamada "Variables del sistema", busca y selecciona la variable llamada Path.
Luego, haz clic en el botón "Editar...".
Añade la Nueva Ruta:
Se abrirá la ventana "Editar la variable de entorno".
Haz clic en el botón "Nuevo" a la derecha. Se creará una nueva línea vacía al final de la lista.
En esa nueva línea, escribe la ruta exacta de la carpeta que creaste en el paso anterior: C:\Terraform.
Guarda los Cambios:
Haz clic en "Aceptar" en todas las ventanas que abriste (la de "Editar", la de "Variables de entorno" y la de "Propiedades del sistema") para guardar y cerrar todo.

 Paso 3: ¡Verifica que Funciona! 
Para confirmar que Windows ya sabe dónde está Terraform:

Abre una NUEVA terminal de PowerShell o Símbolo del sistema. (Es importante que sea nueva para que cargue la agenda actualizada).

Escribe el siguiente comando y presiona Enter:

Bash
terraform --version
Si todo salió bien, verás un mensaje que te muestra la versión de Terraform que instalaste.

Visual Studio Code: Descárgalo desde su sitio web oficial.

1.4 Instalar la Extensión de VS Code
Abre VS Code, ve al panel de Extensiones (Ctrl+Shift+X) y busca e instala la extensión oficial de Microsoft: Remote - WSL.

1.5 Instalar Ansible (Dentro de WSL)
Finalmente, instala Ansible dentro de tu entorno de Linux.

Abre tu terminal de Ubuntu/WSL.

Ejecuta los siguientes comandos:

Bash
sudo apt-get update
sudo apt-get install ansible -y
¡Felicidades, tu entorno de desarrollo está completamente configurado!

🚀 Parte 2: Despliegue del Proyecto
Sigue estos pasos para clonar el repositorio y levantar toda la infraestructura.

2.1 Descargar el Proyecto
Primero tienes que crear una carpeta ahi es donde vas a clorar el repositorio.
luego abre tuerminal de Ubuntu/WSL y ejecuta el siguiente comando para poder ingresar a tu carpeta que creaste y hacer que se abra en el visual estudio code. 
navega con "cd carpetas" carpetas (sera el nombre de tu carpera que creaste) y una ves que estes dentro de tu carpeta escribe este comando.

code . 
Despues dentro del visual estudio code , abre tu terminar 
puedes usar control + ñ o en el menu de arriba buscar el terminal 
leugo dentro del terminal vas a poner el siguiente comando
Bash

git clone -b feature/base-proyecto https://github.com/MauricioF68/terraform_2025.git
2.2 Abrir el Proyecto en VS Code (Modo WSL)
Navega a la carpeta del proyecto recién clonado:

Bash

cd terraform_2025


2.3 Construir la Infraestructura con Terraform
En la terminal integrada de VS Code, navega a la carpeta de Terraform:

Bash

cd terraform
Inicializa Terraform para descargar los proveedores necesarios:

Bash

terraform init
Aplica la configuración para crear todos los contenedores y redes. Te pedirá una contraseña para la base de datos ( usar admin123 )

Bash

terraform apply
Escribe yes cuando te pida confirmación para continuar.

2.4 Configurar los Servicios con Ansible
En la misma terminal, navega a la carpeta de Ansible:

Bash

cd ../ansible
Ejecuta el playbook de Ansible para copiar las configuraciones y reiniciar el proxy:

Bash

ansible-playbook -i inventory.ini playbook.yaml
Al finalizar, toda la arquitectura estará desplegada y configurada.

✅ Parte 3: Verificación y Pruebas
3.1 Comprobar los Contenedores
Ejecuta docker ps en tu terminal para ver todos los contenedores del proyecto en estado Up.

3.2 Probar el Proxy y el Balanceo de Carga
Probar el Frontend: Abre tu navegador web y visita http://localhost:50010/web/. Deberías ver la página estática del proyecto.

Probar el Backend: Ahora, visita http://localhost:50010/api/. Deberías ver la página de bienvenida Aplicacion 1 , sigue ejecutando y veras que cambian Aplicacion 1 , Aplicacion 2 Aplicacion 3

Visualizar el Balanceo de Carga: Para ver el proxy en acción, puedes personalizar el mensaje de cada app y ver cómo cambia en el navegador al refrescar la página.

Entra al primer contenedor de app:

Bash

docker exec -it nginx-app1dev nano /usr/share/nginx/html/index.html
Cambia <h1>Welcome to nginx!</h1> por <h1>Respuesta desde APP 01</h1> y guarda (Ctrl+X, Y, Enter).

Repite el proceso para nginx-app2dev y nginx-app3dev, cambiando el mensaje a "APP 02" y "APP 03".

Ahora, refresca la página http://localhost:50010/api/ varias veces. Verás cómo el mensaje cambia, demostrando que el proxy está distribuyendo el tráfico entre los diferentes contenedores.

🧹 Limpieza (Destruir la Infraestructura)
Para eliminar todos los recursos creados por este proyecto, navega a la carpeta terraform y ejecuta:

Bash

terraform destroy -auto-approve
Advertencia: Esta acción es irreversible y eliminará todos los contenedores y redes gestionados.

NO OLVIDES TENER ACTIVADO EL DOCKER EN TU ESCRITORIO . 
PARA ACTIVARLO , BUSCALO EN TU BARRA DE WINDOWS Y ESCRIBE DOCKER Y DALE CLICK , AL ENTRAR DOCKER SE EMPEZARA ACTIVAR ! 
