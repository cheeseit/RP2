#! /bin/bash

#This script is going to be used to run bulk of the experiments on the physical machine.

EDGEFACTOR=16
REPO=$HOME/project
RESULTS=results/experiment
MPI=$HOME/project/code/graph500/mpi
# Default value if OpenMP is on or not.
OMP=1
RES=""
ITERATIONS=1
#get options still needs to be filled in
while getopts ":t:c:o:s:e:r:a:" opt; do
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
        s)
            # The scale that will be for the project.
            SCALE=$OPTARG
            ;;
        o)
            OMP=$OPTARG
            ;;
        t) 
            ITERATIONS=$OPTARG
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
#NODES="1 2 4 8 16"
#NODES="1 2 4 8 16 32"
CPU="1 2 4 8"


if [[ ! -d $REPO/$RESULTS ]]
then
    mkdir $REPO/$RESULTS
fi
for c in $CPU
do
    for i in $(seq 1 $ITERATIONS)
  do
    { time prun -v -np 1 -sge-script mpi_host_script $MPI/$EXE $SCALE $EDGEFACTOR $c &> $REPO/$RESULTS/1nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$c"cpu_"$EXE"$i.txt ; } 2>> $REPO/$RESULTS/1nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$c"cpu_"$EXE".time 
  done
done
