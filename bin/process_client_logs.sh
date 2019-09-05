#!/usr/bin/env bash
dir=$1
cd $dir
for file in *.tgz
do
	cat */var/log/secure* > failed_login_data.txt
done	
