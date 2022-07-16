#!/bin/bash

snmpd -LS0-6d

sed -i "s/.*cpus_allowed_list.*/cpus_allowed_list=$(cat /sys/fs/cgroup/cpuset/cpuset.cpus)/"  /opt/dolby/etc/dvcs_global.cfg

monit start all

while [[ ! -e /var/run/dvcs_stopped ]]
do
    sleep 30
done
