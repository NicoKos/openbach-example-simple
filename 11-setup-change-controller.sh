#!/bin/bash

controllername=$1

cp $controllername ../openbach-extra/apis/auditorium_scripts/controller
cp $controllername ../openbach-extra/executors/examples/controller
cp $controllername ../openbach-extra/executors/references/controller

