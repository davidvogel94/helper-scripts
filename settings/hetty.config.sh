#!/usr/bin/env bash

# shellcheck disable=SC2034

#*-----------------------------------------------------------------------------
HETTY_NETWORK='mitm';
HETTY_CONTAINER_NAME='hetty';
HETTY_HOSTNAME='hetty';
HETTY_CERT="$HOME/.hetty/hetty_cert.pem";
HETTY_KEY="$HOME/.hetty/hetty_key.pem";
HETTY_IMAGE="dstotijn/hetty:latest";
HETTY_CONTAINER_BASEPATH="/app";
HETTY_CONTAINER_ENTRYPOINT="${HETTY_CONTAINER_BASEPATH%%/}/hetty";
HETTY_DATA_DIR="$HOME/.hetty/db";
#*-----------------------------------------------------------------------------
