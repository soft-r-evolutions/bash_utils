#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

log "I am an \"End User\" message display on the output" "end_user"
log "I am an \"Standard\" message only written in log file to debug."

end_script 0
