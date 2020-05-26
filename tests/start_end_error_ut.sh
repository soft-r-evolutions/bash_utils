#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "Perform test on start_end_error.sh" "end_user"
log "if a run fail the test will exit in no error" "end_user"

set_var output_file_name "${W}/start_end_error_output.log"
set_var start_end_error_log_file_name "${W}/start_end_error.log"

log "Launch the script start_end_error:" "end_user"
run "${W}/start_end_error.sh > ${output_file_name}" "no_exit"
log "Script successfully ended ... OK" "end_user"


log "Check log file content" "end_user"
set_var number "$(cat "${start_end_error_log_file_name}" | wc -l)"
run "[ ${number} -eq 8 ]"
run "grep -q FAILED ${start_end_error_log_file_name}"
log "Log file contains the right number of lines and has failed ... OK" "end_user"

log "Check output content" "end_user"
set_var number "$(cat "${output_file_name}" | wc -l)"
run "[ ${number} -eq 3 ]"
run "grep -q FAILED ${output_file_name}"
log "Output content contains the right number of lines and has failed ... OK" "end_user"

end_script 0
