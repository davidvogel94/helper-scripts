#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    "helpers/shell/output.sh" \
    "helpers/fs/backups.sh" \
;

__require__ \
    "config/postgres.config.sh" \
;
#*-----------------------------------------------------------------------------

main() {
    prefix_style yellow bold;
    prefix "[ WARNING ]";
        show_msg "$(style yellow bold)This will delete the existing postgres container and volume$(style normal)"
        read -p "Press Enter to continue; Ctrl+C to cancel..."; echo
    prefix_reset;

    show_msg "Setting up Postgres deployment";
    
    if ! docker network ls | grep -Ecq "^.*\s+$PG_SETUP_NETWORK\s+.*$"; then
        show_msg "Creating network:" "$PG_SETUP_NETWORK";
        docker network create "$PG_SETUP_NETWORK";
    fi

    if docker container ls -a | grep -Ecq "^.*\s+$PG_SETUP_CONTAINER\s*$"; then 
        show_msg "Stopping container: $PG_SETUP_CONTAINER";
        docker stop $PG_SETUP_CONTAINER > /dev/null; 
        show_msg "Deleting container: $PG_SETUP_CONTAINER";
        docker rm $PG_SETUP_CONTAINER > /dev/null;
    fi
    if docker volume ls | grep -Ecq "^.*\s+$PG_SETUP_VOLUME\s*$"; then
        show_msg "Deleting volume: $PG_SETUP_CONTAINER";
        docker volume rm $PG_SETUP_VOLUME > /dev/null;
    fi
    
    show_msg "Creating volume:" "$PG_SETUP_VOLUME";
    docker volume create "$PG_SETUP_VOLUME" > /dev/null;

    show_msg "Starting Postgres container"
    docker run \
        -d \
        --restart unless-stopped \
        --network "$PG_SETUP_NETWORK" \
        --name "$PG_SETUP_CONTAINER" \
        -v "$PG_SETUP_VOLUME:/var/lib/postgresql/data" \
        -p "$PG_SETUP_PORT:$PG_SETUP_PORT" \
        -e "POSTGRES_PASSWORD=$PG_SETUP_ROOT_PASSWORD" \
        -e "POSTGRES_PORT=$PG_SETUP_PORT" \
        "$PG_SETUP_IMAGE" \
    > /dev/null;

    show_msg "Restoring dump from:" "$PG_SETUP_DUMPFILE";

    # give the container a chance to start and pause before massive postgres output spam
    read -p "Press enter to continue..."

    restore_pgdump

    show_msg "Stopping temp container"
}

restore_pgdump() {
    local dump_path="/pgdump/pgdump.log";

    run_pg_cmd() {
        local psql_cmd="$@";
        
        docker_cmd=(
            "docker run"
            "--rm"
            "--network '$PG_SETUP_NETWORK'"
            "-v '$PG_SETUP_DUMPFILE:$dump_path'"
            "-e 'PGPASSWORD=$PG_SETUP_ROOT_PASSWORD'" \
            "$PG_SETUP_IMAGE" \
            "psql -h '$PG_SETUP_CONTAINER' -U postgres postgres $psql_cmd" \
        );

        cmd_str=""; for c in "${docker_cmd[@]}"; do cmd_str="${cmd_str:+"$cmd_str "}$c"; done;
        
        show_msg "$(style green)> $cmd_str$(style normal)";
        eval "$cmd_str";
    }
    
    run_pg_cmd "-c \"CREATE USER easuser WITH LOGIN PASSWORD '$PG_SETUP_PASSWORD' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;\"";
    run_pg_cmd "-f $dump_path";
}

#*-----------------------------------------------------------------------------

main $@