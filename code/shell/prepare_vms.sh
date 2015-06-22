#! /bin/bash

KEY=""

#first have to wait till scp is available
if [[ $# -ge 1 ]]
then
  KEY="-i $1"
fi

HOSTS=$(cat hosts)
for i in $HOSTS
do
  ssh $i $KEY "cd project; git pull" &> /dev/null
  ssh $i $KEY "cd project/code/graph500/mpi;make clean; make" &> /dev/null
done


