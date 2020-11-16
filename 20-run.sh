#!/bin/bash
  
# move the scripts in the right folder
cp 21-* ../openbach-extra/executors/examples/
cp 22-* ../openbach-extra/executors/examples/
cp 23-* ../openbach-extra/executors/examples/
cd ../openbach-extra/executors/examples/

##########################################
# Using reference scenarios
##########################################

# TBD 

##########################################
# Using the custom scenarios
##########################################

# clean interfaces 
python3 21-run-interface-limits-clear.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run

# apply interface limitations
python3 22-run-interface-limits-set-qos.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --mode apply --test_qos yes run --file time_series figure --data /home/kuhnn/Desktop/results/

# run service level tests - will be available on next OpenBACH release 
#python3 23-run-service.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run

# clean interfaces 
python3 21-run-interface-limits-clear.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run


