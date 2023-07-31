#!/bin/zsh
for i in {001..809}
do 
    echo "- assets/images/sprites/"$i"MS.png" >> /Users/kribas/Documents/pokapp/to_add
    #wget "https://assets.pokemon.com/assets/cms2/img/pokedex/full/$i.png" -O "assets/images/dex/$i.png"
    #sleep 8
done
