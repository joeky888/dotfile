#!/bin/bash

function upsert()
{
    regex=$1 # Line contains string
    line=$2  # To be replaced
    file=$3  # in the targe file

    first_line=$(grep -n -m 1 "$regex" "$file" | sed 's/\([0-9]*\).*/\1/')

    if [ -z "${first_line}" ]; then
        # Not found, add it
        echo "${line}" >> ${file}
    else
        sed -i "/${regex}/d" ${file} # Remove all lines
        sed -i "${first_line}i${line}" ${file} # Insert line to the specified line number
    fi
}

upsert "fs.file-max"                "fs.file-max = 200000"          /etc/sysctl.conf
upsert "\*\s*soft\s*nofile"         "* soft  nofile  200000"        /etc/security/limits.conf
upsert "\*\s*hard\s*nofile"         "* hard  nofile  200000"        /etc/security/limits.conf
upsert "root\s*soft\s*nofile"       "root soft nofile 200000"       /etc/security/limits.conf
upsert "root\s*hard\s*nofile"       "root hard nofile 200000"       /etc/security/limits.conf
upsert "\*\s*soft\s*nproc"          "* soft  nproc  200000"         /etc/security/limits.conf
upsert "\*\s*hard\s*nproc"          "* hard  nproc  200000"         /etc/security/limits.conf
upsert "root\s*soft\s*nproc"        "root soft nproc 200000"        /etc/security/limits.conf
upsert "root\s*hard\s*nproc"        "root hard nproc 200000"        /etc/security/limits.conf

sysctl -p --system
