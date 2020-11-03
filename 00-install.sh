#!/bin/bash

# Checking the ansible version that is used 
echo "check ansible version - the results should be"
echo "ansible 2.7.6"
ansible --version

# Cloning openbach 
echo "cloning the openbach and openbach-extra repositories"
cd ../
git clone https://forge.net4sat.org/openbach/openbach.git
git clone https://forge.net4sat.org/openbach/openbach-extra.git

# Preparing the ansible inventory
cp nuc-inventory ../openbach/ansible/inventory/
cd ../openbach/ansible/

echo "Testing that ansible can ping everyone"
ansible -i inventory/nuc-inventory -u kuhnn -k -m ping all

echo "Starting installation"
ansible-playbook -i inventory/nuc-inventory install.yml -u kuhnn -k -K


