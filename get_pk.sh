#!/bin/zsh
for i in {011..151}
do 
    echo "Downloading $i";
    wget "https://assets.pokemon.com/assets/cms2/img/pokedex/full/$i.png" -O "assets/images/$i.png"
    sleep 5
done