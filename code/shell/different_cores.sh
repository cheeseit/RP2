#! /bin/bash

#This script is going to be used to run bulk of the experiments on the physical machine.

EDGEFACTOR=16
REPO=$HOME/project
RESULTS=results/experiment
# Default value if OpenMP is on or not.
OMP=1
#get options still needs to be filled in
while getopts ":c:o:s:e:r:a:" opt; do
    case $opt in
        a)
            echo "-a was triggered, Parameter: $OPTARG" >&2
            ;;
        r)
            # The reservation number for the calculations
            RES=$OPTARG
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
CPU="1 2 4 8 "


if [[ ! -d $REPO/$RESULTS ]]
then
    mkdir $REPO/$RESULTS
fi
for c in $CPU
do
  for i in {1...3}
  do
      echo "prun -reserve $RES -v -np $i -sge-script $PRUN_ETC/prun-openmpi `pwd`/$EXE $SCALE $EDGEFACTOR $CPU> $REPO/$RESULTS/"$i"nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$EXE".txt"

      time prun -reserve $RES -v -np $i -sge-script $PRUN_ETC/prun-openmpi `pwd`/$EXE $SCALE $EDGEFACTOR $c> $REPO/$RESULTS/"$i"nodes_"$SCALE"scale_"$EDGEFACTOR"edge_"$OMP"omp_"$CPU"cpu_"$EXE"$i.txt
  done
done
