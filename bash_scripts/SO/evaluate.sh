#!/bin/bash

#6.1. Folosind comanda eval sa se scrie un program, care afiseaza argumentele din
#linia de comanda in ordine inversa. Se considera cazul in care programul primeste
#cel mult 9 argumente in linia de comanda.

if [[ "$#" -gt 9 ]]; then
   echo "Too many arguments"
   exit 1
fi

for i in $(seq $# -1 1); do
   eval "echo \$$i"
done
