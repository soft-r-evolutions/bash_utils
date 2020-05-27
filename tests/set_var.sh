#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/../bash_utils.sh

start_script

set_var end_user_var "End User" "end_user"
set_var no_log_var "No log" "no_log"
set_var standard_var "$(echo \"Standard\")"

end_script 0
