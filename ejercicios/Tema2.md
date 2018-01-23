# Ejercicios Tema 2

## 1. Instalar chef-solo en la máquina virtual que vayamos a usar.

Instalamos chef:
```
curl -L https://www.opscode.com/chef/install.sh | sudo bash
```

Comprobamos la versión:
```
ubuntu@ip-172-31-35-155:~$ chef-solo --version
Chef: 13.6.4
```
## 2. Crear una receta para instalar nginx, tu editor favorito y algún directorio y fichero que uses de forma habitual.

Creamos una máquina Ubuntu 16.04 LTS en AWS (elegimos esta por ser una LTS de uso muy extendido)

Estructura de directorios de la receta:
```
mkdir -p chef/cookbooks/nginx/recipes
```


Crear archivo `~/chef/cookbooks/nginx/recipesdefault.rb`:
```
package 'nginx'
package 'vim'
directory '/home/ubuntu/tema2'
file "/home/ubuntu/tema2/test.txt" do
    owner "ubuntu"
    group "ubuntu"
    mode 00644
    action :create
    content "Test installation for CC"
end
```


Crear archivo `~/chef/node.json`:
```
{
  "run_list":["recipe[nginx]"]
}
```


Crear archivo `~/chef/solo.rb`:
```
file_cache_path "/home/ubuntu/chef"
cookbook_path "/home/ubuntu/chef/cookbooks"
json_attribs "/home/ubuntu/chef/node.json"
```

Ejecutamos:
```
cd chef
sudo chef-solo -c solo.rb
```

Resultado:
```
ubuntu@ip-172-31-35-155:~/chef$ sudo chef-solo -c solo.rb
Starting Chef Client, version 13.6.4
resolving cookbooks for run list: ["nginx"]
Synchronizing Cookbooks:
  - nginx (0.0.0)
Installing Cookbook Gems:
Compiling Cookbooks...
Converging 4 resources
Recipe: nginx::default
  * apt_package[nginx] action install (up to date)
  * apt_package[vim] action install (up to date)
  * directory[/home/ubuntu/tema2] action create (up to date)
  * file[/home/ubuntu/tema2/test.txt] action create (up to date)

Running handlers:
Running handlers complete
Chef Client finished, 0/4 resources updated in 01 seconds
```


## 3. Escribir en YAML la siguiente estructura de datos en JSON { "uno": "dos", "tres": [ 4, 5, "Seis", { siete: 8, nueve: [ 10, 11 ] } ] }

Ese JSON es incorrecto, el correcto sería:

```
{
  "uno": "dos",
  "tres": [4, 5, "Seis", {
    "siete": 8,
    "nueve": [10, 11]
  }]
}
```


Y su versión YAML:
```
---
uno: dos
tres:
- 4
- 5
- Seis
- siete: 8
  nueve:
  - 10
  - 11
```

## 5. Desplegar los fuentes de una aplicación cualquiera, propia o libre, que se encuentre en un servidor git público en la máquina virtual Azure (o una máquina virtual local) usando ansible.

Instalamos ansible:
```
sudo apt-get install ansible
```


Editamos el fichero `/etc/ansible/hosts`:
```
[test]
54.160.5.244 ansible_user=ubuntu
```

Una vez indicada la maquina virtual que provisionaremos comienzo la instalación de los diferentes paquetes para desplegar el proyecto. He tenido que forzar la installacion (parametro -y) ya que sino me pedia verificación y no podía realizar la instalación utilizando ansible.

```
ansible test -m command -a "apt-get install -y git nodejs mongodb python-apt"
```

Resultado:
```
 [WARNING]: Consider using apt module rather than running apt-get

54.160.5.244 | SUCCESS | rc=0 >>
Reading package lists...
Building dependency tree...
Reading state information...
git is already the newest version (1:2.7.4-0ubuntu1.3).
The following additional packages will be installed:
  libboost-filesystem1.58.0 libboost-program-options1.58.0
  libboost-system1.58.0 libboost-thread1.58.0 libgoogle-perftools4
  libpcrecpp0v5 libsnappy1v5 libtcmalloc-minimal4 libunwind8 libuv1
  libv8-3.14.5 libyaml-cpp0.5v5 mongodb-clients mongodb-server
The following NEW packages will be installed:
  libboost-filesystem1.58.0 libboost-program-options1.58.0
  libboost-system1.58.0 libboost-thread1.58.0 libgoogle-perftools4
  libpcrecpp0v5 libsnappy1v5 libtcmalloc-minimal4 libunwind8 libuv1
  libv8-3.14.5 libyaml-cpp0.5v5 mongodb mongodb-clients mongodb-server nodejs
0 upgraded, 16 newly installed, 0 to remove and 5 not upgraded.
Need to get 61.2 MB of archives.
After this operation, 210 MB of additional disk space will be used.
Get:1 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libpcrecpp0v5 amd64 2:8.38-3.1 [15.2 kB]
Get:2 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libboost-system1.58.0 amd64 1.58.0+dfsg-5ubuntu3.1 [9,146 B]
Get:3 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libboost-filesystem1.58.0 amd64 1.58.0+dfsg-5ubuntu3.1 [37.5 kB]
Get:4 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libboost-program-options1.58.0 amd64 1.58.0+dfsg-5ubuntu3.1 [138 kB]
Get:5 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libboost-thread1.58.0 amd64 1.58.0+dfsg-5ubuntu3.1 [47.0 kB]
Get:6 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libtcmalloc-minimal4 amd64 2.4-0ubuntu5.16.04.1 [105 kB]
Get:7 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libunwind8 amd64 1.1-4.1 [46.5 kB]
Get:8 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libgoogle-perftools4 amd64 2.4-0ubuntu5.16.04.1 [187 kB]
Get:9 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 libuv1 amd64 1.8.0-1 [57.4 kB]
Get:10 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 libv8-3.14.5 amd64 3.14.5.8-5ubuntu2 [1,189 kB]
Get:11 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 libyaml-cpp0.5v5 amd64 0.5.2-3 [158 kB]
Get:12 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/main amd64 libsnappy1v5 amd64 1.1.3-2 [16.0 kB]
Get:13 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 mongodb-clients amd64 1:2.6.10-0ubuntu1 [48.6 MB]
Get:14 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 mongodb-server amd64 1:2.6.10-0ubuntu1 [7,425 kB]
Get:15 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial/universe amd64 mongodb amd64 1:2.6.10-0ubuntu1 [5,112 B]
Get:16 http://us-east-1.ec2.archive.ubuntu.com/ubuntu xenial-updates/universe amd64 nodejs amd64 4.2.6~dfsg-1ubuntu4.1 [3,161 kB]
Fetched 61.2 MB in 2s (21.3 MB/s)
Selecting previously unselected package libpcrecpp0v5:amd64.
(Reading database ... 94634 files and directories currently installed.)
Preparing to unpack .../libpcrecpp0v5_2%3a8.38-3.1_amd64.deb ...
Unpacking libpcrecpp0v5:amd64 (2:8.38-3.1) ...
Selecting previously unselected package libboost-system1.58.0:amd64.
Preparing to unpack .../libboost-system1.58.0_1.58.0+dfsg-5ubuntu3.1_amd64.deb ...
Unpacking libboost-system1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Selecting previously unselected package libboost-filesystem1.58.0:amd64.
Preparing to unpack .../libboost-filesystem1.58.0_1.58.0+dfsg-5ubuntu3.1_amd64.deb ...
Unpacking libboost-filesystem1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Selecting previously unselected package libboost-program-options1.58.0:amd64.
Preparing to unpack .../libboost-program-options1.58.0_1.58.0+dfsg-5ubuntu3.1_amd64.deb ...
Unpacking libboost-program-options1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Selecting previously unselected package libboost-thread1.58.0:amd64.
Preparing to unpack .../libboost-thread1.58.0_1.58.0+dfsg-5ubuntu3.1_amd64.deb ...
Unpacking libboost-thread1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Selecting previously unselected package libtcmalloc-minimal4.
Preparing to unpack .../libtcmalloc-minimal4_2.4-0ubuntu5.16.04.1_amd64.deb ...
Unpacking libtcmalloc-minimal4 (2.4-0ubuntu5.16.04.1) ...
Selecting previously unselected package libunwind8.
Preparing to unpack .../libunwind8_1.1-4.1_amd64.deb ...
Unpacking libunwind8 (1.1-4.1) ...
Selecting previously unselected package libgoogle-perftools4.
Preparing to unpack .../libgoogle-perftools4_2.4-0ubuntu5.16.04.1_amd64.deb ...
Unpacking libgoogle-perftools4 (2.4-0ubuntu5.16.04.1) ...
Selecting previously unselected package libuv1:amd64.
Preparing to unpack .../libuv1_1.8.0-1_amd64.deb ...
Unpacking libuv1:amd64 (1.8.0-1) ...
Selecting previously unselected package libv8-3.14.5.
Preparing to unpack .../libv8-3.14.5_3.14.5.8-5ubuntu2_amd64.deb ...
Unpacking libv8-3.14.5 (3.14.5.8-5ubuntu2) ...
Selecting previously unselected package libyaml-cpp0.5v5:amd64.
Preparing to unpack .../libyaml-cpp0.5v5_0.5.2-3_amd64.deb ...
Unpacking libyaml-cpp0.5v5:amd64 (0.5.2-3) ...
Selecting previously unselected package libsnappy1v5:amd64.
Preparing to unpack .../libsnappy1v5_1.1.3-2_amd64.deb ...
Unpacking libsnappy1v5:amd64 (1.1.3-2) ...
Selecting previously unselected package mongodb-clients.
Preparing to unpack .../mongodb-clients_1%3a2.6.10-0ubuntu1_amd64.deb ...
Unpacking mongodb-clients (1:2.6.10-0ubuntu1) ...
Selecting previously unselected package mongodb-server.
Preparing to unpack .../mongodb-server_1%3a2.6.10-0ubuntu1_amd64.deb ...
Unpacking mongodb-server (1:2.6.10-0ubuntu1) ...
Selecting previously unselected package mongodb.
Preparing to unpack .../mongodb_1%3a2.6.10-0ubuntu1_amd64.deb ...
Unpacking mongodb (1:2.6.10-0ubuntu1) ...
Selecting previously unselected package nodejs.
Preparing to unpack .../nodejs_4.2.6~dfsg-1ubuntu4.1_amd64.deb ...
Unpacking nodejs (4.2.6~dfsg-1ubuntu4.1) ...
Processing triggers for libc-bin (2.23-0ubuntu10) ...
Processing triggers for man-db (2.7.5-1) ...
Processing triggers for systemd (229-4ubuntu21) ...
Processing triggers for ureadahead (0.100.0-19) ...
Setting up libpcrecpp0v5:amd64 (2:8.38-3.1) ...
Setting up libboost-system1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Setting up libboost-filesystem1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Setting up libboost-program-options1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Setting up libboost-thread1.58.0:amd64 (1.58.0+dfsg-5ubuntu3.1) ...
Setting up libtcmalloc-minimal4 (2.4-0ubuntu5.16.04.1) ...
Setting up libunwind8 (1.1-4.1) ...
Setting up libgoogle-perftools4 (2.4-0ubuntu5.16.04.1) ...
Setting up libuv1:amd64 (1.8.0-1) ...
Setting up libv8-3.14.5 (3.14.5.8-5ubuntu2) ...
Setting up libyaml-cpp0.5v5:amd64 (0.5.2-3) ...
Setting up libsnappy1v5:amd64 (1.1.3-2) ...
Setting up mongodb-clients (1:2.6.10-0ubuntu1) ...
Setting up mongodb-server (1:2.6.10-0ubuntu1) ...
Adding system user 'mongodb' (UID 112) ...
Adding new user 'mongodb' (UID 112) with group 'nogroup' ...
Not creating home directory '/var/lib/mongodb'.
Adding group 'mongodb' (GID 116) ...
Done.
Adding user 'mongodb' to group 'mongodb' ...
Adding user mongodb to group mongodb
Done.
Setting up mongodb (1:2.6.10-0ubuntu1) ...
Setting up nodejs (4.2.6~dfsg-1ubuntu4.1) ...
update-alternatives: using /usr/bin/nodejs to provide /usr/bin/js (js) in auto mode
Processing triggers for libc-bin (2.23-0ubuntu10) ...
Processing triggers for systemd (229-4ubuntu21) ...
Processing triggers for ureadahead (0.100.0-19) ...

```

Una vez instalado clonamos el repositorio del proyecto y copiamos el contenido al servidor apache. Para realizar la copia he
cambiado los permisos del usuario "Ubuntu" en esa ruta, ya que no me permitia realizar la clonación por ello.
```
ansible test -m git -a "repo=https://github.com/erseco/ugr_desarrollo_aplicaciones_internet.git dest=/home/ubuntu/dai/"
```

Resultado:
```
54.160.5.244 | SUCCESS => {
    "after": "096848316545215a5265080e04fc746d9c10cf23",
    "before": null,
    "changed": true,
    "failed": false
}
```

## 6. Desplegar la aplicación que se haya usado anteriormente con todos los módulos necesarios usando un playbook de Ansible.

Creamos el archivo `playbook.yml`:
```
---
- hosts: test
  become: yes
  become_user: ubuntu
  gather_facts: no

  pre_tasks:
  - name: refresh apt cache
    become: yes
    raw: sudo apt-get update
  - name: install python-apt to pull in python
    become: yes
    raw: sudo apt-get install --no-install-recommends --assume-yes python-apt
  tasks:
  - name: install requirements
    become: yes
    raw: sudo apt-get -y install git nodejs mongodb
  - name: Clone project
    git: repo=https://github.com/erseco/ugr_desarrollo_aplicaciones_internet.git dest=/home/ubuntu/dai/
```

Ejecutamos el playbook:
```
ansible-playbook -b playbook.yml
```

Resultado:
```
PLAY [test] ************************************************************************************************************************

TASK [refresh apt cache] ***********************************************************************************************************
changed: [54.160.5.244]

TASK [install python-apt to pull in python] ****************************************************************************************
changed: [54.160.5.244]

TASK [install requirements] ********************************************************************************************************
changed: [54.160.5.244]

TASK [Clone project] ***************************************************************************************************************
changed: [54.160.5.244]

PLAY RECAP *************************************************************************************************************************
54.160.5.244               : ok=4    changed=4    unreachable=0    failed=0
```









