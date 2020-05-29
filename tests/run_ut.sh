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
run "grep -q \"id|2|successfully\" ${run_log_file_name}"
log "Standard command is Logged file and not displayed ... OK" "end_user"

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
