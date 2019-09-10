#!/usr/bin/env bash
cDir=$(pwd)
dir=$1
cd $dir
cat */failed_login_data.txt \
	| sed -E -n 's/[A-Za-z]* [0-9]* [0-9]* ([A-Za-z0-9_-]*) [0-9.]*/\1/p' \
	| sort \
	| uniq -c \
	| sed -E -n "s/[ ]*([0-9]*) ([A-Za-z0-9_-]*)/data.addRow(['\2', \1]);/p" \
	> username_dist.txt
cd $cDir
./bin/wrap_contents.sh $dir/username_dist.txt html_components/username_dist $dir/username_dist.html

