#! /bin/bash

#This script is going to be used to run bulk of the experiments on the physical machine.

EDGEFACTOR=16
REPO=$HOME/project
RESULTS=results/experiment
# Default value if OpenMP is on or not.
OMP=1
# BY default only use one node
NODES=1
RES=""
#get options still needs to be filled in
while getopts ":r:n:o:s:e:r:a:" opt; do
    case $opt in
        a)
            echo "-a was triggered, Parameter: $OPTARG" >&2
            ;;
        r)
            # The reservation number for the calculations
            RES="-reserve $OPTARG"
            ;;
        e)
            # The executable that should be used.
            EXE=$OPTARG
            ;;
        n)  
            NODES=$OPTARG
            ;;
        s)
            # The scale that will be for the project.
            SCALE=$OPTARG
            ;;
        o)
            OMP=$OPTARG
            ;;
        
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Experiments with different algorithms

# Experiments with different amount of nodes.

#Array of the nodes that will be used.
# NODES="1 2 4 8 16"
#NODES="1 2 4 8 16 32"

if [[ ! -d $REPO/$RESULTS ]]
then
    mkdir $REPO/$RESULTS
fi

for i in $NODES
do
  { time prun $RES -v -np $i -sge-script $PRUN_ETC/prun-openmpi `pwd`/$EXE $SCALE $EDGEFACTOR > $REPO/$RESULTS/"$i"nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$EXE".txt ; } 2>> $REPO/$RESULTS/1nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$EXE".time 
done
