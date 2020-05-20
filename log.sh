#!/bin/bash

function log() {
    msg=$1
    log_type=$2

    local time_log=$(date "+%Y%m%d_%H:%M:%S,%3N")
    log_msg="${time_log} ${msg}"

    if [ "${log_type}" == "end_user" ]; then
        echo ${log_msg}
    fi

    echo ${log_msg} >> ${log_file_name}
}

function display_var() {
    var_name=$1
    var_value=$2
    log_type=$3

    if [ "${log_type}" != "no_log" ]; then
        msg="Set ${var_name} to: '${var_value}'"
    else
        msg="Set ${var_name} to: '*********'"
    fi
    log "${msg}" "${log_type}"
}

function set_var() {
    var_name=$1
    var_value=$2
    log_type=$3

    export ${var_name}="${var_value}"
    display_var ${var_name} "${var_value}" "${log_type}"
}

function run() {
    cmd=
    cmd_option=$2

    if [ "${cmd_option}" == "no_log" ]; then
        bash -c "${cmd}" 2>&1
        result=${PIPESTATUS[0]}
    else
        log "bash -c \"${cmd}\" 2>&1"
        bash -c "${cmd}" 2>&1 | tee -a ${log_file_name}

        result=${PIPESTATUS[0]}
    fi

    if [ "${cmd_option}" != "no_exit" ]; then
        if [ ${result} -ne 0 ]; then
            end_script ${result}
        fi
    fi    
}

function _start_script() {
    if [ "${is_log_append}" != "True" ]; then
        rm "${log_file_name}"
    fi

    log "-- Start script: ${script_name}" "end_user"
    display_var root_path "${root_path}"
    if [ "${is_default_output_path}" == "True" ]; then
        log "No output_path variable defined set to default."
    fi
    display_var output_path "${output_path}"
    if [ "${is_default_log_file_name}" == "True" ]; then
        log "No log_file_name variable defined set to default."
    fi
    display_var log_file_name "${log_file_name}"
}

function _init_log() {
    if [ ! -d ${output_path} ]; then
        mkdir -p ${output_path}
    fi
}

function start_script() {
    script_name="$(basename $0)"
    root_path="$(realpath $(dirname $0))"

    if [ -z ${output_path} ]; then
        is_default_output_path="True"
        output_path="${root_path}"
    fi

    if [ -z ${log_file_name} ]; then
        local name=$(echo ${script_name} | cut -f1 -d'.')
        log_file_name="${output_path}/${name}.log"
        is_default_log_file_name="True"
    fi

    _init_log

    _start_script
}

function end_script() {
    result=$1

    log "-- Logs available at: ${log_file_name}" "end_user"
    if [ "$1" == 0 ]; then
        log "-- Script ${script_name} ended Successfully" "end_user"
    else
        log "-- Script ${script_name} FAILED with status ${result}" "end_user"
    fi
}
