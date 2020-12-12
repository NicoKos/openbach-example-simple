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
  
cd ../openbach-extra/executors/examples/

if [[ $CHOICE = "tcp" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using TCP"
	echo "##################################################################"
	

	echo " "

fi 

if [[ $CHOICE = "ref" ]] || [[ $CHOICE = "both" ]]
then
	echo "##################################################################"
	echo "Test using reference scenarios"
	echo "##################################################################"


	echo " "

fi

