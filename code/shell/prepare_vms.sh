#! /bin/bash


#first have to wait till scp is available
HOSTS=$(cat hosts)
for i in $HOSTS
do
  ssh $i "cd project; git pull" &> /dev/null
  ssh $i "cd project/code/graph500/mpi;make clean; make" &> /dev/null
done


