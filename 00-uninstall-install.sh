#!/bin/bash

cd ../  
cd openbach/
git checkout dev
git pull
cd ansible/
ansible-playbook -i inventory/nuc-inventory uninstall.yml -u kuhnn -k -K
ansible-playbook -i inventory/nuc-inventory install.yml -u kuhnn -k -K

