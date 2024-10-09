#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    'helpers/shell/output.sh' \
;
#*-----------------------------------------------------------------------------

assert_command() {
    local cmd='':

    while [ "$#" -gt 0 ]; do
        cmd="$1";
        shift;

        if ! command -v "$cmd" > /dev/null; then
            show_error "COMMAND NOT FOUND:" "$(style bold)$cmd$(style normal)";
            exit 1;
        fi
    done
}

assert_bash_min_version() {
    local default_minimum_version=4;
    
    local required_version="${1:-$default_minimum_version}";
    local current_version="${BASH_VERSINFO:-0}";


    if [[ "$current_version" -lt $required_version ]]; then
        show_error "$(style bold)INCOMPATIBLE BASH VERSION$(style normal)"    > /dev/stderr;
    
        indent 4;
        
        show_error ;
        show_error "Current" "$current_version"   > /dev/stderr;
        show_error "Minimum" "$required_version"  > /dev/stderr;
        show_error ;

        indent -4;
        

        exit 1;
    fi
}