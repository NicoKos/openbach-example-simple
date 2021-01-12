#!/bin/bash
  
controllername=controller-nuc
projectname=testobachnuc
installalljobs=true

nuc1=nuc1
nuc1IP=192.168.1.41
nuc2=nuc2
nuc2IP=192.168.1.42

echo "================================="
echo "Add controllers in necessary folders" 
echo "================================="
bash 11-setup-change-controller.sh $controllername
echo " "

echo "================================="
echo "Delete project"
echo "================================="
cd ../openbach-extra/apis/auditorium_scripts/
python3 delete_project.py $projectname
echo " "
cd ../../../openbach-example-simple/

echo "================================="
echo "Create project"
echo "================================="
cd ../openbach-extra/apis/auditorium_scripts/
python3 create_project.py $projectname
echo " "
cd ../../../openbach-example-simple/

echo "================================="
echo "Add entities to project"
echo "================================="
cd ../openbach-extra/apis/auditorium_scripts/
python3 add_entity.py $nuc1 $projectname -a $nuc1IP 
python3 add_entity.py $nuc2 $projectname -a $nuc2IP
echo " "
cd ../../../openbach-example-simple/

echo "================================="
echo "Add jobs to entities "
echo "================================="

if $installalljobs
then
        echo "installing all the jobs"
        bash 12-setup-jobs-controller.sh
fi

cd ../openbach-extra/apis/auditorium_scripts/
for agents in $nuc1IP $nuc2IP
do
        # List existing projects
        l_jobs=$(python3 list_installed_jobs.py $agents)
        echo "---------------------------"
        echo "working on $agents"
        #for job in ip_route d-itg_recv d-itg_send owamp-server owamp-client hping dashjs_client tc_configure_link histogram time_series web_browsing_qoe nuttcp apache2 voip_qoe_dest voip_qoe_src tcp_conf_linux synchronization tcpdump_pcap pcap_postprocessing kernel_compile quic
        for job in ip_route d-itg_recv d-itg_send owamp-server owamp-client hping dashjs_client tc_configure_link histogram time_series web_browsing_qoe nuttcp voip_qoe_dest voip_qoe_src tcp_conf_linux synchronization tcpdump_pcap pcap_postprocessing kernel_compile quic
        do
                if $installalljobs
                then
                        echo "uninstalling $job on $agents"
                        python3 uninstall_jobs.py -j $job -a $agents
                        echo "installing $job on $agents"
                        python3 install_jobs.py -j $job -a $agents
                else
                        # Check if the project already exists
                        if [[ $l_jobs =~ $job ]]
                        then
                                echo "$job already installed on $agents"
                        else
                                echo "installing $job on $agents"
                                python3 install_jobs.py -j $job -a $agents
                        fi
                fi
        done
done

