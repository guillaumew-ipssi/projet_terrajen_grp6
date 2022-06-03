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
    id_new_infra=1
    mkdir $id_new_infra
    echo "Your client ID is $id_new_infra, don't forget this !"
fi

cp -R ../0* ${id_new_infra}
cp ../flow_matrix.csv ${id_new_infra}