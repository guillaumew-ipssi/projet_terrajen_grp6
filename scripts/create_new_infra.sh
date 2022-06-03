#!/bin/bash

cd ..

if [ -d "INFRASTRUCTURE" ]; then
    cd INFRASTRUCTURE
    max=0;
    for x in * ; do 
        n=${x##*/};
        [ "$n" -gt "$max" ] && max=$n 
    done

    id_new_infra=$(($max+1))
    mkdir ${id_new_infra}

    echo "Your client ID is $id_new_infra, don't forget this !"
else
    mkdir INFRASTRUCTURE
    cd INFRASTRUCTURE
    mkdir 1
    echo "Your client ID is 1, don't forget this !"
fi