#!/bin/bash

# Author: cgalan@cloudbasesolutions.com
# Version: 1.0
# License: Apache V2.0
# Description: Create statistics for nova for a specific date. 


if [[ $# -lt 1 ]]; then
  echo "Example usage: $0 22/09/2015"
  exit 1;
fi


LOGS_FILE=/home/jenkins-slave/nova-statistics.log

function send_mail {
  echo "Sending mail"
  mail -s "Nova stats - $(date +%x)" "cgalan@cloudbasesolutions.com" < mail.txt 
  #mail -s "Nova stats -$(date +%x)" "vlaza@cloudbasesolutions.com" < mail.txt 
  #mail -s "Nova stats -$(date +%x)" "ociuhandu@cloudbasesolutions.com" < mail.txt 
  #mail -s "Nova stats -$(date +%x)" "abacoscloudbasesolutions.com" < mail.txt 
  #mail -s "Nova stats -$(date +%x)" "rbuzatu@cloudbasesolutions.com" < mail.txt 
}

# Uncomment get_statistics function if you want to use this script remote.
#

#function get_statistics {
#  [[ -e "$LOGS_FILE" ]] && rm $LOGS_FILE || echo "You don't have the file"
#  echo "Getting the statistics file"
#  rsync -avzq root@10.21.7.23:/home/jenkins-slave/nova-statistics.log .
#  if [[ "$?" != "0" ]]; then
#    echo "There are problem when trying to get the statistics log"
#    exit 1
#  fi
#}


function generate_file {                      #we need a temporary file 
  echo "Generating the temporary file"        #where we put the logs 
  touch temp.log
  touch mail.txt                              #from the date that we need 
  grep "$1" $LOGS_FILE >> temp.log
  if [[ "$?" -eq "1" ]]; then
    echo "The date entered is not present in the logs file"
    clean_up
    exit 1;
  fi

}

function clean_up {
  echo "Removing the temporary file and the statistics file"
  rm temp.log
  rm mail.txt
}

function calc_succ_init {
  total_inits=$(grep -c "init" temp.log)
  succ_init=$(grep -c "init;0" temp.log)
  echo "Success inits: $succ_init"
  echo Sucess inits '(%)': $(awk "BEGIN {printf $succ_init/$total_inits*100}")
  echo "Success inits: $succ_init" >> mail.txt
  echo Sucess inits '(%)': $(awk "BEGIN {printf $succ_init/$total_inits*100}") >> mail.txt
}

function calc_succ_runs {
  total_runs=$(grep -c "run" temp.log)
  succ_runs=$(grep -c "run;0" temp.log)
  echo "Success runs: $succ_runs"
  echo Sucess runs '(%)': $(awk "BEGIN {printf $succ_runs/$total_runs*100}")
  echo "Success runs: $succ_runs" >> mail.txt
  echo Sucess runs '(%)': $(awk "BEGIN {printf $succ_runs/$total_runs*100}") >> mail.txt
}

function calc_fail_init {
  total_inits=$(grep -c "init" temp.log)
  fail_init=$(grep "init" temp.log | grep -vc ";0")
  echo "Failed inits: $fail_init"
  echo Failed inits '(%)': $(awk "BEGIN {printf $fail_init/$total_inits*100}")
  echo "Failed inits: $fail_init" >> mail.txt
  echo Failed inits '(%)': $(awk "BEGIN {printf $fail_init/$total_inits*100}") >> mail.txt
}

function calc_fail_runs {
  total_runs=$(grep -c "run" temp.log)
  fail_runs=$(grep "run" temp.log | grep -vc ";0")
  echo "Failed runs: $fail_runs"
  echo Failed runs '(%)': $(awk "BEGIN {printf $fail_runs/$total_runs*100}")
  echo "Failed runs: $fail_runs" >> mail.txt
  echo Failed runs '(%)': $(awk "BEGIN {printf $fail_runs/$total_runs*100}") >> mail.txt
}


generate_file "$1" && calc_succ_init && calc_succ_runs \
  && calc_fail_init && calc_fail_runs && send_mail && clean_up #replace set -e

(( "$?" == "0" )) && echo "The script was succesfull" \
  || echo "There were errors when running the script. Try adding 'set -xe'"


