#!/bin/bash

while true; do
direc="/home/pierre/Documents/RDB_data/sub-0001/ses-01/anat/sub-0001_ses-01_acq-isotrope_T1w.nii.gz"
read -rsn1 input
if [ "$input" = "a" ]; then
    xdg-open $direc
fi
done
