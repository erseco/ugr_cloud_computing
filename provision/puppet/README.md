
### Puppet

## Configuracion del Servidor

Instalar puppet en una máquina ubuntu 16.04:

```
cd ~ && wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get -y install puppetserver
```

Configuramos la cantidad de memoria que usará puppet

```
sudo vi /etc/default/puppetserver
```

Editamos la cantidad de memoria `JAVA_ARGS="-Xms1g -Xmx1g -XX:MaxPermSize=256m"`


Iniciar puppet-server:

```
sudo service puppetserver restart
```

Tambien podemos configurar puppet para que se inicie al arrancar el servidor

```
sudo /opt/puppetlabs/bin/puppet resource service puppetserver ensure=running enable=true
```

## Configuracion del agente

```
cd ~ && wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update
sudo apt-get install puppet-agent
sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
```


sudo /opt/puppetlabs/bin/puppet agent --server 54.174.111.76


Para provisionar una maquina con nodejs y mongodb ejecutar la orden:

```
ansible-playbook -vv -b playbook.yml
```

Nota: Las instancias creadas en AWS para la asingarua *cloud computing* se deben crear con el *tag* `cc=true` para diferenciarlas de las usadas para otras tareas.