#!/bin/bash


direc="$HOME/Documents/import/RDB_func_clean/sub*" ### pensez à mettre votre propre directory

last_sub=0184   ### le code exportera les sujets dans l'ordre a partir de ce numéro,
                ### pour qu'ils soient traités dans fprep_multi en parallèle.
i=0
max=5          ### entrez le nombe de sujets à traiter

for j in $direc
do
  if (( $i < $max));then
    sub=${j: -4}
    if (( "10#$sub>10#$last_sub" ));then
      export sub
      bash test.sh
      ((i=i+1))
    fi
  fi
done
