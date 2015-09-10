#!/bin/bash

#8.2. Sa se scrie un script care modifica caracterele dintr-un fisier (numele fisierelor
# sursa si destinatie sunt parametri in linia de comanda) transformand caracterele litere mici
# in litere mari ( se foloseste comanda tr). Scriptul trebuie sa verifice daca exista
# argumente trimise din linia de comanda. Daca exista doar un argument, rezultatul
# conversiei este afisat pe ecran.
# Exemplu de rulare:
#     ./script fisier1 fiser2
#   sau
#     ./script fisier

if [[ $# -eq 2 ]];
then
  for line in $(cat "$1")
  do
    tr '[:lower:]' '[:upper:]' <<< "$line" >> "$2"
  done
  exit "$?";
fi

if [[ $# -eq 1 ]];
then
  for line in $(cat "$1")
  do
    tr '[:lower:]' '[:upper:]' <<< "$line"
  done
  exit "$?"
fi

echo "Usage: $0 file_source [file_destionation]"

