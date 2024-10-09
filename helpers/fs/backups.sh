#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    'helpers/shell/output.sh' \
;
#*-----------------------------------------------------------------------------

backup() {
    pattern="$(basename $1)(\.[0-9]*)?$";
    n="$(ls -al "$(dirname $1)" | grep -Ec "$pattern")";
    if [ $n == 0 ]; then 
        show_error "Can't backup $1 - not found.";
        return 1; 
    fi
    show_msg "Moving $1 => $1.$n";
    mv "$1" "$1.$n";
}
