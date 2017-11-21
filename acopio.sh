#!/bin/bash

az group create --name cc_resource_group --location eastus


az network vnet create \
    --resource-group cc_resource_group \
    --name cc_vnet \
    --address-prefix 192.168.0.0/16 \
    --subnet-name mySubnet \
    --subnet-prefix 192.168.1.0/24


az network public-ip create \
    --resource-group cc_resource_group \
    --name myPublicIP \
    --dns-name erseco

az network nsg create \
    --resource-group cc_resource_group \
    --name cc_network_security_group



az network nsg rule create \
    --resource-group cc_resource_group \
    --nsg-name cc_network_security_group \
    --name cc_network_security_group_RuleSSH \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow


az network nsg rule create \
    --resource-group cc_resource_group \
    --nsg-name cc_network_security_group \
    --name cc_network_security_group_RuleWeb \
    --protocol tcp \
    --priority 1001 \
    --destination-port-range 80 \
    --access allow


az network nsg show --resource-group cc_resource_group --name cc_network_security_group


az network nic create \
    --resource-group cc_resource_group \
    --name cc_nic \
    --vnet-name cc_vnet \
    --subnet mySubnet \
    --public-ip-address myPublicIP \
    --network-security-group cc_network_security_group


az vm availability-set create \
    --resource-group cc_resource_group \
    --name myAvailabilitySet


az vm create \
    --resource-group cc_resource_group \
    --name myVM \
    --location eastus \
    --availability-set myAvailabilitySet \
    --nics cc_nic \
    --image UbuntuLTS \
    --admin-username azureuser \
    --generate-ssh-keys


