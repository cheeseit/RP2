#! /bin/bash


#first have to wait till scp is available
HOSTS=$(cat hosts)
for i in $HOSTS
do
	scp hosts root@$p:/root &> /dev/null
  ssh root@$p "cd project; git pull" &> /dev/null
  ssh root@$p "cd project/code/graph500/mpi;make clean; make" &> /dev/null
done


