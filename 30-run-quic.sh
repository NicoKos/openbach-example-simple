#!/bin/bash

# This senario exploits the data_transfert_configure_link and quic_configure_link examples.
#   Data is transmitted from a server to a client - using either TCP and IPERF3 or QUIC
#   Bandwidth, loss, delay limitations are introduced between the client and the server

CHOICE=$1

if [[ $CHOICE != "tcp" ]] && [[ $CHOICE != "quic" ]] && [[ $CHOICE != "both" ]]
then 
	echo "Wrong entry" 
	echo "Enter the choice :"
	echo "'tcp' for test using TCP"
	echo "'quic' for test using QUIC"
	echo "'both' for test using custom and reference scenarios"
	exit 1
fi
 
cp 31-* ../openbach-extra/executors/examples/
cd ../openbach-extra/executors/examples/

if [[ $CHOICE = "tcp" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using TCP"
	echo "##################################################################"
	

	echo " "

fi 

if [[ $CHOICE = "quic" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using reference scenarios"
	echo "##################################################################"
	python3 31-quic_configure_link.py --controller 192.168.1.44 --login openbach --password openbach testobachnuc --bandwidth-server-to-client 1M --bandwidth-client-to-server 100K --delay-server-to-client 25 --delay-client-to-server 25 --up-iface enp0s25 --down-iface enp0s25 --server nuc1 --server-ip 10.10.0.1 --server-implementation picoquic --server-extra-args '-G bbr' --client nuc2 --client-implementation picoquic --resources 100M_file.txt --download-dir /tmp/ --server-log-dir /tmp/ --client-log-dir /tmp/ --nb-runs 1 --pcaps-dir /tmp/ --report-dir /tmp/ --post-processing-entity nuc1 run --file time_series figure --data /home/kuhnn/Desktop/results_quic
 	echo " "

fi



