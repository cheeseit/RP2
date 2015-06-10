#! /bin/bash

#this script create multiple instances of the same image
# looks at the ids and does a git pull for all of them
# and does a git pull. Then it will also create a host file
# and scp it to all all the hosts.


MACHINES=""

#get options still needs to be filled in
while getopts "m:f:" opt; do
    case $opt in
        m)
            # The reservation number for the calculations
            MACHINES="-m $OPTARG"
            ;;
        f)  # The template file for the virtual machine
            FILE="$OPTARG"
    esac
done
# make multiple machines and get the ids
ID=$(onevm create $MACHINES $FILE | cut -d ":" -f 2)

# get ipaddress of each machine
for i in $ID
do
    $(onevm show $i | grep "ip address"| cut -d ":" -f 2 >> hosts)
done
