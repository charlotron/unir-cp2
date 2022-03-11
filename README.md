# CP2: Caso práctico 2 del curso de experto universitario devops de unir

## Descripción

Este proyecto tiene varios objetivos:
* Crear una infraestructura en Azure formada por:
  * Grupo de recursos y storage account
  * 5 VMs (1 ansible_controller, 1 master de kubernetes + balanceador de carga externo, 2 workers de kubernetes y 1 nfs), vinculadas a
    * 1 NIC por cada máquina, con su correspondiente IP pública
    * 2 security groups (1 para el nodo master(ssh+puerto 80) y otra para el resto de máquinas(sólo ssh))
    * 1 persistent volume para cada máquina
      

* Configurar desde el ansible_controller de forma automatizada y remota la completa configuración de las vms:
  * Configuración de hostnames, enrutado local, etc..
  * Paquetes auxiliares "helpers"
  * Sincronización de hora
  * Servidores y clientes nfs
  * Kubernetes y sus dependencias (infraestructura)
  * Desplegar la aplicación dentro de kubernetes (pods, servicios, ingress, etc..)

## Recursos en este proyecto por directorios

* **/terraform**: Dispone de los ficheros que permiten la generación de la infraestructura en azure
  * **.env.sample**: Fichero de entorno de ejemplo donde se espera que se rellene la información de "identificación" de terraform en azure
  * **ficheros \*.tf**: Ficheros con información del despliegue de terraform, los que realmente serán ejecutados
  * **ficheros \*.sh**: Scripts shell (bash) que automatizan ciertas tareas en terraform.
  

* **/ansible**: Contiene todos los ficheros que son necesarios para realizar la configuración de las vm y despliegue del servicio de kubernetes
  * **tasks**: Contiene todos los yml que suponen cada uno de los pasos de la configuración y despliegue de las máquinas de forma ordenada
  * **templates**: Contiene las plantillas jinja utilizadas en el despliegue
  * **hosts.sample**: Fichero de inventario de ejemplo que permite tras un rellenado automático un despliegue en las máquinas/ips deseadas
  * **hosts.tftpl**: Plantilla de fichero hosts que utilizará terraform antes de acabar para generar automáticamente un fichero de hosts configurado en base a las vms desplegadas
  * **ficheros \*.sh**: Scripts shell (bash) que automatizan ciertas tareas en ansible.


* **/kubernetes**: Contiene ficheros yml con la información del despliegue de los componentes de kubernetes que se van a configurar

* **/ssh-scripts**: Contiene todos los ficheros que son necesarios para realizar la configuración de las vm y despliegue del servicio de kubernetes
  * **.env.sample**: Contiene un fichero .env.sample que permite la configuración de las variables de entorno si se quiere hacer de forma manual
  * **.env.tftpl**: Este fichero es una plantilla de terraform que permitirá generar el fichero .env en el último paso de terraform de forma automática
  * **ficheros \*.sh**: Scripts shell (bash) que ayudan a la conexión con las máquinas y copiado de recursos

## Pre-requisitos

* Cuenta disponible en la plataforma "azure" con subscripción activa
* Una máquina donde descargar este proyecto y ejecutar los scripts (terraform, bash, etc..). <Se ha hecho en un MacOs, pero debería de funcionar en linux)

### ¿Cómo desplegar la infraestructura?

La información del proceso de despliegue se puede ver en las siguientes secciones
1. [doc/1.PASOS_PREVIOS.md - Pasos previos](doc/1.PASOS_PREVIOS.md): Instalación de clientes de azure, terraform y obtención de service principal
2. [doc/2.TERRAFORM_AZURE.md - Generación infra en azure](doc/2.TERRAFORM_AZURE.md): Creación de la infraestructura de azure necesaria para posterior despliegue con ansible
2. [doc/2.DESPL_ANSIBLE.md - Despliegue con ansible](doc/3.DESPL_ANSIBLE.md): Configuración de VMs con ansible, configuración de kubernetes, despliegue de kubernetes y despliegue de nfs y nginx (balanceador de carga)

### Créditos

Mucha de la información obtenida aquí ha sido impartida por la Universidad UNIR y el profesor de la asignatura del caso práctico 2, su repositorio original que ha sido inspiración para la práctica es:
https://github.com/jadebustos/devopslabs/