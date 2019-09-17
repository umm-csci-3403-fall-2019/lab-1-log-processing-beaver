#!/usr/bin/env bash

#This captures starting directory using pwd.
cDir=$(pwd)

#This initializes the directory in the argument as a variable.
dir=$1

#This goes into the directory.
cd "$dir" || exit

#cat grabs the failed login data from every folder. sed then captures the IP addresses  and sort organizes the data alphabetically.
#join combines the input from pipe through - and the country_IP_map. We then capture just the country name,sort it and count number of unique values.
#The last sed adds the appropriate java script lines with the country codes and their number of occurences.
cat ./*/failed_login_data.txt \
	| sed -E -n 's/[A-Za-z]*[ ]*[0-9]* [0-9]* [A-Za-z0-9_-]* ([0-9.]*)/\1/p' \
        | sort \
	| join  - "$cDir"/etc/country_IP_map.txt \
	| sed -E -n 's/[0-9.]* ([A-Z]*)/\1/p' \
	| sort \
        | uniq -c \
        | sed -E -n "s/[ ]*([0-9]*) ([A-Z]*)/data.addRow(['\2', \1]);/p" \
        > country_dist.txt


#this goes back into the top level directory.
cd "$cDir" || exit

#this uses wrap_contents to wrap the header and footer with the javascript. $dir is the specified location where it is at.
#Then it puts the wrap_contents in $dir/country_dist.html.
./bin/wrap_contents.sh "$dir"/country_dist.txt html_components/country_dist "$dir"/country_dist.html

rm "$dir"/country_dist.txt
