#!/bin/bash


direc="/pasteur/appa/scratch/pbergere/RDB_func_clean_tfe/sub*" ### pensez à mettre votre propre directory

last_sub=0000   ### le code exportera les numéros des sujets dans l'ordre a partir de ce numéro,
                ### pour qu'ils soient traités dans fprep_multi en parallèle.
i=0
max=16          ### entrez le nombe de sujets à traiter

for j in $direc
do
  if (( $i < $max));then
    sub=${j: -4}
    if (( "10#$sub>10#$last_sub" ));then
      export sub
      sbatch -J $sub fprep_multi.sh
      sleep 1m
      ((i=i+1))
    fi
  fi
done
