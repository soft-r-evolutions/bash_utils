#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on log_messages.sh" "end_user"
log "if a run fail the test will exit in no error" "end_user"

set_var output_file_name "${W}/log_messages_output.log"
set_var log_messages_log_file_name "${W}/log_messages.log"

log "Launch the script log_messages:" "end_user"
run "${W}/log_messages.sh > ${output_file_name}"
log "Script successfully ended ... OK" "end_user"

log "Check log files content" "end_user"
run "grep -q \"End User\" ${output_file_name}"
run "grep -q \"End User\" ${log_messages_log_file_name}"
log "Log file and log output contains End user message ... OK" "end_user"

log "Check log files content" "end_user"
run "grep -q \"Standard\" ${log_messages_log_file_name}"
run "! grep -q \"Standard\" ${output_file_name}"
log "Only log output contains Standard message ... OK" "end_user"

end_script 0
