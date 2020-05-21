# bash_utils

![CI](https://github.com/soft-r-evolutions/bash_utils/workflows/CI/badge.svg)

## Goals 

Utils for shell scripts. This allow your script to:

* Get a standard log format for all your scripts
* Log important informations such as executed command and variables
* Log script start and end with time stamp.
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


## Special variables

Special variables must be set using export before calling start_script method.

#### Append logs to previous one

By default previous log is erased. You can keep previous run log by
set **is_log_append** to **"True"**.

#### Define an output path

By default log are placed in the script folder. You can specify a different
folder using **output_path** variable.

The specified output path is **automatically created**. If one exist script
**will write in it**.

#### Define a log file name

By default log are placed in a file named: **script_name.log**. You can specify
a different log file name using **log_file_name** variable.

The specified lof file name is **automatically created**.

## Methods

### start_script Method

This method enables loggin and set variables. Variables are written into log_file_name.

### end_script

This method close script gracefully.

