#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on set_var.sh" "end_user"
log "if a run fail the test will exit in no error" "end_user"

set_var output_file_name "${W}/set_var_output.log"
set_var set_var_log_file_name "${W}/set_var.log"

log "Launch the script set_var:" "end_user"
run "${W}/set_var.sh > ${output_file_name}"
run "cat ${set_var_log_file_name}"
log "Script successfully ended ... OK" "end_user"

log "Check log files content for end user mode" "end_user"
run "grep -q \"End User\" ${output_file_name}"
run "grep -q \"End User\" ${set_var_log_file_name}"
log "Log file and log output contains End user message ... OK" "end_user"

log "Check log files content for default mode" "end_user"
run "grep -q \"Standard\" ${set_var_log_file_name}"
run "! grep -q \"Standard\" ${output_file_name}"
log "Only log output contains Standard message ... OK" "end_user"

log "Check log files content for no_log mode" "end_user"
run "grep -q \"********\" ${set_var_log_file_name}"
run "! grep -q \"No log\" ${output_file_name}"
log "Only log output contains Standard message ... OK" "end_user"

end_script 0
