#!/bin/bash

#6.3. Sa se scrie un fisier de comenzi care permite cautarea unui fisier in intreaga
#structura a unui subdirector. Fisierul cautat este transmis ca argument in linia de co-
#manda. Se utilizeaza comanda find.


if [[ $# -lt 2 ]]; then
	echo "Not enough arguments"
  echo "Usage: $0 file location"
	exit 1;
fi

#cd $2
echo "Searching for $1 in: $2 "
echo "Results: "
find "$2" -name "$1"
