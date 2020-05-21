#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on simple.sh" "end_user"
log "if a run fail the test will exit in error" "end_user"

set_var output_file_name "${W}/simple_output.log"
set_var simple_log_file_name "${W}/simple.log"

log "Launch the script simple:" "end_user"
run "${W}/simple.sh > ${output_file_name}"
log "Script successfully ended ... OK" "end_user"
log "Dump simple log to test log"
run "cat ${simple_log_file_name}"

log "Check log file generation" "end_user"
run "[ -f "${simple_log_file_name}" ]"
log "Log file has been correctly generated ... OK" "end_user"

log "Check log file content" "end_user"
set_var number "$(cat "${simple_log_file_name}" | wc -l)"
run "[ ${number} -eq 8 ]"
log "Log file contains the right number of lines ... OK" "end_user"

log "Check output content" "end_user"
set_var number "$(cat "${output_file_name}" | wc -l)"
run "[ ${number} -eq 3 ]"
log "Output content contains the right number of lines ... OK" "end_user"

log "Check test log file content to see if cat is present in it correctly" "end_user"
set_var number "$(cat "${log_file_name}" | wc -l)"
run "[ ${number} -eq 40 ]"
log "Log file content contains the right number of lines ... OK" "end_user"

end_script 0
