# Ejercicios Tema 5

## 1. Instala LXC en tu versión de Linux favorita. Normalmente la versión en desarrollo, disponible tanto en GitHub como en el sitio web está bastante más avanzada; para evitar problemas sobre todo con las herramientas que vamos a ver más adelante, conviene que te instales la última versión y si es posible una igual o mayor a la 2.0.

Aunque mi versión favorita es Debian, hemos usado una instancia de Ubuntu 16.04 LTS en AWS por ser una de las más extendidas

Instalamos `lxc`
```
sudo apt-get update && sudo apt-get -y install lxc
```

Resultado:
```
ubuntu@ip-172-31-35-155:~$ lxc --version
2.0.11
```

## 2. Instalar una distro tal como Alpine y conectarse a ella usando el nombre de usuario y clave que indicará en su creación

El primer paso sera descargar la imagen. Para ello:
```
sudo lxc-create -t alpine -n cc
```

Resultado:
```
Obtaining an exclusive lock... done

==> Fetching and/or verifying APK keys
alpine-devel@lists.alpinelinux.org-4a6a0840.rsa.pub: OK
alpine-devel@lists.alpinelinux.org-4d07755e.rsa.pub: OK
alpine-devel@lists.alpinelinux.org-5243ef4b.rsa.pub: OK
alpine-devel@lists.alpinelinux.org-524d27bb.rsa.pub: OK
alpine-devel@lists.alpinelinux.org-5261cecb.rsa.pub: OK

==> Fetching apk-tools static binary
tar: Ignoring unknown extended header keyword 'APK-TOOLS.checksum.SHA1'
tar: Ignoring unknown extended header keyword 'APK-TOOLS.checksum.SHA1'
Verified OK
apk-tools 2.8.2, compiled for x86_64.
Obtaining an exclusive lock... done

==> Installing Alpine Linux in /var/lib/lxc/cc/rootfs
fetch http://dl-cdn.alpinelinux.org/alpine/v3.7/main/x86_64/APKINDEX.tar.gz
(1/16) Installing musl (1.1.18-r2)
(2/16) Installing busybox (1.27.2-r7)
Executing busybox-1.27.2-r7.post-install
(3/16) Installing alpine-baselayout (3.0.5-r2)
Executing alpine-baselayout-3.0.5-r2.pre-install
Executing alpine-baselayout-3.0.5-r2.post-install
(4/16) Installing openrc (0.24.1-r4)
Executing openrc-0.24.1-r4.post-install
(5/16) Installing alpine-conf (3.7.0-r0)
(6/16) Installing libressl2.6-libcrypto (2.6.3-r0)
(7/16) Installing libressl2.6-libssl (2.6.3-r0)
(8/16) Installing zlib (1.2.11-r1)
(9/16) Installing apk-tools (2.8.2-r0)
(10/16) Installing busybox-suid (1.27.2-r7)
(11/16) Installing busybox-initscripts (3.1-r2)
Executing busybox-initscripts-3.1-r2.post-install
(12/16) Installing scanelf (1.2.2-r1)
(13/16) Installing musl-utils (1.1.18-r2)
(14/16) Installing libc-utils (0.7.1-r0)
(15/16) Installing alpine-keys (2.1-r1)
(16/16) Installing alpine-base (3.7.0-r0)
Executing busybox-1.27.2-r7.trigger
OK: 7 MiB in 16 packages

==> Container's rootfs and config have been created
Edit the config file /var/lib/lxc/cc/config to check/enable networking setup.
The installed system is preconfigured for a loopback and single network
interface configured via DHCP.

To start the container, run "lxc-start -n cc".
The root password is not set; to enter the container run "lxc-attach -n cc".
```

Iniciamos y entramos en alpine:
```
ubuntu@ip-172-31-35-155:~$ sudo lxc-start -n cc
lxc-start: tools/lxc_start.c: main: 301 Container is already running.
ubuntu@ip-172-31-35-155:~$ sudo lxc-attach -n cc
/ #
```

## 4. Buscar alguna demo interesante de Docker y ejecutarla localmente, o en su defecto, ejecutar la imagen anterior y ver cómo funciona y los procesos que se llevan a cabo la primera vez que se ejecuta y las siguientes ocasiones.

Descargamos nodejs 8.x alpine:

```
docker pull node:8-alpine
8-alpine: Pulling from library/node
605ce1bd3f31: Pull complete
d6ade540dd0b: Pull complete
7608b7ec7a5f: Pull complete
Digest: sha256:b1e1f024dccf7058d2f55b21d6bf65c9cb932ba7bee2a24eca08ddb7c654312b
Status: Downloaded newer image for node:8-alpine
```


Mostramos la imagen:
```
other docker images
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
node                         8-alpine            7c2983dfbf98        13 days ago         68.1MB
```

Tras esto, podemos trabajar con python3 a traves del contenedor de una forma sencilla como podemos ver a continuación:
```
docker run -i -t node:8-alpine sh
```

## 5. Comparar el tamaño de las imágenes de diferentes sistemas operativos base, Fedora, CentOS y Alpine, por ejemplo.

Obtenemos las imagenes:
```
docker pull fedora
docker pull centos
docker pull alpine
```

Resultado:
```
REPOSITORY                   TAG                 IMAGE ID            CREATED             SIZE
alpine                       latest              3fd9065eaf02        13 days ago         4.15MB
centos                       latest              ff426288ea90        2 weeks ago         207MB
fedora                       latest              422dc563ca32        2 months ago        252MB
```

## 6. Crear a partir del contenedor anterior una imagen persistente con commit.

Para esto debemos realizar la siguiente instrucción con el contenedor del que queramos obtener una imagen persistente.

```
docker commit 8adb0abfcbeb erseco/ugr_cloud_computing
```

Resultado:
```
sha256:e9f1ef86f2b4bce3c2b52c6db48a5a65aef67b1ac3d8fc9f548d6a07d31f78d3
```

## 7. Examinar la estructura de capas que se forma al crear imágenes nuevas a partir de contenedores que se hayan estado ejecutando.

Mostramos el historial de la imagen:
```
docker history erseco/ugr_cloud_computing
```

Resultado:
```
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
9af4e249007b        4 weeks ago         /bin/sh -c #(nop)  CMD ["npm" "start"]          0B
<missing>           4 weeks ago         /bin/sh -c #(nop)  EXPOSE 8080/tcp              0B
<missing>           4 weeks ago         /bin/sh -c #(nop) COPY dir:5828d2a857d12a86e…   1.37kB
<missing>           4 weeks ago         /bin/sh -c npm install                          2.86MB
<missing>           4 weeks ago         /bin/sh -c #(nop) COPY file:da4a2352ff97dcdc…   256B
<missing>           4 weeks ago         /bin/sh -c #(nop) WORKDIR /usr/src/app          0B
<missing>           4 weeks ago         /bin/sh -c #(nop)  MAINTAINER Ernesto Serran…   0B
<missing>           6 weeks ago         /bin/sh -c #(nop)  CMD ["node"]                 0B
<missing>           6 weeks ago         /bin/sh -c set -ex   && for key in     6A010…   4.17MB
<missing>           6 weeks ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.3.2       0B
<missing>           6 weeks ago         /bin/sh -c ARCH= && dpkgArch="$(dpkg --print…   56.6MB
<missing>           6 weeks ago         /bin/sh -c #(nop)  ENV NODE_VERSION=8.9.3       0B
<missing>           6 weeks ago         /bin/sh -c set -ex   && for key in     94AE3…   129kB
<missing>           6 weeks ago         /bin/sh -c groupadd --gid 1000 node   && use…   335kB
<missing>           6 weeks ago         /bin/sh -c set -ex;  apt-get update;  apt-ge…   324MB
<missing>           6 weeks ago         /bin/sh -c apt-get update && apt-get install…   123MB
<missing>           6 weeks ago         /bin/sh -c set -ex;  if ! command -v gpg > /…   0B
<missing>           6 weeks ago         /bin/sh -c apt-get update && apt-get install…   44.6MB
<missing>           6 weeks ago         /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>           6 weeks ago         /bin/sh -c #(nop) ADD file:1dd78a123212328bd…   123MB
```

## 8. Crear un volumen y usarlo, por ejemplo, para escribir la salida de un programa determinado.

## 9. Usar un miniframework REST para crear un servicio web y introducirlo en un contenedor, y componerlo con un cliente REST que sea el que finalmente se ejecuta y sirve como “frontend”.

## 10. Reproducir los contenedores creados anteriormente usando un Dockerfile.
