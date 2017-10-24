# ugr_cloud_computing

## Descripción del problema

El servicio de comedores de la Universidad de Granada publica su menú semanal en la página http://scu.ugr.es, dicha página es una actualización de un servicio anterior que estaba ubicado en otra url.
Tras esta actualización todas las aplicaciones que actualmente existen para diferentes dispositivos móviles han dejado de funcionar.
Además dicha página no tiene un diseño que se pueda usar de manera cómoda en dispostivos móviles.
Las

## Solución propuesta

La idea es desarrollar un software que permita de forma fácil consultar el menú diario del comedor de la UGR.

## Introducción descriptiva del proyecto

El proyecto consistirá en varios componentes interconectados que:

- Recopilarán la información de los comedores (*scrapping*)
- Almacenarán los datos en una base de datos `NOSQL`
- Expondrá una `API REST` pública
- Bot Telegram que hará uso de la API
- Servicio `HTTP` que hará uso de la API

## Arquitectura

Se utilizará una arquitectura basada en microservicios.

- Se usará la API para bots de Telegram.
- El desarrollo del *scrapper* se realizará en `Python` usando la librería [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/).
- La API REST se realizará en Ruby
- El Bot Telegram estará hecho en `nodejs`
- El servicio HTTP lo proporcionará `Apache` con `PHP`

## Licencia

Este proyecto será liberado bajo la licencia [GNU GLP V3](https://github.com/erseco/ugr_cloud_computing/blob/master/LICENSE)