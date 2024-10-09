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
    if ! [ -d $bin_dir         ]  \
    || ! [ -f $bash_env_script ]; \
    then
        echo "(bootstrap) NOT FOUND: $base_dir" > /dev/stderr;
        return 1;
    fi

    for f in $(find "$bin_dir" -type f -maxdepth 1); do
        # Build shim definitions for each script in the bin directory and evaluate.
        local _name="$(basename $f)";
        eval "$_name(){ BASH_ENV='$bash_env_script' /usr/bin/env bash $bin_dir/$_name \$@; };"
    done;
}

__bootstrap__ "$(dirname $0)";
