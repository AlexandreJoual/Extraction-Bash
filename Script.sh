#!/bin/bash

# se positionner dans C et lancer :
#./Script.sh ./fichiers/caracteristiques2015.csv ./fichiers/usagers_2015.csv ./results/extraitcarac.csv  ./results/extraitusag.csv ./results/COMPILE.csv

# Verification des parametres
if [ $# -lt 5 ]; then
        echo "Syntaxe: Script.sh  [ficCaracteristiques] [ficUsagers] [extraitCaracteristique] [extraitUsagers] [FichierFinal] "
        echo "ficCaracteristiques : Repertoire et nom fichier caracteristiques"
		echo "ficUsagers : Repertoire et nom fichier usagers"  
		echo "extraitCaracteristique : Repertoire et nom fichier caracteristiques temporaire"  
		echo "extraitUsagers : Repertoire et nom fichier usagers temporaire"  
        echo "FichierFinal : Repertoire et nom fichier compilé"
        
        exit 1
fi

echo "Lancement des deux scripts en parallele... "
# lancement des deux scripts en parallele (ils sont dans le meme dossier que script) puis attendre avant de lancer le join
./traitementCaracteristiques.sh $1 $3 &
./traitementUsagers.sh $2 $4 &
wait

echo "le premier traitement est enfin terminé, on compile les resultats"
# lancement du join
 join -t";" $2 $4 > $5

#Message fin d'exécution 
echo "Fin de traitement"