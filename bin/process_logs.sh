#!/usr/bin/env bash

# Capture out top level project directory
cDir=$(pwd)

# Create a temp directory
scratch=$(mktemp --directory)

# Change into the temp directory
cd "$scratch" || exit

# For every file inside the .tgz arguments passed into this script
# Use basename to extract the base file name and discard _secure.tgz
# Create a directory based on the basename
# Exctract every .tgz file into it's respectively named directory
# Call process_client_logs.sh from out project directory on every every directory
for file in "$@"
do 
	filename=$(basename "$(basename "$file" --"$file")"_secure.tgz)
	mkdir "$filename"
	tar -zxf "$cDir"/"$file" -C "$filename"
	"$cDir"/bin/process_client_logs.sh "$filename"
done

# Change back into our top level project directory
cd "$cDir" || exit


# Call every helper script function we created with the temp directory as a argument
./bin/create_username_dist.sh "$scratch"
./bin/create_hours_dist.sh "$scratch"
./bin/create_country_dist.sh "$scratch"
./bin/assemble_report.sh "$scratch"

# Move the final failed_login_summary.html to our top level project directory
mv "$scratch"/failed_login_summary.html "$cDir"
