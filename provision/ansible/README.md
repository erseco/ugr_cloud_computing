
### Ansible

Instalar Ansible en la máquina local:

```
brew install ansible
```

Para crear una nueva máquina en AWS ejecutar la orden:

```
ansible-playbook -vv -i localhost, -e "type=webservers" provision-ec2.yml
```


Para provisionar una maquina con nodejs y mongodb ejecutar la orden:

```
ansible-playbook -vv -b playbook.yml
```

Nota: Las instancias creadas en AWS para la asingarua *cloud computing* se deben crear con el *tag* `cc=true` para diferenciarlas de las usadas para otras tareas.