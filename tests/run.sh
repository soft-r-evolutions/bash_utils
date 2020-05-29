#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

run "echo \"command standard\" | grep command"
run "echo \"no_exit_cmd\" && false" "no_exit"
run "echo \"display_cmd\"" "display"
run "echo no_log_cmd" "no_log"
run "echo multiple_flags && false" "display,no_log,no_exit"
# must be last command to test exit in error
run "echo run_and_fail_cmd && false" "display"

#unreachable code exit in error before
#end_script 0
