#!/bin/bash

# 8.1. Scrieti un script care sa va ajute la scrierea programelor in C, care sa
# automatizeze ciclul: modificare-sursa -> compilare -> testare(executie). Scriptul trebuie se
# afiseze un meniu cu o serie de optiuni pentru utilizator. Pentru fiecare optiune trebuie
# scrisa o functie ( toate functiile trebuie scrise intr-un singur fisier).
# Optiuni meniu:
#   a) sa lanseze editorul de texte pentru fisierul fisier.c specificat ca parametru
# sau cerut de la linia de comanda;
#   b) sa lanseze compilatorul (fisierul executabil sa aiba numele fisier , deci fara
# sufixul .c); daca sunt erori de compilare (lucru observabil prin erorile de compilare afisate
# de compilator) sau warning-uri si sa le salveze intr-un fisier (fisier.err); fisierul de erori
# si executabilul se sterg la fiecare compilare;
#   c) sa afiseze continutul fisierului fisier.err daca sunt erori (exista fisierul si are
# dimensiunea > 0);
#   d) sa lanseze in executie programul ( afisare mesaj de eroare daca nu exista
# executabilul);
#   e) iesire din script.

if [[ $# -lt 1 ]]; then
	echo "Incorrect program usage. Try $0 filename.c"
	exit 1
fi

opt=3

while [ $opt -ne 5 ]
do

	echo Menu:
	echo -e '\t' 1-Edit "$1"
	echo -e '\t' 2-Compile  "$1"
	echo -e '\t' 3-Display errors 
	echo -e '\t' 4-Run program
	echo -e '\t' 5-Exit script

	read -p 'Option: ' opt

	case $opt in 
		1) 
echo "Editing $1"
vim "$1"
chmod +x "$1"
;; 
2)
echo "Compiling $1"
file_name="${1//.*/.c}"
cp "$1" "$file_name"
if gcc "$file_name" -o "$file_name.out"; then
	echo "$file_name" "has been compiled with no errrors"
else
	gcc 2> fisier.err
	echo "Compilation failed - check fisier.err for details"
fi
;;
3)
if [[ ! -f fisier.err ]]; then
	echo "There is no fisier.err. Have you tried compiling it?"
else
	echo 'Error log: '
	vim fisier.err
fi
;; 
4)
file_name="${1//.*/.c}"
cp "$1" "$file_name"
if gcc "$file_name" -o "$file_name.out"; then
	if find -name "$file_name.out"; then
		./"$file_name.out" 
	else
		echo "$file_name" "not found"
	fi
fi
;;
5)
echo Exit Script
;; 
*)
echo Invalid option
;;
esac 
done
