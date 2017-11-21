#!/bin/bash

# Create security group
az group create --name group1 --location southcentralus

# Create VM instance
az vm create --resource-group group1 --name vm1 --image UbuntuLTS --ssh-key-value ~/.ssh/id_rsa.pub


# Open http port (80)
az vm open-port --port 80 --resource-group group1 --name vm1

