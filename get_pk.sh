#!/bin/bash
for i in {758..1010}
do 
    echo "Downloading $i";
    wget "https://assets.pokemon.com/assets/cms2/img/pokedex/full/$i.png" -O "assets/images/dex/$i.png"
    sleep 8
done
