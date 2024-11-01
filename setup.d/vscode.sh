#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    "helpers/shell/output.sh" \
;

__require__ \
    "config/vscode.config.sh" \
;
#*-----------------------------------------------------------------------------

main() {
    setup_extensions;
}


setup_extensions() {
    show_msg "Installing Extensions...";
    for ext in "${VSCODE_SETUP_DEFAULT_EXTENSIONS[@]}"; do
        show_msg "- $ext"
        indent 2;
            local output_style; output_style="$(style green)";

            output="$(code --install-extension "$ext")";
            _rc="$?";

            if [[ "$_rc" -ne 0 ]]; then output_style="$(style red)"; fi

            last_line="$(echo "$output" | tail -n 1 | trim_output)";

            show_msg "${output_style}${last_line}$(style normal)";
        indent -2;
    done;
}

main "$@";
