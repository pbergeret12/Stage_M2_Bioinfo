#!/bin/bash
#Template provided by Daniel Levitas of Indiana University
#Edits by Andrew Jahn, University of Michigan, 07.22.2020

#export PATH="$HOME/.local/bin:$PATH" : à runner dans le terminal pour faire fonctionner fmriprep-docker sur ubuntu
#attention, le sudo peut bloquer fmriprep-docker, ajoutez votre utilisateur au groupe docker pour contourner ce problème.

#User inputs:
bids_root_dir="$HOME/Documents/import/RDB_func_clean"
#nb Coeur CPU:
nthreads=16
mem=20 #gb
container=docker #docker or singularity

#Begin:

#Convert virtual memory from gb to mb
mem=`echo "${mem//[!0-9]/}"` #remove gb at end
mem_mb=`echo $(((mem*1000)-5000))` #reduce some memory for buffer space during pre-processing

#export TEMPLATEFLOW_HOME=$HOME/.cache/templateflow
export FS_LICENSE="$HOME/Documents/fmriprep/license.txt"

i=0185
subj=$i

#Run fmriprep
if [ $container == singularity ]; then ### pas de singularity on utilise docker, cette partie n'est pas executée
  unset PYTHONPATH; singularity run -B $HOME/.cache/templateflow:/opt/templateflow $HOME/fmriprep.simg \
    $bids_root_dir $bids_root_dir/derivatives \
    participant \
    --participant-label $subj \
    --skip-bids-validation \
    --md-only-boilerplate \
    --fs-license-file $HOME/Desktop/Flanker/derivatives/license.txt \
    --fs-no-reconall \
    --output-spaces MNI152NLin2009cAsym:res-2 \
    --nthreads $nthreads \
    --stop-on-first-crash \
    --mem_mb $mem_mb \
    -w /home/pierre/Documents/sortie_fmriprep
else
  fmriprep-docker $bids_root_dir $bids_root_dir/derivatives \
    participant \
    --skip-bids-validation \
    --participant-label $subj \
    --md-only-boilerplate \
    --fs-license-file $HOME/Documents/fmriprepe/license.txt \
    --output-spaces MNI152NLin2009cAsym:res-2 \
    --use-aroma \
    --nthreads $nthreads \
    --stop-on-first-crash \
    --mem_mb $mem_mb\
    -w ~/Documents/sortie_fmriprep
fi
