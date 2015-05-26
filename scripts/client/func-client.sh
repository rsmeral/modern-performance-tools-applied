
# SHARED

function prepare_env {
    export WS=/root/dp

    export SERVER_HOST=server
    export CLIENT_HOST=client
    export MASTER_HOST=master
}

# CLIENT

function start_monitoring {
    STATS_LOCATION=$WS/stats
    
    dstat -cmdngy --output $STATS_LOCATION/stats-client-$(date +%s) 10 >/dev/null &
}

function stop_monitoring {
    echo $(pkill -f dstat)
}

function prepare_echo_server {
    ssh $SERVER_HOST "dp/prepare-echo-server.sh"
}

function stop_echo_server {
    ssh $SERVER_HOST "dp/stop-echo-server.sh"
}
