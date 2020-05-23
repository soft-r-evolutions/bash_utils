#!/bin/bash

function usage {
    error_code=$1
    echo "Compare files between two directories" 
    echo "compare_files.sh folder_1 folder_2"
    echo "With:"
    echo "folder_1 path to compare"
    echo "folder_2 path to compare"
    echo "The script exit in error:"
    echo "- if you don't have right to read one of the specified folder."
    echo "- if the two folders are different"
    echo "The script exit successfully:"
    echo "- if the two folders are the same"
    exit ${error_code}
}

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    usage 0
fi

if [ "$#" -ne 2 ]; then
    usage 1
fi

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

export output_path="${W}/output"

start_script

set_var folder_1_path "$(realpath $1)"
set_var folder_2_name "$(basename $folder_1_path)"
set_var folder_2_path "$(realpath $2)"
set_var folder_2_name "$(basename $folder_2_path)"

log "List folder 1 entries to : ${folder_1_path}" "end_user"
set_var folder_1_entries "${output_path}/1_${folder_1_name}_entries.txt"
run "ls -lR ${folder_1_path} > ${folder_1_entries} 2>&1"

log "List folder 2 entries to : ${folder_2_path}" "end_user"
set_var folder_2_entries "${output_path}/2_${folder_2_name}_entries.txt"
run "ls -lR ${folder_2_path} > ${folder_2_entries} 2>&1"

log "Compare the two folders" "end_user"
run "diff ${folder_1_entries} ${folder_2_entries} && echo OK"

end_script 0
