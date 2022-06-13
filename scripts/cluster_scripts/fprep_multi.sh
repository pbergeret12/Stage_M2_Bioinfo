#!/bin/sh
#SBATCH --mem=20G
#SBATCH -c 16
#SBATCH --qos ghfc
#SBATCH -p ghfc
#SBATCH -o %x.out -e %x.err

#User inputs:
bids_root_dir="/pasteur/appa/scratch/pbergere/RDB_func_clean_tfe"
#nb Coeur CPU:
nthreads=16
mem=20 #gb
export FS_LICENSE="$HOME/license.txt"

mem=`echo "${mem//[!0-9]/}"` #remove gb at end
mem_mb=`echo $(((mem*1000)-5000))` #reduce some memory for buffer space during pre-processing

srun fmriprep $bids_root_dir $bids_root_dir/derivatives \
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
