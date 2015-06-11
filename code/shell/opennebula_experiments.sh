##! /bin/bash

#This script is going to be used to run bulk of the experiments on the physical machine.

EDGEFACTOR=16
REPO=$HOME/project
RESULTS=results/experiment
MPI=$HOME/project/code/graph500/mpi
# Default value if OpenMP is on or not.
OMP=1
# BY default only use one node
NODES=1
RES=""
#get options still needs to be filled in
while getopts ":e:r" opt; do
    case $opt in
        
    esac
done

