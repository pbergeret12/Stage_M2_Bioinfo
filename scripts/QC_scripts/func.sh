#!/bin/bash

count=0
suj=0
na=0
for i in {0001..1558}; do ###remplacez 0001 par le numéro de votre sujet de départ
image=0
for z in {1..9} ### nombre de sessions à check, ici on pose qu'il y a 4 sessions au maximum
do
direc="$HOME/Documents/RDB_func_clean/sub-$i/ses-0$z/func/sub*.nii.gz" ### pensez à mettre votre propre directory
  for j in $direc
  do
    if [[ $j == *"task"* ]];then
      echo $j
      ((count=count+1))
      ((image=image+1))
    fi
  done
done
if [[ $image == 0 ]];then
  rm -r $HOME/Documents/RDB_data_clean/sub-$i
  echo sujet $i suprimé
  ((na=na+1))
elif [[ $image != 0 ]];then
  echo les images de $i sont dispo
  ((suj=suj+1))
fi
done
echo "$count images en tout pour $suj sujet"
echo "$na sujet n'ont pas de func ET SUPPRIME"
