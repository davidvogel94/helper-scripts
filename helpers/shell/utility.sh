#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    'helpers/shell/output.sh' \
;
#*-----------------------------------------------------------------------------

# * set tty interactivity on or off.
set_interactive() {
    local arg="$(echo "$@" | awk '{ print toupper($0) }')";
    
    case "$arg" in
    ON)  
        stty echo;
        ;;
    OFF) 
        stty -echo;
        ;;
    *) 
        show_error "Invalid input to function 'set_interactive()':";
        show_error "Received:" "$arg";
        show_error "Valid inputs are:" "ON, OFF";
        return 1;
        ;;
    esac
}

#*-----------------------------------------------------------------------------
