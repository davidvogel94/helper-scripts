
# Default settings
declare -A PG_SETUP_DEFAULTS=(
    [DUMPFILE]="$HOME/dev/database/dumps/EnterpriseStore.Dev.log"
    [CONTAINER]="postgres"
    [NETWORK]="postgres"
    [USER]="easuser"
    [PASSWORD]="secure_pwd"
    [ROOT_PASSWORD]="secure_pwd"
    [VOLUME]="pgdata-eas"
    [IMAGE]="postgres:13.4"
    [PORT]="5432"
)


# Defaults will be used unless these variables have already been exported publicly as environment variables
# e.g. by running 
#    export PG_SETUP_PASSwORD="foo"

PG_SETUP_DUMPFILE=${PG_SETUP_DUMPFILE:-"${PG_SETUP_DEFAULTS[DUMPFILE]}"};
PG_SETUP_CONTAINER=${PG_SETUP_CONTAINER:-"${PG_SETUP_DEFAULTS[CONTAINER]}"};
PG_SETUP_NETWORK=${PG_SETUP_NETWORK:-"${PG_SETUP_DEFAULTS[NETWORK]}"};
PG_SETUP_USER=${PG_SETUP_USER:-"${PG_SETUP_DEFAULTS[USER]}"};
PG_SETUP_PASSWORD=${PG_SETUP_PASSWORD:-"${PG_SETUP_DEFAULTS[PASSWORD]}"};
PG_SETUP_ROOT_PASSWORD=${PG_SETUP_ROOT_PASSWORD:-"${PG_SETUP_DEFAULTS[ROOT_PASSWORD]}"};
PG_SETUP_VOLUME=${PG_SETUP_VOLUME:-"${PG_SETUP_DEFAULTS[VOLUME]}"};
PG_SETUP_IMAGE=${PG_SETUP_IMAGE:-"${PG_SETUP_DEFAULTS[IMAGE]}"};
PG_SETUP_PORT=${PG_SETUP_PORT:-"${PG_SETUP_DEFAULTS[PORT]}"};
