#!/bin/bash

# Author: Costin GALAN | cgalan@cloudbasesolutions.com
# License: Apache V2.0
# Description: Help script

listing=$(ls ~/solutii_pt_costin)
git clone https://github.com/alexandrucoman/python-lab ~/work/Cloudbase/script/python-lab
cd ~/work/Cloudbase/script/python-lab
git remote remove origin
git remote add origin https://github.com/IngridSt/python-lab
git remote add alex https://github.com/alexandrucoman/python-lab
git checkout -b python_lab
mkdir -p solutii/IngridSt
cd solutii/IngridSt
for script in $listing;
do
    cp ~/solutii_pt_costin/$script ~/work/Cloudbase/script/python-lab/solutii/IngridSt/
    git add $script
    git commit -m "Adaugat solutie pentru $script"
done
git log
