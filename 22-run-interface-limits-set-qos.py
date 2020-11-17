#!/usr/bin/env python
  
# OpenBACH is a generic testbed able to control/configure multiple
# network/physical entities (under test) and collect data from them.
# It is composed of an Auditorium (HMIs), a Controller, a Collector
# and multiple Agents (one for each network entity that wants to be
# tested).
#
#
# Copyright © 2016-2019 CNES
#
#
# This file is part of the OpenBACH testbed.
#
#
# OpenBACH is a free software : you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.

"""Example of scenarios composition.
"""

from auditorium_scripts.scenario_observer import ScenarioObserver, DataProcessor
from scenario_builder.scenarios import network_configure_link, network_global

""" Global parameters
"""


###########################################################
# Admin sys
###########################################################
# NUC 1
EP1="nuc1"
EP1_IP="192.168.1.41"
EP1_IF1="enp0s25"
EP1_IF1_BD="10M"
EP1_IF1_DELAY=10
EP1_IF1_LM="random"
EP1_IF1_LMP=0
EP1_IF1_IP="10.10.0.1"

# NUC 2
EP2="nuc2"
EP2_IP="192.168.1.42"
EP2_IF1="enp0s25"
EP2_IF1_BD="20M"
EP2_IF1_DELAY=20
EP2_IF1_LM="random"
EP2_IF1_LMP=0
EP2_IF1_IP="10.10.0.2"

""" clear all interfaces
"""

def set_clear_interfaces(observer,operation):

    for [e,e_ip,e_if,e_bd,e_delay,e_lm,e_lmp] in \
            [[EP1,EP1_IP,EP1_IF1,EP1_IF1_BD,EP1_IF1_DELAY, \
                EP1_IF1_LM,EP1_IF1_LMP], \
            [EP2,EP2_IP,EP2_IF1,EP2_IF1_BD,EP2_IF1_DELAY, \
                EP2_IF1_LM,EP2_IF1_LMP]]:

        print('----------------------------------')
        print('operation',operation,'on',e_if,'of entity',e,'with admin ip',e_ip)
        print('to: bandwidth',e_bd,'bps, delay',e_delay, \
            'ms, loss model',e_lm,', value',e_lmp)
        scenario = network_configure_link.build(
            e,
            e_if,
            'egress',
            operation,
            e_bd,
            int(e_delay),
            0,
            'normal',
            e_lm,
            e_lmp)
        observer.launch_and_wait(scenario)
        print('----------------------------------')

def qos_network_global(observer,server_entity,server_ip, \
        client_entity,client_ip):

    print('----------------------------------')
    print('qos_global between',server_entity,'and',client_entity)

    scenario = network_global.build(
            server_entity,
            client_entity,
            server_ip,
            client_ip,
            7001,
            7001,
            7000,
            30,
            '100M',
            1,
            0,
            1400,
            100,
            '0.1e',
            server_entity)
    observer.launch_and_wait(scenario)
    print('----------------------------------')

""" Main
"""

def main(argv=None):
    observer = ScenarioObserver()
    observer.add_scenario_argument(
            '--mode', required=True,
            help='Mode : "clear" to clear the interface;'
            '"apply" to apply the configuration"')
    observer.add_scenario_argument(
            '--test_qos', required=True,
            help='Run test global between specified entities'
            '(yes/no)')
    args = observer.parse(argv)

    set_clear_interfaces(observer,args.mode)
    if args.test_qos == "yes":
        print("run test qos_global")
        qos_network_global(observer,EP1,EP1_IF1_IP, \
                EP2,EP2_IF1_IP)
        qos_network_global(observer,EP2,EP2_IF1_IP, \
                EP1,EP1_IF1_IP)
    else:
        print("do not run test qos_global")

if __name__ == '__main__':
    main()

                                                                                 




