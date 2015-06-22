#! /bin/bash
HOSTS=$(cat hosts)
FIRST=$(head -1 hosts)
for i in $HOSTS
do
  tmp=$(echo $i | cut -c 6-)
  ssh $i "cd project; git pull" &> /dev/null
  ssh $i "cd project/code/graph500/mpi;make clean; make" &> /dev/null
 # ssh $i "cd project; git pull"
 # ssh $i "cd project/code/graph500/mpi;make clean; make"
  ssh $FIRST "ssh-keyscan -t rsa,dsa $tmp 2>&1 >> ~/.ssh/known_hosts;"
  scp hosts $FIRST:/root
done
