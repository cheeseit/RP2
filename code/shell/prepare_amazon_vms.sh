#! /bin/bash
HOSTS=$(cat hosts)
FIRST=$(head -1 hosts)
for i in $HOSTS
do
  tmp=$(echo $i | cut -c 6-)
  ssh -oStrictHostKeyChecking=no $i "cd project; git pull" &> /dev/null
  ssh -oStrictHostKeyChecking=no $i "cd project/code/graph500/mpi;make clean; make" &> /dev/null
 # ssh $i "cd project; git pull"
 # ssh $i "cd project/code/graph500/mpi;make clean; make"
  ssh -oStrictHostKeyChecking=no $FIRST "ssh-keyscan -t rsa,dsa $tmp 2>&1 >> ~/.ssh/known_hosts;"
done
scp hosts $FIRST:/root
