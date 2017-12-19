# HOW-TO

Vamos a provisionar máquinas con Vagrant, en nuestras pruebas vamos a crear dos máquinas con Ubuntu 16.04 LTS por ser una versión de Ubuntu muy estable y con soporte extendido

## Instalación de vagrant

Instalamos vagrant siguiendo la guia de su web

## Orquestación en AWS con vagrant

Instalamos el plugin `vagrant-aws`

```
vagrant plugin install vagrant-aws
```

Orquestamos la máquina segun el Vagrantfile

```
vagrant up
```
NOTA: Para evitar tener que agregar las credenciales al Vagranfile se han definido en `$HOME/.aws/credentials` tal y como recomienda la documentación de AWS


## Orquestación en azure con vagrant

```
az login
az ad sp create-for-rbac
az account list --query "[?isDefault].id" -o tsv
vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure
vagrant plugin install vagrant-azure

vagrant up --no-parallel --provider=azure
```

Esto nos dará la salida:

```
➜  orquestation git:(master) ✗ vagrant up --no-parallel --provider=azure
Bringing machine 'default' up with 'azure' provider...
==> default: Launching an instance with the following settings...
==> default:  -- Management Endpoint: https://management.azure.com
==> default:  -- Subscription Id: 103d06ad-2052-4f03-9762-f1873fc22968
==> default:  -- Resource Group Name: sparkling-sky-87
==> default:  -- Location: westus
==> default:  -- Admin Username: vagrant
==> default:  -- VM Name: frosty-field-52
==> default:  -- VM Storage Account Type: Premium_LRS
==> default:  -- VM Size: Standard_DS2_v2
==> default:  -- Image URN: canonical:ubuntuserver:16.04.0-LTS:latest
==> default:  -- DNS Label Prefix: frosty-field-52
==> default:  -- Create or Update of Resource Group: sparkling-sky-87
==> default:  -- Starting deployment
....
```


