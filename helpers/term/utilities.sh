#!/usr/bin/env bash
require(){ for f in $@; do source "$(dirname "${BASH_SOURCE[0]}")/$f"; done; };
#*-----------------------------------------------------------------------------
require 'output.sh';
#*-----------------------------------------------------------------------------

interactive() {
    arg="$(echo "$@" | awk '{ print toupper($0) }')";
    
    case "$arg" in
        ON)  stty echo ;;
        OFF) stty -echo ;;
    esac
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

#*-----------------------------------------------------------------------------