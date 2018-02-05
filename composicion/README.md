# Composicion

Para poder realizar este hito se ha orquestado una máquina t2.nano (la mas pequeña) en AWS haciendo uso del anterior hito.
Para dicha máquina se ha elegido Ubuntu 16:04 LTS por ser una versión estandarizada con soporte extendido.
Se ha creado una imagen docker en que expone un servicio http con express (node js) que se ha conectado con otro contenedor sirviendo una base de datos mongodb

## Instalación de docker-compose

Instalamos docker-compose
```
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Instalación de docker

Podemos instalar docker en nuestro servidor con el siguiente comando:
```
wget -qO- https://get.docker.com/ | sh
```


## Descarga y ejecución de nuestra imagen
```
git clone https://github.com/erseco/ugr_cloud_computing.git
cd ugr_cloud_computing
docker-compose up
```
