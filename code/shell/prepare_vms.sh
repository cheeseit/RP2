#! /bin/bash


#first have to wait till scp is available
while read p
do
	scp hosts root@$p:/root
  ssh root@$p "cd project; git pull"
  ssh root@$p "cd project/code/graph500/mpi; make"
done < hosts


