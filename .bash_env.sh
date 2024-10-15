#!/usr/bin/env bash
# *******************************************************************************
# *           Bootstrap common environment that all scripts can use.            *
# *******************************************************************************
shopt -s checkwinsize
shopt -s extglob

# Return base directory of this repository.
__script_base_dir__() { dirname ${BASH_SOURCE[0]}; };
# Get the file name of the currently executing script
__current_script_filename__() { basename ${BASH_SOURCE[0]}; };

# Source helper scripts, configuration scripts etc. using paths relative to the base script directory
# (very useful)
__require__() { for f in $@; do source "$(__script_base_dir__)/$f"; done; };
