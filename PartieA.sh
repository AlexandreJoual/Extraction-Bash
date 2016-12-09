#!/bin/bash


echo "Num_Acc;an;mois;jour;lum;atm;com;dep;adr;lat;long;liblim;libatm;libDept;libComm"  > extrait_caracteristiques_complete.csv
tail -n +2 newcaract2015.csv | awk -F ";" '{ 
	tablum[0]="Aucune donnée disponible"
	tablum[1]="Plein jour"
	tablum[2]="Crépuscule ou aube"
	tablum[3]="Nuit sans éclairage public"
	tablum[4]="Nuit avec éclairage public non allumé"
	tablum[5]="Nuit avec éclairage public allumé"
	tabatm[0]="Aucune donnée disponible"
	tabatm[1]="Normale"
	tabatm[2]="Pluie légère"
	tabatm[3]="Pluie forte"
	tabatm[4]="Neige - Grêle"
	tabatm[5]="Brouillard - fumée"
	tabatm[6]="Vent fort - tempête"
	tabatm[7]="Temps éblouissant"
	tabatm[8]="Temps couvert"
	tabatm[9]="Autre"
	liblum = $6=="" ? tablum[0] : tablum[$6]
	libatm = $9=="" ? tabatm[0] : tabatm[$9]
	dep = substr( $16 ,1,2)
	unixb="grep \\;"dep"\\; depts2015.csv | cut -d\\; -f5" 
	unixb | getline dept
	close(unixb)
	unixa="grep \\;"dep"\\;"$11"\\; communes2015.csv | cut -d\\; -f10"
	unixa | getline commune
	close(unixa)

	print $1";"$2";"$3";"$4";"$6";"$9";"$11";"$16";"$12";"$14";"$15";"liblum";"libatm";"dept";"commune
}' >> extrait_caracteristiques_complete.csv

exit 0 