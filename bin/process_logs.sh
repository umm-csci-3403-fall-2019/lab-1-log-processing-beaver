#!/usr/bin/env bash

cDir=$(pwd)

scratch=$(mktemp --directory)

cd $scratch

for file in "$@"
do
	filename=$(basename $(basename $file --$file) _secure.tgz)
	mkdir $filename
	tar -zxf $cDir/$file -C $filename
	$cDir/bin/process_client_logs.sh $filename
done

cd $cDir


./bin/create_username_dist.sh $scratch
./bin/create_hours_dist.sh $scratch
./bin/create_country_dist.sh $scratch
./bin/assemble_report.sh $scratch

mv $scratch/failed_login_summary.html $cDir




tree $scratch
