#!/usr/bin/env bash

#This captures starting directory using pwd.
cDir=$(pwd)

#This initializes the directory in the argument as a variable.
dir=$1

#This goes into the directory.
cd $dir

# cat grabs every all the _dist.html files and save the output as failed_login_summary.txt
cat *_dist.html > failed_login_summary.txt

#this goes back into the top level directory.
cd $cDir

#this uses wrap_content.sh to wrap all the other html files stored in faled_login_summary.txt between summary_plot header and footer
#and save it as failed_login_summary.html
./bin/wrap_contents.sh $dir/failed_login_summary.txt  html_components/summary_plots $dir/failed_login_summary.html
