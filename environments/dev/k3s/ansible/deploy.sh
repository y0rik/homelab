#!/bin/bash
# the script calls for DEPLOY/REBOOT/RESET playbook 
#   with proper 'roles' location in ANSIBLE_ROLES_PATH var

# define roles' location
up_dirs=4 # define how far UP 'ans_roles' folder is
roles_subpath="/ans_roles/k3s" # relative path from UPped folder

dir_name=`dirname $0`
script_name=`basename $0`

pushd $dir_name >> /dev/null
ANSIBLE_ROLES_PATH=`pwd | sed -E "s=(\/[^\/]{1,}){$up_dirs}$=$roles_subpath=g"`
export ANSIBLE_ROLES_PATH 

ansible-playbook `echo $script_name | sed 's/.sh/.yml/g'`

popd >> /dev/null