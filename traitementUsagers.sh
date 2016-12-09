#!/bin/bash
#set -x
NOMFIC=$1
echo "Num_Acc;indemnes;tues;hospi;legers;femmes;hommes;domtra;domeco;courach;utilpro;proloi;autres;age_moyen;age_min;age_max" > $2
for i in $(tail -n +2 $NOMFIC | cut -d ',' -f1 | sort -u)
do
	# gravite
	gravites[1]=0; gravites[2]=0; gravites[3]=0; gravites[4]=0
	for j in $(grep $i $NOMFIC | cut -d ',' -f4)
	do
		let gravites[$j]++
	done

	# sexe
	sexes[1]=0; sexes[2]=0
        for j in $(grep $i $NOMFIC | cut -d ',' -f5)
        do
                let sexes[$j]++
        done

	# trajets
	for ((j=0; j<10; j++))
	do
		trajets[$j]=0
	done

        for j in $(grep $i $NOMFIC | cut -d ',' -f6)
        do
                let trajets[$j]++
        done

	# moyenne age
	currentYear=$(date +"%Y")
	annees=$(grep $i $NOMFIC | cut -d ',' -f11)
	somme=0
	for j in $annees
	do
		let "somme=$somme+ $currentYear - $j"
	done
	nbannees=$(echo $annees | wc -w)
	let "moyenne=$somme / $nbannees"

	# age min/max
	min=0 ; max=0
	for j in $annees
	do
    		(( $j > max || max == 0)) && max=$j
    		(( $j < min || min == 0)) && min=$j
	done
	let "agemin=$currentYear - $max"
	let "agemax=$currentYear - $min"

	echo "$i;${gravites[1]};${gravites[2]};${gravites[3]};${gravites[4]};${sexes[2]};${sexes[1]};${trajets[1]};${trajets[2]};${trajets[3]};${trajets[4]};${trajets[5]};${trajets[9]};$moyenne;$agemin;$agemax" >> $2

#break

done

