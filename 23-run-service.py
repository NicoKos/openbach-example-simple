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
from auditorium_scripts.start_job_instance import StartJobInstance
from scenario_builder.scenarios import service_web_browsing



""" Global parameters
"""


###########################################################
# Admin sys
###########################################################
# ENDPOINT 1
EP1="nuc1"
EP1_IP="192.168.1.41"
EP1_IF1_IP="10.10.0.1"

# ENDPOINT 2
EP2="nuc2"
EP2_IP="192.168.1.42"
EP2_IF1_IP="10.10.0.2"

""" start the apache server
"""

def start_apache_server(observer,server_admin_ip):

    print('----------------------------------')
    print('start apache server on',server_admin_ip)

    start_server = observer._share_state(StartJobInstance)
    start_server.args.agent = server_admin_ip
    start_server.args.name = 'apache2'
    start_server.args.argument = ''
    start_server.args.interval = 5
    start_server.execute()

    print('----------------------------------')

""" web browsing using http1
"""

def webbrowse_using_ref_scenario(observer,server_entity,client_entity):

    print('----------------------------------')
    print('webbrowse using web_browsing reference scenario')
    scenario = service_web_browsing.build(
            server_entity,
            client_entity,
            0,
            1,
            1,
            True,
            #'proxy.star',
            #3128,
            launch_server=False,
            post_processing_entity=client_entity)
    observer.launch_and_wait(scenario)
    print('----------------------------------')

""" Main
"""

def main(argv=None):
    observer = ScenarioObserver()
    args = observer.parse(argv)

    # start apache2 server
    start_apache_server(observer,EP1_IP)
    start_apache_server(observer,EP2_IP)
    # start web browsing
    #webbrowse_using_ref_scenario(observer,EP1,EP2)
    #webbrowse_using_ref_scenario(observer,EP2,EP1))
    # start video transfer


if __name__ == '__main__':
    main()


