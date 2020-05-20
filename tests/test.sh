#!/bin/bash

source log.sh

start_script

end_script 0

number=$(cat ${log_file_name} | wc -l); [ ${number} -eq 8 ] && echo OK && exit 0
