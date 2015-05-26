function prepare_env {
    export WS=/root/dp

    export SERVER_HOST=server
    export CLIENT_HOST=client
    export MASTER_HOST=master
}

function start_monitoring {
    STATS_LOCATION=$WS/stats
    PERIOD=${1:-10}
    OPTIONS=${2:-cmdngy}

    dstat -${OPTIONS} --output $STATS_LOCATION/stats-master-$(date +%s) $PERIOD </dev/null >/dev/null &
}

function stop_monitoring {
    echo $(pkill -f dstat)
}
