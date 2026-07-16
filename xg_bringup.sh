#!/bin/bash

# xg_bringup.sh - System bringup script for XGBot
# Manages modules: robot, vehsolver, vehplanning, lidar, perception

set -e

# ────────────────────────────────────────────────────────────────
#  Enter script directory
# ────────────────────────────────────────────────────────────────
cd "$(dirname "$0")"

# ────────────────────────────────────────────────────────────────
#  Supported modules
# ────────────────────────────────────────────────────────────────
ALL_MODULES=(
    robot
    vehsolver
    vehplanning
    lidar
    perception
)

# ────────────────────────────────────────────────────────────────
#  Module start functions (fill in actual launch commands)
# ────────────────────────────────────────────────────────────────

start_robot() {
    echo "[start] robot"
    # TODO: add actual command
}

start_vehsolver() {
    echo "[start] vehsolver"
    # TODO: add actual command
}

start_vehplanning() {
    echo "[start] vehplanning"
    # TODO: add actual command
}

start_lidar() {
    echo "[start] lidar"
    # TODO: add actual command
}

start_perception() {
    echo "[start] perception"
    # TODO: add actual command
}

# ────────────────────────────────────────────────────────────────
#  Module stop functions (fill in actual shutdown commands)
# ────────────────────────────────────────────────────────────────

stop_robot() {
    echo "[stop] robot"
    # TODO: add actual command
}

stop_vehsolver() {
    echo "[stop] vehsolver"
    # TODO: add actual command
}

stop_vehplanning() {
    echo "[stop] vehplanning"
    # TODO: add actual command
}

stop_lidar() {
    echo "[stop] lidar"
    # TODO: add actual command
}

stop_perception() {
    echo "[stop] perception"
    # TODO: add actual command
}

# ────────────────────────────────────────────────────────────────
#  Core commands
# ────────────────────────────────────────────────────────────────

do_start() {
    local modules=("${@}")
    if [ ${#modules[@]} -eq 0 ]; then
        modules=("${ALL_MODULES[@]}")
    fi

    for mod in "${modules[@]}"; do
        if type "start_${mod}" &>/dev/null; then
            "start_${mod}"
        else
            echo "[warn] unknown module: $mod"
        fi
    done
}

do_stop() {
    local modules=("${@}")
    if [ ${#modules[@]} -eq 0 ]; then
        modules=("${ALL_MODULES[@]}")
    fi

    for mod in "${modules[@]}"; do
        if type "stop_${mod}" &>/dev/null; then
            "stop_${mod}"
        else
            echo "[warn] unknown module: $mod"
        fi
    done
}

do_restart() {
    do_stop "$@"
    sleep 1
    do_start "$@"
}

# ────────────────────────────────────────────────────────────────
#  Usage
# ────────────────────────────────────────────────────────────────

usage() {
    echo "Usage: $0 {start|stop|restart} [module...]"
    echo ""
    echo "Commands:"
    echo "  start      Start modules (all if none specified)"
    echo "  stop       Stop  modules (all if none specified)"
    echo "  restart    Stop then start modules"
    echo ""
    echo "Available modules:"
    for m in "${ALL_MODULES[@]}"; do
        echo "  $m"
    done
    echo ""
    echo "Examples:"
    echo "  $0 start                        # start all"
    echo "  $0 start robot lidar            # start specific modules"
    echo "  $0 restart perception           # restart one module"
}

# ────────────────────────────────────────────────────────────────
#  Main
# ────────────────────────────────────────────────────────────────

main() {
    if [ $# -eq 0 ]; then
        # Default: start all modules
        do_start
        exit 0
    fi

    cmd="$1"
    shift

    case "$cmd" in
        start)
            do_start "$@"
            ;;
        stop)
            do_stop "$@"
            ;;
        restart)
            do_restart "$@"
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            echo "Error: unknown command '$cmd'"
            usage
            exit 1
            ;;
    esac
}

main "$@"
