#!/bin/bash

count_both=0
count_tfe=0


fold="$HOME/Documents/import/RDB_func_clean_clone/sub*"
for i in $fold; do
image_tfe=0
image_iso=0
for z in {1..4} ### nombre de sessions à check, ici on pose qu'il y a 4 sessions au maximum
do
direc="$i/ses-0$z" ### pensez à mettre votre propre directory
  for j in $direc
  do
    if [[ $j == *"ses"* ]];then
      rmdir $j
    fi
  done
done
done
