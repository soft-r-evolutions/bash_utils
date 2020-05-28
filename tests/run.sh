#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

run "echo \"no_exit_cmd\" && false" "no_exit"
run "echo \"display_cmd\"" "display"
run "bash -c \"msg='standard complex command example' echo ${msg} | grep command\""
run "echo no_log_cmd" "no_log"
run "echo run_and_fail_cmd || false"

#unreachable code exit in error before
#end_script 0
