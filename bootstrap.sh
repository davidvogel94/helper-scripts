#!/usr/bin/env bash
# *******************************************************************************
# *     Source this file in ~/.*rc to bootstrap the scripts within ./bin        *
# *******************************************************************************

# Wrap logic in a function so 'return' can be used instead of 'exit'
# i.e. don't want the bashrc etc to exit just because this fails.
__bootstrap__() {
    local base_dir="${1%/}";
    local bin_dir="$base_dir/bin";

    local bash_env_script="$base_dir/.bash_env.sh";

    # Shouldn't try to make script shims if can't find the required dependencies
    if ! [ -d "$bin_dir" ]; then
        echo "(bootstrap) NOT FOUND: $bin_dir" > /dev/stderr;
        return 1;
    fi
    if ! [ -f "$bash_env_script" ]; then
        echo "(bootstrap) NOT FOUND: $bash_env_script" > /dev/stderr;
        return 1;
    fi

    while IFS='' read -r f
    do
        _f="$(basename "$f")";
        eval "$_f(){ BASH_ENV='$bash_env_script' /usr/bin/env bash $bin_dir/$_f \"\$@\"; };"
    done < <(find "$bin_dir" -maxdepth 1 -type f);
}

__bootstrap__ "$(dirname "$0")";
