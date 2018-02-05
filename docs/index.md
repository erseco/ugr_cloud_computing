# ugr_cloud_computing

## Descripción del problema

Se necesita un servicio para localizar y comprar productos farmaceuticos, así como un gestor de contenidos para que los vendedores puedan gestionar los pedidos

## Solución propuesta

La idea es desarrollar un software que permita de forma fácil consultar una lista de productos.

## Introducción descriptiva del proyecto

El proyecto consistirá en varios componentes interconectados que:

- Almacenarán los datos en una base de datos `NOSQL`
- Expondrá una `API REST` pública
- Servicio `HTTP` que hará uso de la API


## Arquitectura


Se utilizará una arquitectura basada en microservicios.

- Para la API se usara el modulo express de nodejs
- Los datos se almacenarán en `mongodb`.
- El servicio HTTP lo proporcionará  una web realizada integramente en html+javascript.

## Provisionamiento

Para el provisionamiento se crearán máquinas en Amazon Web Service, se ha realizado el mismo con dos herramientas:

 - [Ansible](https://github.com/erseco/ugr_cloud_computing/tree/master/provision/ansible/README.md)

## Licencia

Este proyecto será liberado bajo la licencia [GNU GLP V3](https://github.com/erseco/ugr_cloud_computing/blob/master/LICENSE)
