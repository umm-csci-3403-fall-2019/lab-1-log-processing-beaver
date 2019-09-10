#!/usr/bin/env bash
content=$1
specifier=$2
output=$3
cat "${specifier}_header.html" "${content}" "${specifier}_footer.html" > "${output}"
