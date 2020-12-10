#!/bin/bash

CHOICE=$1

if [[ $CHOICE != "ref" ]] && [[ $CHOICE != "custom" ]] && [[ $CHOICE != "both" ]]
then 
	echo "Wrong entry" 
	echo "Enter the choice :"
	echo "'custom' for test using custom scenarios only"
	echo "'ref' for test using reference scenarios only"
	echo "'both' for test using custom and reference scenarios"
	exit 1
fi
  
if [[ $CHOICE = "custom" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using custom scenarios"
	echo "##################################################################"
		# move the scripts in the right folder
		cp 21-* ../openbach-extra/executors/examples/
		cp 22-* ../openbach-extra/executors/examples/
		cp 23-* ../openbach-extra/executors/examples/
		cd ../openbach-extra/executors/examples/

		# clean interfaces 
		# This scenario clears the interfaces of both NUCs on the data path (10.10.0.0/24)
		python3 21-run-interface-limits-clear.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run

		# apply interface limitations
		# This scenario sets the interfaces to limits of bandwidth and latency of both NUCs on the data path (10.10.0.0/24)
		# This scenario also tests the QoS between the two NUCs using the network_global reference scenario
		python3 22-run-interface-limits-set-qos.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --mode apply --test_qos yes run --file time_series figure --data /home/kuhnn/Desktop/results/

		# run service level tests - will be available on next OpenBACH release 
		#python3 23-run-service.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run

		# clean interfaces 
		# This scenario clears the interfaces of both NUCs on the data path (10.10.0.0/24)
		python3 21-run-interface-limits-clear.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc run

		# change directory
		cd ../../../openbach-example-simple/

	echo " "

fi 

if [[ $CHOICE = "ref" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using reference scenarios"
	echo "##################################################################"
	echo " "
		# change directory
		cd ../openbach-extra/executors/references/

		# This scenario clears the interfaces of both NUCs on the data path (10.10.0.0/24)
		echo "------------------------------"
		echo "clear interfaces"
		echo "------------------------------"
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc1 --ifaces enp0s25 --mode egress --operation clear --bandwidth 10M --delay 10 run 
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc2 --ifaces enp0s25 --mode egress --operation clear --bandwidth 20M --delay 20 run 
		# This scenario sets the interfaces to limits of bandwidth and latency of both NUCs on the data path (10.10.0.0/24)
		echo "------------------------------"
		echo "set limits on interfaces"
		echo "------------------------------"
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc1 --ifaces enp0s25 --mode egress --operation apply --bandwidth 10M --lm random --lmp 1 --delay 10 run 
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc2 --ifaces enp0s25 --mode egress --operation apply --bandwidth 20M --lm random --lmp 1 --delay 20 run
		# This scenario also tests the QoS between the two NUCs using the network_global reference scenario
		echo "------------------------------"
		echo "run E2E network global"
		echo "------------------------------"
		python3 executor_network_global.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --server-entity nuc1 --client-entity nuc2 --server-ip 10.10.0.1 --client-ip 10.10.0.2 --rate-limit 100M --loss-measurement --max-synchro-off 200 --post-processing-entity nuc1 run --file time_series figure --data /home/kuhnn/Desktop/results/
		python3 executor_network_global.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --server-entity nuc2 --client-entity nuc1 --server-ip 10.10.0.2 --client-ip 10.10.0.1 --rate-limit 100M --loss-measurement --max-synchro-off 200 --post-processing-entity nuc1 run --file time_series figure --data /home/kuhnn/Desktop/results/
		# run service level tests - will be available on next OpenBACH release 

		# This scenario clears the interfaces of both NUCs on the data path (10.10.0.0/24)
		echo "------------------------------"
		echo "clear interfaces"
		echo "------------------------------"
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc1 --ifaces enp0s25 --mode egress --operation clear --bandwidth 10M --delay 10 run 
		python3 executor_network_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --entity nuc2 --ifaces enp0s25 --mode egress --operation clear --bandwidth 20M --delay 20 run 
		# change directory
		cd ../../../openbach-example-simple/
fi

