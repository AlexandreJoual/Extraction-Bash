#!/bin/bash
# ce script prends 15 minutes.
#il doit exister un moyen d'optimiser les recherches INSEE
# les formats des donnees communes et departement rends possible le grep direct
# si il y avait eu des suites de chiffres identiques, il aurait fallut faire
# cut | grep | cut pour commencer par le numéro de département.
#
# si on ne fait pas le close de unixa et unixb, les commandes restent ouvertes et plantent le script.

echo "Num_Acc;an;mois;jour;lum;atm;com;dep;adr;lat;long;liblim;libatm;libDept;libComm"  > $2
tail -n +2 $1 | awk -F ";" '{ 
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
	unixb="grep \\;"dep"\\; ./fichiers/depts2015.csv | cut -d\\; -f5" 
	unixb | getline dept
	close(unixb)
	unixa="grep \\;"dep"\\;"$11"\\; ./fichiers/communes2015.csv | cut -d\\; -f10"
	unixa | getline commune
	close(unixa)

	print $1";"$2";"$3";"$4";"$6";"$9";"$11";"$16";"$12";"$14";"$15";"liblum";"libatm";"dept";"commune
}' >> $2
