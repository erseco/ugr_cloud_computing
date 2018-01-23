# Ejercicios Tema 4

## 1. Instalar una máquina virtual Debian usando Vagrant y conectar con ella.

Agregamos la vagrant box de debian
```
vagrant box add debian/jessie64
```
Resultado:
```
==> box: Loading metadata for box 'debian/jessie64'
    box: URL: https://vagrantcloud.com/debian/jessie64
==> box: Adding box 'debian/jessie64' (v8.10.0) for provider: virtualbox
    box: Downloading: https://vagrantcloud.com/debian/boxes/jessie64/versions/8.10.0/providers/virtualbox.box
==> box: Successfully added box 'debian/jessie64' (v8.10.0) for 'virtualbox'!
```

Una vez creada debemos initializarla para ello:
```
mkdir debian
cd debian
vagrant init debian/jessie64
```

Resultado:
```
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

Levantamos la máquina:
```
vagrant up
```

Resultado:
```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'debian/jessie64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'debian/jessie64' is up to date...
==> default: Setting the name of the VM: debian_default_1516689923443_20699
==> default: Fixed port collision for 22 => 2222. Now on port 2200.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2200 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2200
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: No guest additions were detected on the base box for this VM! Guest
    default: additions are required for forwarded ports, shared folders, host only
    default: networking, and more. If SSH fails on this machine, please install
    default: the guest additions and repackage the box to continue.
    default:
    default: This is not an error message; everything may continue to work properly,
    default: in which case you may ignore this message.
==> default: Installing rsync to the VM...
==> default: Rsyncing folder: /Users/ernesto/Dropbox/Universidad/Master/Asignaturas/CC/Practicas/testing/debian/ => /vagrant

==> default: Machine 'default' has a post `vagrant up` message. This is a message
==> default: from the creator of the Vagrantfile, and not from Vagrant itself:
==> default:
==> default: Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports
```

Entramos en la máquina:
```
vagrant ssh
```

Resultado:
```
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
vagrant@jessie:~$
```

## 3. Crear un script para provisionar de forma básica una máquina virtual para el proyecto que se esté llevando a cabo en la asignatura.

```
Vagrant.configure("2") do |config|

	config.vm.box = "debian/jessie64"

	config.ssh.insert_key = false

	config.vm.provision "shell",
		inline: "sudo apt-get install -y python3-dev python3-pip git"
  end

end
```

Levantamos la máquina:
```
vagrant up
```

Resultado:
```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'debian/jessie64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'debian/jessie64' is up to date...
==> default: Setting the name of the VM: other_default_1516725599738_65079
==> default: Fixed port collision for 22 => 2222. Now on port 2201.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2201 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2201
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: No guest additions were detected on the base box for this VM! Guest
    default: additions are required for forwarded ports, shared folders, host only
    default: networking, and more. If SSH fails on this machine, please install
    default: the guest additions and repackage the box to continue.
    default:
    default: This is not an error message; everything may continue to work properly,
    default: in which case you may ignore this message.
==> default: Installing rsync to the VM...
==> default: Rsyncing folder: /Users/ernesto/Dropbox/Universidad/Master/Asignaturas/CC/Practicas/testing/other/ => /vagrant
==> default: Running provisioner: shell...
    default: Running: inline script
    default: Reading package lists...
    default: Building dependency tree...
    default:
    default: Reading state information...
    default: The following extra packages will be installed:
    default:   binutils build-essential cpp cpp-4.9 dh-python dpkg-dev fakeroot g++ g++-4.9
    default:   gcc gcc-4.9 git-man libalgorithm-diff-perl libalgorithm-diff-xs-perl
    default:   libalgorithm-merge-perl libasan1 libatomic1 libc-dev-bin libc6-dev
    default:   libcilkrts5 libcloog-isl4 libdpkg-perl liberror-perl libexpat1-dev
    default:   libfakeroot libfile-fcntllock-perl libgcc-4.9-dev libgomp1 libisl10 libitm1
    default:   liblsan0 libmpc3 libmpdec2 libmpfr4 libpython3-dev libpython3-stdlib
    default:   libpython3.4 libpython3.4-dev libpython3.4-minimal libpython3.4-stdlib
    default:   libquadmath0 libstdc++-4.9-dev libtsan0 libubsan0 linux-libc-dev make
[...]
    default: Setting up python3-wheel (0.24.0-1) ...
    default: Processing triggers for libc-bin (2.19-18+deb8u10) ...

==> default: Machine 'default' has a post `vagrant up` message. This is a message
==> default: from the creator of the Vagrantfile, and not from Vagrant itself:
==> default:
==> default: Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports
```

## 4. Configurar tu máquina virtual usando `vagrant` con el provisionador ansible
Primero tenemos que crear descargar la imagen a provisionar. Para ello:


Agregamos el siguiente `Vagrantfile` con el `playbook.yml` del Tema2:
```
Vagrant.configure("2") do |config|
	config.vm.box = "debian/jessie64"
	config.ssh.insert_key = false
	config.vm.provision "ansible" do |ansible|
		ansible.playbook = "provision.yml"
  end
end
```

Resultado:
```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'debian/jessie64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'debian/jessie64' is up to date...
==> default: Setting the name of the VM: other_default_1516726054490_96846
==> default: Fixed port collision for 22 => 2222. Now on port 2203.
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2203 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2203
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
    default: No guest additions were detected on the base box for this VM! Guest
    default: additions are required for forwarded ports, shared folders, host only
    default: networking, and more. If SSH fails on this machine, please install
    default: the guest additions and repackage the box to continue.
    default:
    default: This is not an error message; everything may continue to work properly,
    default: in which case you may ignore this message.
==> default: Installing rsync to the VM...
==> default: Rsyncing folder: /Users/ernesto/Dropbox/Universidad/Master/Asignaturas/CC/Practicas/testing/other/ => /vagrant
==> default: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.4.0.0).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    default: Running ansible-playbook...

PLAY [all] *********************************************************************

TASK [refresh apt cache] *******************************************************
changed: [default]

TASK [install python-apt to pull in python] ************************************
changed: [default]

TASK [install requirements] ****************************************************
changed: [default]

TASK [Clone project] ***********************************************************
changed: [default]

PLAY RECAP *********************************************************************
default                    : ok=4    changed=4    unreachable=0    failed=0


==> default: Machine 'default' has a post `vagrant up` message. This is a message
==> default: from the creator of the Vagrantfile, and not from Vagrant itself:
==> default:
==> default: Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports
```
