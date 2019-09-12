#!/usr/bin/env bash

# wrap_contents.sh takes 3 inputs:
# The name of the file containing the "contents" that need to be wrapped between the header and footer
content=$1
# The common basename shared by the desired header and footer html files
specifier=$2
# The name of the output file
output=$3

# concatenates the content of the first argument between a header.html and footer.html specified by the second argument into a file
#  named by the third argument
cat "${specifier}_header.html" "${content}" "${specifier}_footer.html" > "${output}"
