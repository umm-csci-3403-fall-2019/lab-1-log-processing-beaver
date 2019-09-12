#!/usr/bin/env bash

#This captures starting directory using pwd.
cDir=$(pwd)

#This initializes the directory in the argument as a variable.
dir=$1

#This goes into the directory.
cd $dir

#cat grabs the failed login data from every folder. sed then captures the hour and sort organizes the data alphabetically.
#uniq counts the number of occurences for a hour. The last sed adds the appropriate java script lines.
cat */failed_login_data.txt \
	| sed -E -n 's/[A-Za-z]* [0-9]* ([0-9]*) [A-Za-z0-9_-]* [0-9.]*/\1/p' \
        | sort \
        | uniq -c \
        | sed -E -n "s/[ ]*([0-9]*) ([0-9]*)/data.addRow(['\2', \1]);/p" \
        > hours_dist.txt

#this goes back into the top level directory.
cd $cDir

#this uses wrap_contents to wrap the header and footer with the javascript. $dir is the specified location where it is at.
#Then it puts the wrap_contents in $dir/hours_dist.html.
./bin/wrap_contents.sh $dir/hours_dist.txt html_components/hours_dist $dir/hours_dist.html

