# ugr_cloud_computing [![Build Status](https://travis-ci.org/erseco/ugr_cloud_computing.svg?branch=master)](https://travis-ci.org/erseco/ugr_cloud_computing)

Repositorio de trabajo de la asignatura Cloud Computing del Máster en Ingeniería Informática de la Universidad de Granada [UGR](https://www.ugr.es)


## Provisionamiento con Ansible/Puppet

Se han provisionado máquinas en Amazon Web Services utilizando las herramientas Ansible y Puppet:

 - [Ansible](https://github.com/erseco/ugr_cloud_computing/tree/master/provision/ansible/README.md)
 - [Puppet (Work In Progress)](https://github.com/erseco/ugr_cloud_computing/tree/master/provision/puppet/README.md)


## Provisionamiento con Azure CLI

Se han provisionado máquinas en Microsoft Azure utilizando la herramienta de línea de comandos

- [acopio.sh](https://github.com/erseco/ugr_cloud_computing/tree/master/acopio.sh)


## Orquestación

Se han orquestado dos máquinas en Microsoft Azure utilizando Vagrant

- [Vagrant](https://github.com/erseco/ugr_cloud_computing/tree/master/orquestacion/README.md)
- Despliegue Vagrant:52.191.118.148


## Contenedores

Se han desplegado un contenedor con node.js

- [Docker](https://github.com/erseco/ugr_cloud_computing/tree/master/contenedores/README.md)
- Contenedor: http://34.229.218.229/
- Imagen en Docker Hub: https://hub.docker.com/r/erseco/ugr_cloud_computing/

## Composición

Para poder realizar este hito se ha orquestado una máquina t2.nano (la mas pequeña) en AWS haciendo uso del anterior hito.
Para dicha máquina se ha elegido Ubuntu 16:04 LTS por ser una versión estandarizada con soporte extendido.
Se ha creado una imagen docker en que expone un servicio http con express (node js) que se ha conectado con otro contenedor sirviendo una base de datos mongodb

- [docker-compose](https://github.com/erseco/ugr_cloud_computing/tree/master/composicion/README.md)
- Despliegue Hito6:http://ec2-52-90-23-155.compute-1.amazonaws.com

*NOTA: La documentación está en el directorio `docs` y se puede consultar en esta url: https://erseco.github.io/ugr_cloud_computing/*
