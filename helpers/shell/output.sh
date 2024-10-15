#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
# __require__ ...
#*-----------------------------------------------------------------------------

# shellcheck disable=SC2059   # This is a hack anyway
set_col() { printf "\r\033[${1}C"; };


style() { 
  _style() {
      while [ "$#" -gt 0 ]; do
          style="$(echo "$1" | awk '{ print toupper($0) }')";
          case "$style" in
              BLACK)          tput setaf 0 ;;
              RED)            tput setaf 1 ;;
              GREEN)          tput setaf 2 ;;
              YELLOW)         tput setaf 3 ;;
              LIME_YELLOW)    tput setaf 190 ;;
              POWDER_BLUE)    tput setaf 153 ;;
              BLUE)           tput setaf 4 ;;
              MAGENTA)        tput setaf 5 ;;
              CYAN)           tput setaf 6 ;;
              WHITE)          tput setaf 7 ;;
              BOLD)           tput bold ;;
              NORMAL)         tput sgr0 ;;
              BLINK)          tput blink ;;
              REVERSE)        tput smso ;;
              UNDERLINE)      tput smul ;;
          esac
          shift;
      done
  };
  printf "$(_style "$@")"; 
};

_OUTPUT_COL="${_OUTPUT_COL:-0}";
_OUTPUT_PREFIX="${_OUTPUT_PREFIX:-""}";
_OUTPUT_PREFIX_STYLE_DEFAULT="${_OUTPUT_PREFIX_STYLE_DEFAULT:-"blue bold"}";
_OUTPUT_PREFIX_STYLE="${_OUTPUT_PREFIX_STYLE:-"$_OUTPUT_PREFIX_STYLE_DEFAULT"}";

_OUTPUT_TABLE_COL_DEFAULT_WIDTH=${_OUTPUT_TABLE_COL_DEFAULT_WIDTH:-20};
_OUTPUT_TABLE_COL_WIDTH="${_OUTPUT_TABLE_COL_WIDTH:-"$_OUTPUT_TABLE_COL_DEFAULT_WIDTH"}";


indent() { _OUTPUT_COL="$((_OUTPUT_COL+$1))"; };
prefix() { _OUTPUT_PREFIX="$*"; };
prefix_style() { _OUTPUT_PREFIX_STYLE="$*"; };
prefix_reset() { _OUTPUT_PREFIX=''; _OUTPUT_PREFIX_STYLE="$_OUTPUT_PREFIX_STYLE_DEFAULT"; };
set_output_column_width() { _OUTPUT_TABLE_COL_WIDTH="$1"; };

show_msg() {
  local _prefix="$_OUTPUT_PREFIX";
  local _prefix_style="${_OUTPUT_PREFIX_STYLE:-$(style normal)}";
  local _cursor_ind=$((${#_prefix}+_OUTPUT_COL));
  
  
  if [[ $_prefix ]]; then 
    _cursor_ind=$((_cursor_ind+1)); # Add a single space between prefix and output if prefix is specified.
    style "$_prefix_style";

    printf "%s" "$_prefix";
    
    style "normal";
  fi

  
  local n=0;
  local width="$_OUTPUT_TABLE_COL_WIDTH";
  while [ $# -gt 0 ]; do
    local _ind=$((_cursor_ind+n*width));
    set_col $_ind;
    n=$((n+1));
    printf "%s" "$1";
    shift;
  done;
  printf '\n';
}


show_error() {
    prefix '[ERROR]';
    prefix_style red bold underline;
    show_msg "$@";
    prefix_reset;
}

trim_output() {
  _padding=2;
  cols=$((COLUMNS-${#_OUTPUT_PREFIX}-_OUTPUT_COL-_padding));
  while read -r line
  do
    echo "${line:0:cols}";
  done < "${1:-/dev/stdin}"
}
#*-----------------------------------------------------------------------------
