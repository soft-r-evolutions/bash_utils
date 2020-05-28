#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

run "false" "no_exit"
run "true"
run "bash -c \"msg='I am a complex command' echo ${msg} | grep command\""
run "echo no_log" "no_log"
run "false"

#unreachable code exit in error before
#end_script 0
