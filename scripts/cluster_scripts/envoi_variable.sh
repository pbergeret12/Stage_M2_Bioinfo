#!/bin/bash

for a in {0001..0010}
do

i=$a

export i

bash prendre_variable.sh
done
