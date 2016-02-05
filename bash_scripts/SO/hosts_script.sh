#!/bin/bash

# Sa se crie un script care prelucreaza un fisier cu extensia .csv (comma-
# separated values) primit ca argument in linia de comanda. Fisierul contine, pe
# coloane, urmatoarele informatii: adresa ip, adresa MAC, nume computer,
# comentarii.
# Exemplu linie fisier .csv:
#   a.b.c.d,aabbccddeeff,computer_x,sala_x
# Pentru fiecare linie din fisierul initial, scriptul va scrie intr-un fisier de iesire (al
# doilea argument din linia de comanda) o intrare de forma urmatoare:
#   host computer_x {
#   option host-name "computer_x";
#   hardware ethernet AA:BB:CC:DD:EE:FF;
#   fixed-address a.b.c.d;
#   }
# Exemplu de rulare:
#   ./<nume_script>
#   <fisier_intrare>.csv
#   <fisier_iesire>.txt
#   Pentru conversia aabbcddeef in aa:bb:cc:dd:ee:ff se poate folosi comanda:
#     echo aabbccddeeff |sed 's/\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)/\1:\2:\3:\4:\5:\6/g'
#     sau
#     for i in `seq 0 2 10`; do echo aabbccddeeff |cut -b $((i+1))-$((i+2)) ; done

printMessage () {
  echo -e '\t' host "$3" '{'
  echo "option host-name $3"
  echo "hardware ethernet ""$2" | sed 's/\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)\(\w\w\)/\1:\2:\3:\4:\5:\6/g'";"
  echo "fixed-address $1;"
  echo "}"
}

ip=( $(cut -d ',' -f1 "$1") )
mac=( $(cut -d ',' -f2 "$1") )
name=( $(cut -d ',' -f3 "$1") )
obs=( $(cut -d ',' -f4 "$1") )


len=${#ip[@]}
for (( i=0; i<"${len}"; i++ ));
do
  printMessage ${ip[i]} ${mac[i]} ${name[i]} >> "$2"
done
