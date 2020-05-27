# bash_utils

![CI](https://github.com/soft-r-evolutions/bash_utils/workflows/CI/badge.svg)

## Goals 

Utils for shell scripts. This allow your script to:

* Get a standard log format for all your scripts
* Log important informations such as executed command and variables
* Log script start and end with time stamp
* Integrate useful and basic features such as get absolute root script path...

## Basic usage

Source the log.sh script in your script.

If the script is in the same script directory

```
#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

start_script

end_script 0
```

## Concepts

A script must set special variables if needed and then call start_script.

To display a message call log message. It will be timestamped and logged.
If "end_user" is specified the message will be displayed on stdout.

To declare a variable use set_var. It will be logged. If "no_log" is specified
variable value will be hidden.

To launch a command use run method. The performed command will be logged with
its result except if "no_log" argument specified. If the command failed the script
will exit with the command errorcode except if "no_exit" is specified.

To terminate the script use end_script with the exit code.

## Log types

Log types define where to display and write logs. This help:

* to log at maximum as possible for debug.
* to make a clean script output for customer.
* to avoid logging sensitive data.

There are 3 log types:

* "" (default): will log in log_file_name and not on the standard output.
* "end_user": will log in log_file_name and on the standard output (indication for end user).
* "no_log": will not be written in log file (if you have to transfer log data to customers)

## Quick Overview

```
#!/bin/bash

function usage {
    echo "Compare files between two directories" 
    echo "compare_files.sh folder_1 folder_2"
    echo "With:"
    echo "folder_1 path to compare"
    echo "folder_2 path to compare"
}

if [ "$#" -ne 2 ]; then
    usage 1
fi

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

export output_path='${W}/output'

start_script

set_var folder_1 "$1"
set_var folder_2 "$2"

log "List folder 1 entries to : ${origin_folder}" "end_user"

set_var folder_1_entries "${output_path}/${folder_1}_entries.txt"
set_var folder_2_entries "${output_path}/${folder_2}_entries.txt"
run "ls -lR ${folder_1} > ${folder_1_entries}"
run "ls -lR ${folder_2} > ${folder_2_entries}"

run "diff ${folder_1_entries} ${folder_2_entries}"

end_script 0
```


## Start and Exit a script Methods

### Overview

Start and stop script offer the script to log properly when it starts and
finish.

It ensures the logs are correctly set up.

Logging the script end offer to detect a hard reset because the script didn't
log its end properly.

** Missing: silent and verbose options **

### start_script Method

This method enables loggin and compute some default variables. Computed Variable are
written into log_file_name:

* root_path: script root path
* output_path: script output path where to put generated output such as log file or other
files (default_value: root_path).
* log_file_name: log file name to put debug traces.

#### Special variables

Special variables must be set using export before calling start_script method.

##### Append logs to previous one

By default previous log is erased. You can keep previous run log by
set **is_log_append** to **"True"**.

##### Define an output path

By default log are placed in the script folder. You can specify a different
folder using **output_path** variable.

The specified output path is **automatically created**. If one exist script
**will write in it**.

##### Define a log file name

By default log are placed in a file named: **script_name.log**. You can specify
a different log file name using **log_file_name** variable.

The specified lof file name is **automatically created**.

#### Example

```
#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

export is_log_append=True
export output_path="${W}/output"
export log_file_name="${output_path}/toto.log"

start_script

end_script 0
```

### end_script Method

This method close script gracefully.

end_script parameter is the script exit code. **0 means no error occured** otherwise
an error occured.

### log Method

This method log requested message according the log type policy. To put " character
escape it \\".

Using log method log all script methods with a timestamp and the defined format.

the second argument must be as following: "arg 2".

Standard messages are log in log file for debug. End user message are displayed for
end user.

```
#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

start_script

log "I am an \"End User\" message display on the output" "end_user"
log "I am an \"Standard\" message only written in log file to debug."

end_script 0
```

### set_var Method

This method create or update a variable to the requested value. The variable and its new value
is logged into the log file name. To put " character escape it as following \\".

To hide a value in log you can set log_type parameter to "no_log".

You can also set a command result to a variable using $()

```
#!/bin/bash

W=$(dirname $(realpath $0))
source ${W}/bash_utils.sh

start_script

set_var end_user_var "End User" "end_user"
set_var no_log_var "No log" "no_log"
set_var standard_var "$(echo \"Standard\")"

end_script 0
```
