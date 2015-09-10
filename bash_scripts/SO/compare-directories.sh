#!/bin/bash

#6.2. Sa se scrie un fisier de comenzi, care verifica daca doua directoare sunt egale.
#Numele celor doua directoare se transmit ca argumente in linia de comanda. Doua
#directoare se considera ca sunt egale daca contin aceleasi subdirectoare si fisiere.
#Se utilizeaza comanda diff.

if [[ "$#" -lt 2 ]]
then
  echo "The two directories are not transmitted.";
  exit '1';
fi

[[ ! -d "$1"  ]] && echo "$1 is not a directory" && exit 1;
[[ ! -d "$2"  ]] && echo "$2 is not a directory" && exit 1;

d=$(diff -r "$1" "$2")

[[ $d -eq 1 ]] && echo "The directories are different" 
[[ $d -eq 0 ]] && echo "The directories are the same"
