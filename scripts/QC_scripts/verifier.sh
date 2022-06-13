#!/bin/bash

count_both=0
count_tfe=0


fold="$HOME/Documents/import/RDB_func_clean_tfe/sub*"
for i in $fold; do
image_tfe=0
image_iso=0
for z in {1..4} ### nombre de sessions à check, ici on pose qu'il y a 4 sessions au maximum
do
direc="$i/ses-0$z/anat/sub*.nii.gz" ### pensez à mettre votre propre directory
  for j in $direc
  do
    if [[ $j = *"tfe"* ]];then
      ((image_tfe=image_tfe+1))
    elif [[ $j = *"isotrope"* ]];then
      ((image_iso=image_iso+1))
    fi
  done
done
if [[ $image_iso != 0 && $image_tfe != 0 ]];then
  ((count_both++))
  a=1
elif [[ $image_iso != 0 ]];then
  echo "sujet : $i n'a que iso"
  a=1
elif [[ $image_tfe != 0 ]];then
  ((count_tfe++))
  a=1
elif [[ $image_iso = 0 && $image_tfe = 0 ]];then
  echo "sujet : $i n'a pas d'anat"
fi
done
echo "nb sujet avec deux types:$count_both"
echo "nb sujet avec juste tfe:$count_tfe"
