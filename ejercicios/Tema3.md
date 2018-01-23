# Ejercicios Tema 3

## 1. Crear una máquina virtual Ubuntu e instalar en ella un servidor nginx para poder acceder mediante web.

He utilizado el cliente de azure en su versión 2.0 para realizar este ejercicio.
El primer paso ha sido crear la máquina virtual con el comando

```
aws ec2 run-instances --image-id ami-41e0b93b --count 1 --instance-type t2.nano --key-name ernesto --associate-public-ip-address
```

Resultado:
```
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-41e0b93b",
            "InstanceId": "i-0687f12297e8776a3",
            "InstanceType": "t2.nano",
            "KeyName": "ernesto",
            "LaunchTime": "2018-01-23T17:06:37.000Z",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1d",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-172-31-17-210.ec2.internal",
            "PrivateIpAddress": "172.31.17.210",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-f5da0282",
            "VpcId": "vpc-ac3883c9",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "",
            "EbsOptimized": false,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2018-01-23T17:06:37.000Z",
                        "AttachmentId": "eni-attach-9f2317a8",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching"
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "default",
                            "GroupId": "sg-997f4dfc"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "0a:35:a3:5c:22:a8",
                    "NetworkInterfaceId": "eni-922f0c69",
                    "OwnerId": "891066597074",
                    "PrivateDnsName": "ip-172-31-17-210.ec2.internal",
                    "PrivateIpAddress": "172.31.17.210",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateDnsName": "ip-172-31-17-210.ec2.internal",
                            "PrivateIpAddress": "172.31.17.210"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-f5da0282",
                    "VpcId": "vpc-ac3883c9"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "default",
                    "GroupId": "sg-997f4dfc"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "VirtualizationType": "hvm"
        }
    ],
    "OwnerId": "891066597074",
    "ReservationId": "r-0c8fefc6f0fd71534"
}
```


Entramos por ssh:
```
ssh ubuntu@52.200.14.34
```


Instalamos el servidor web `nginx`:
```
sudo apt-get update && sudo apt-get install -y nginx
```

Ejecutamos un `curl localhost`:
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

## 2. Crear una instancia de una máquina virtual Debian y provisionarla usando alguna de las aplicaciones vistas en el tema sobre herramientas de aprovisionamiento

Creamos un `Vagrantfile` y un `provision.yml`:
```
Vagrant.configure("2") do |config|
  config.vm.box = "sharpie/dummy"
  config.vm.box_version = "1.0.0"

  config.vm.provider :aws do |aws, override|

    # For fix this issue: https://github.com/hashicorp/vagrant/issues/5401
    override.nfs.functional = false

    # Definimos los valores que tendrán las instancias
    aws.keypair_name = "ernesto"
    aws.ami = "ami-cb4b94dd" # Debian
    aws.instance_type = "t2.nano"
    aws.tags = { "Name" => 'cloud_computing_debian' }
    aws.security_groups = "ssh-http-https"

    override.ssh.username = "admin"
    override.ssh.private_key_path = "~/.ssh/id_rsa"
  end

  # Configuración de la primera instancia
  config.vm.define "machine_1"

  # Este será el fichero que se provisionará
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provision.yml"
  end
end

```

```
---
- hosts: all
  become: yes
  become_method: sudo
  gather_facts: no
  pre_tasks:
  - name: refresh apt cache
    become: yes
    raw: sudo apt-get update
  - name: install python-apt to pull in python
    become: yes
    raw: sudo apt-get install --no-install-recommends --assume-yes python-apt
  tasks:
  - name: install docker
    become: yes
    raw: wget -qO- https://get.docker.com/ | sh
  - name: run container
    become: yes
    raw: sudo docker run -p 80:80 -d erseco/ugr_cloud_computing
```

Lo ejecutamos:
```
vagrant up
```

Resultado:
```
Bringing machine 'machine_1' up with 'aws' provider...
==> machine_1: Checking if box 'sharpie/dummy' is up to date...
==> machine_1: Warning! The AWS provider doesn't support any of the Vagrant
==> machine_1: high-level network configurations (`config.vm.network`). They
==> machine_1: will be silently ignored.
==> machine_1: Launching an instance with the following settings...
==> machine_1:  -- Type: t2.nano
==> machine_1:  -- AMI: ami-cb4b94dd
==> machine_1:  -- Region: us-east-1
==> machine_1:  -- Keypair: ernesto
==> machine_1:  -- Security Groups: ["ssh-http-https"]
==> machine_1:  -- Block Device Mapping: []
==> machine_1:  -- Terminate On Shutdown: false
==> machine_1:  -- Monitoring: false
==> machine_1:  -- EBS optimized: false
==> machine_1:  -- Source Destination check:
==> machine_1:  -- Assigning a public IP address in a VPC: false
==> machine_1:  -- VPC tenancy specification: default
==> machine_1: Waiting for instance to become "ready"...
==> machine_1: Waiting for SSH to become available...
==> machine_1: Machine is booted and ready for use!
==> machine_1: Installing rsync to the VM...
==> machine_1: Rsyncing folder: /Users/ernesto/Dropbox/Universidad/Master/Asignaturas/CC/Practicas/testing/other/ => /vagrant
==> machine_1: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.4.0.0).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    machine_1: Running ansible-playbook...

PLAY [all] *********************************************************************

TASK [refresh apt cache] *******************************************************
changed: [machine_1]

TASK [install python-apt to pull in python] ************************************
changed: [machine_1]

TASK [install docker] **********************************************************
changed: [machine_1]

TASK [run container] ***********************************************************
changed: [machine_1]

PLAY RECAP *********************************************************************
machine_1                  : ok=4    changed=4    unreachable=0    failed=0
```

