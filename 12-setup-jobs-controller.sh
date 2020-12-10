#!/bin/bash

controllername=controller-virt-expe
projectname=testobach
installalljobs=true

nuc1=nuc1
nuc1IP=192.168.1.41
nuc2=nuc2
nuc2IP=192.168.1.42

job_list="ip_route d-itg_recv d-itg_send owamp-server owamp-client hping dashjs_client tc_configure_link histogram time_series web_browsing_qoe nuttcp apache2 voip_qoe_dest voip_qoe_src tcp_conf_linux synchronization tcpdump_pcap pcap_postprocessing kernel_compile"

cd ../openbach-extra/apis/auditorium_scripts/

echo "================================"
echo "Remove jobs from controler" 
echo "================================"
for job in $job_list
do 
	echo "-----------------------"
	echo "removing $job"
	python3 delete_job.py $job 
done

echo "================================="
echo "add ip_route"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/network/ip_route ip_route

echo "================================="
echo "add synchronization"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/admin_jobs/synchronization synchronization


echo "================================="
echo "add d-itg_recv"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/network/d-itg_recv d-itg_recv

echo "================================="
echo "add d-itg_send"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/network/d-itg_send d-itg_send

echo "================================="
echo "add owamp-server"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/network/owamp-server owamp-server

echo "================================="
echo "add owamp-client"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/network/owamp-client owamp-client

echo "================================="
echo "add hping"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/network/hping hping

echo "================================="
echo "add dashjs_client"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/service/dashjs_client dashjs_client

echo "================================="
echo "add tc_configure_link"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/network/tc_configure_link tc_configure_link 

echo "================================="
echo "add histogram"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/post_processing/histogram histogram 

echo "================================="
echo "add time_series"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/post_processing/time_series time_series

echo "================================="
echo "add web_browsing_qoe"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/service/web_browsing_qoe web_browsing_qoe 

echo "================================="
echo "add nuttcp"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/transport/nuttcp nuttcp 

echo "================================="
echo "add apache2"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/service/apache2 apache2

echo "================================="
echo "add voip_qoe_dest"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/service/voip_qoe/voip_qoe_dest voip_qoe_dest 

echo "================================="
echo "add voip_qoe_src"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/service/voip_qoe/voip_qoe_src voip_qoe_src

echo "================================="
echo "add tcp_conf_linux"
echo "================================="
python3 add_job.py -f ../../../openbach-extra/externals_jobs/stable_jobs/transport/tcp_conf_linux tcp_conf_linux 

echo "================================="
echo "add tcpdump_pcap"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/transport/tcpdump_pcap tcpdump_pcap 

echo "================================="
echo "add pcap_postprocessing"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/core_jobs/post_processing/pcap_postprocessing pcap_postprocessing

echo "================================="
echo "add kernel_compile"
echo "================================="
python3 add_job.py -f ../../../openbach/src/jobs/admin_jobs/kernel_compile kernel_compile 



