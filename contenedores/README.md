# Contenedores

Para poder realizar este hito se ha orquestado una máquina t2.nano (la mas pequeña) en AWS haciendo uso del anterior hito.
Para dicha máquina se ha elegido Ubuntu 16:04 LTS por ser una versión estandarizada con soporte extendido.
Se ha creado una imagen docker en docker hub que expone un servicio http con express (node js)

Todo se ha orquestado con Vagrant, por lo que ejecutando `vagrant up` nos orquesta la máquina, provisiona docker ce y lanza nuestra imagen docker


## Instalación de docker

Podemos instalar docker en nuestro servidor con el siguiente comando:
```
wget -qO- https://get.docker.com/ | sh
```


## Descarga y ejecución de nuestra imagen
```
sudo docker run -p 80:80 -d erseco/ugr_cloud_computing
```
