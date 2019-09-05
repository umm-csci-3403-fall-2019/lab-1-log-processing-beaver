#!/usr/bin/env bash
dir=$1
cd $dir
for file in ./*.tgz
do
	echo $file
	filename=$(basename -- $file)
	echo $filename
	echo $(basename $filename .tgz)
	mkdir $(basename $filename .tgz)
	tar -zxf $file -C $(basename $filename .tgz)
done	
