#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on run.sh" "end_user"
log "if a run fail the test will exit in no error" "end_user"

run output_file_name "${W}/run_output.log"
run run_log_file_name "${W}/run.log"

log "Launch the script run:" "end_user"
run "${W}/run.sh > ${output_file_name}" "no_exit"
run "cat ${run_log_file_name}"
log "Script successfully ended ... OK" "end_user"

# To adapt

#log "Check log files content for end user mode" "end_user"
#run "grep -q \"End User\" ${output_file_name}"
#run "grep -q \"End User\" ${run_log_file_name}"
#log "Log file and log output contains End user message ... OK" "end_user"
#
#log "Check log files content for default mode" "end_user"
#run "grep -q \"Standard\" ${run_log_file_name}"
#run "! grep -q \"Standard\" ${output_file_name}"
#log "Only log output contains Standard message ... OK" "end_user"
#
#log "Check log files content for no_log mode" "end_user"
#run "grep -q \"********\" ${run_log_file_name}"
#run "! grep -q \"No log\" ${output_file_name}"
#log "Only log output contains Standard message ... OK" "end_user"

end_script 0