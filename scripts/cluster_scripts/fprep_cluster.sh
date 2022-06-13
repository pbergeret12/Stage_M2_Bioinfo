#!/bin/sh
#SBATCH -J "subject_184_fmriprep"
#SBATCH --mem=40G
#SBATCH -o sub_184.out -e sub_184.err

#User inputs:
bids_root_dir="$HOME/RDB_func_clean"
#nb Coeur CPU:
nthreads=32
mem=40 #gb


mem=`echo "${mem//[!0-9]/}"` #remove gb at end
mem_mb=`echo $(((mem*1000)-5000))` #reduce some memory for buffer space during pre-processing
i=0184
subj=$i



export FS_LICENSE="$HOME/license.txt"

srun --mem=40G fmriprep $bids_root_dir $bids_root_dir/derivatives \
participant \
  --skip-bids-validation \
  --participant-label $subj \
  --md-only-boilerplate \
  --fs-license-file $HOME/license.txt \
  --output-spaces MNI152NLin2009cAsym:res-2 \
  --use-aroma \
  --nthreads $nthreads \
  --stop-on-first-crash \
  --mem_mb $mem_mb\
  -w $HOME/sortie_fmriprep/single

exit 0
