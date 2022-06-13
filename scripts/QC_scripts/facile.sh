#!/bin/bash

echo appuyez sur une touche pour ouvrir le premier sujet, noubliez pas de préciser duquel il sagit dans le script

for i in {0895..1558}; do ###remplacez 0001 par le numéro de votre sujet de départ
sujet=$i
read -rsn1 input ### commande attendant la pression d'une touche
for z in {1..4} ### nombre de sessions à check, ici on pose qu'il y a 4 sessions au maximum
do
direc="$HOME/Documents/RDB_data/sub-$sujet/ses-0$z/anat/sub*.nii.gz" ### pensez à mettre votre propre directory
  for j in $direc
  do
    if [[ $j == *"tfe"* ]];then
      echo appuyez sur une touche pour ouvrir: SUJET $sujet, SESSION "0$z", ACQUISITION TFE
      read -rsn1 input
      xdg-open $j ### commande d'ouverture, peut être fausse sur mac
    elif [[ $j == *"isotrope"* ]];then
      echo appuyez sur une touche pour ouvrir: SUJET $sujet, SESSION "0$z", ACQUISITION ISOTROPE
      read -rsn1 input
      xdg-open $j
    fi
  done
done
echo appuyez sur une touche pour passer au sujet suivant
done
