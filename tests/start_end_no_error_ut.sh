#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on start_end_no_error.sh" "end_user"
log "if a run fail the test will exit in error" "end_user"

set_var output_file_name "${W}/start_end_no_error_output.log"
set_var start_end_no_error_log_file_name "${W}/start_end_no_error.log"

log "Launch the script start_end_no_error:" "end_user"
run "${W}/start_end_no_error.sh > ${output_file_name}"
log "Script successfully ended ... OK" "end_user"
log "Dump start_end_no_error log to test log"
run "cat ${start_end_no_error_log_file_name}"

log "Check log file generation" "end_user"
run "[ -f "${start_end_no_error_log_file_name}" ]"
log "Log file has been correctly generated ... OK" "end_user"

log "Check log file content" "end_user"
set_var number "$(cat "${start_end_no_error_log_file_name}" | wc -l)"
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
