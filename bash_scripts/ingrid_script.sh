#!/bin/bash

# Author: Costin GALAN | cgalan@cloudbasesolutions.com
# License: Apache V2.0
# Description: Help script

targetDir=~"/work/Cloudbase/script/python-lab"
git clone https://github.com/alexandrucoman/python-lab $targetDir
cd ~/work/Cloudbase/script/python-lab || echo "L9: Failed to change directory"
git remote remove origin
git remote add origin https://github.com/IngridSt/python-lab
git remote add alex https://github.com/alexandrucoman/python-lab
git checkout -b python_lab
mkdir -p solutii/IngridSt
cd solutii/IngridSt || echo "ERROR: L15: Failed to change directory"
for script in ~/solutii_pt_costin/*; do
    cp ~/solutii_pt_costin/"$script" $targetDir/solutii/IngridSt/
    git add "$script"
    git commit -m "Adaugat solutie pentru $script"
done
git log
