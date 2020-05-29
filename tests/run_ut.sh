#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on run.sh" "end_user"
log "if a run fail the test will exit in no error" "end_user"

set_var output_file_name "${W}/run_output.log"
set_var run_log_file_name "${W}/run.log"

log "Launch the script run:" "end_user"
run "${W}/run.sh > ${output_file_name}" "no_exit"
run "cat ${run_log_file_name}"
log "Script successfully ended ... OK" "end_user"

log "Check log files content for standard command" "end_user"
run "! grep -q \"command standard\" ${output_file_name}"
run "grep -q \"command standard\" ${run_log_file_name}"
run "grep -q \"successfully.*id:1\" ${run_log_file_name}"
log "Standard command is Logged file and not displayed ... OK" "end_user"

log "Check log files content for no_exit option" "end_user"
run "grep -q \"id:2.*has failed.*no exit specified\" ${run_log_file_name}"
log "log output contains failure without exiting ... OK" "end_user"

log "Check log files content for display option" "end_user"
run "grep -q \"display_cmd\" ${output_file_name}"
run "grep -q \"display_cmd\" ${run_log_file_name}"
log "Standard command is Logged file and displayed ... OK" "end_user"

log "Check log files content for no_log option" "end_user"
run "grep -q \"not logged command.*id:4\" ${run_log_file_name}"
run "grep -q \"no_log_cmd\" ${run_log_file_name}"
run "! grep -q \"no_log_cmd\" ${output_file_name}"
log "Output does not contain cmd but it contains its result ... OK" "end_user"

log "Check log files content for multiple options" "end_user"
run "grep -q \"id:5.*has failed.*no exit specified\" ${run_log_file_name}"
run "grep -q \"not logged command.*id:5\" ${run_log_file_name}"
run "grep -q \"multiple_flags\" ${run_log_file_name}"
run "grep -q \"multiple_flags\" ${output_file_name}"
log "Output does not contain cmd but it contains its result, is displayed, does not exit ... OK" "end_user"

log "Check log files content for multiple options" "end_user"
run "grep -q \"id:6.*has failed.*exiting\" ${run_log_file_name}"
run "grep -q \"run_and_fail_cmd\" ${run_log_file_name}"
run "grep -q \"run_and_fail_cmd\" ${output_file_name}"
run "grep -q \"FAILED with status 1\" ${output_file_name}"
log "Output contain cmd it exit in error ... OK" "end_user"

end_script 0
