#!/bin/bash
  
################################
# TEST DATA EXAMPLE 
################################
#
#cd ../executors/examples/
#python3 data_transfer_configure_link.py testobachnuc --entity midbox1 --server endpoint1 --client midbox2 --post-processing-entity endpoint1 --file-size 100 -B 10M -b 10M -D 10 -d 10 -I 10.3.32.1 -i 10.3.33.2 --interfaces ens20 run

# move the scripts in the right folder
cp 21-* ../openbach-extra/executors/examples/
cp 22-* ../openbach-extra/executors/examples/
cp 23-* ../openbach-extra/executors/examples/
cd ../openbach-extra/executors/examples/

# clean interfaces 
python3 21-run-interface-limits-clear.py --controller 192.168.3.44 --login openbach --password openbach testobachnuc run

# apply interface limitations
python3 22-run-interface-limits-set-qos.py --controller 192.168.3.44 --login openbach --password openbach testobachnuc --mode apply --test_qos yes run --file time_series figure --data /home/kuhnn/Desktop/results/

# push config.yaml to relevant agents - this is temporary fix
#for agent in 192.168.1.41 192.168.1.42
#do
#        ssh -t $agent "sudo cp config.yaml /opt/openbach/agent/jobs/web_browsing_qoe/"
#done

# run service level tests
#python3 23-run-service.py --controller 192.168.3.44 --login openbach --password openbach testobachnuc run

# clean interfaces 
python3 21-run-interface-limits-clear.py --controller 192.168.3.44 --login openbach --password openbach testobachnuc run


