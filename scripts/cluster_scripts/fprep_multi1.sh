#!/bin/sh
#SBATCH -J "3-96"
#SBATCH --mem=40G
#SBATCH -o multiple_sub.out -e multiple_sub.err

#User inputs:
bids_root_dir="/pasteur/appa/scratch/pbergere/RDB_func_clean"
direc="/pasteur/appa/scratch/pbergere/RDB_func_clean/sub*"
#nb Coeur CPU:
nthreads=32
mem=40 #gb
export FS_LICENSE="$HOME/license.txt"

mem=`echo "${mem//[!0-9]/}"` #remove gb at end
mem_mb=`echo $(((mem*1000)-5000))` #reduce some memory for buffer space during pre-processing

last_sub=0000   ### le code traitera les sujets dans l'ordre, entrez le dernier sujet traité
                ### pour ne pas tout recommencer
i=0
max=5         ### entrez le nombe de sujets à traiter



for j in $direc
do
  if (( $i<$max ));then
    sub=${j: -4}
    if (( 10#$sub>10#$last_sub ));then
      sleep 1m && srun --mem=40G fmriprep $bids_root_dir $bids_root_dir/derivatives \
      participant \
        --skip-bids-validation \
        --participant-label $sub \
        --md-only-boilerplate \
        --fs-license-file $HOME/license.txt \
        --output-spaces MNI152NLin2009cAsym:res-2 \
        --use-aroma \
        --nthreads $nthreads \
        --stop-on-first-crash \
        --mem_mb $mem_mb\
        -w /pasteur/appa/scratch/pbergere/sortie_fmriprep/single
        ((i=i+1))
    fi
  fi
done
exit 0
