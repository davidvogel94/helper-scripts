#!/usr/bin/env bash
# shellcheck disable=SC1091
# *******************************************************************************
# *     Source this file in ~/.*rc to bootstrap the scripts within ./bin        *
# *******************************************************************************

# Wrap logic in a function so 'return' can be used instead of 'exit'
# i.e. don't want the bashrc etc to exit just because this fails.
__bootstrap__() {
    local base_dir="${1%/}";
    local bin_dir="$base_dir/bin";

    local bootstrap_environment="$base_dir/.bootstrap_env";

    # Shouldn't try to make script shims if can't find the required dependencies
    if ! [ -d "$bin_dir" ]; then
        echo "(bootstrap) NOT FOUND: $bin_dir" > /dev/stderr;
        return 1;
    fi
    if ! [ -f "$bootstrap_environment" ]; then
        echo "(bootstrap) NOT FOUND: $bootstrap_environment" > /dev/stderr;
        return 1;
    fi

    while IFS='' read -r f
    do
        _f="$(basename "$f")";
        eval "$_f(){ BASH_ENV='$bootstrap_environment' /usr/bin/env $bin_dir/$_f \"\$@\"; };"
    done < <(find "$bin_dir" -maxdepth 1 -type f);
}

__bootstrap__ "$(dirname "$0")";

# File for user shell environment vars
source "$(dirname "$0")/user_env.sh";

# File for user shell functions and aliases
source "$(dirname "$0")/user_aliases.sh";
