#!/bin/bash

# License: Apache 2.0
# Author: Costin Galan <cgalan@cloudbasesolutions.com>
# Description: Create users and assign them passwords from text files


# Read user and password
while read -r user password; do

 # Just print this for debugging.
 printf "\tCreating user: %s with password: %s\n" "$user" "$password"

 # Create the user with adduser (you can add whichever option you like).
 useradd -m "$user" -g "fiipractic"

 # Assign the password to the user.
 # Password is passed via stdin, *twice* (for confirmation).
 passwd -q "$user" <<< "$password"$'\n'"$password"

done < <(paste users.txt passwords.txt)
