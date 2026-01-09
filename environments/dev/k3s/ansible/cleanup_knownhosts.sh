#!/bin/bash
# script removes hosts from known_hosts file

for i in $(cat ./inventory/my-cluster/hosts.ini | egrep -i '([0-9]{1,3}\.){3}[0-9]{1,3}$'); do ssh-keygen -R "$i"; done