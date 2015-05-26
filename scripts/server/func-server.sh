
# SHARED

function prepare_env {
    export WS=/root/dp
    export JBOSS_HOME=$WS/jboss-eap-6.3
    export JBOSS_ZIP=$WS/jboss-eap-6.3.0.zip

    export SERVER_HOST=server
    export CLIENT_HOST=client
    export MASTER_HOST=master
}

# SERVER

function start_monitoring {
    STATS_LOCATION=$WS/stats
    PERIOD=${1:-10}
    OPTIONS=${2:-cmdngy}

    dstat -${OPTIONS} --output $STATS_LOCATION/stats-server-$(date +%s) $PERIOD </dev/null >/dev/null &
}

function stop_monitoring {
    echo $(pkill -f dstat)
}

function prepare_jboss_eap {
    rm -rf $JBOSS_HOME
    unzip -q $JBOSS_ZIP -d $WS/
    rm -f $JBOSS_HOME/standalone/configuration/application*properties
    rm -f $JBOSS_HOME/standalone/configuration/mgmt*properties
    rm -f $JBOSS_HOME/standalone/configuration/standalone-full.xml
    cp $WS/application*properties $JBOSS_HOME/standalone/configuration/
    cp $WS/mgmt*properties $JBOSS_HOME/standalone/configuration/
    cp $WS/standalone-full.xml $JBOSS_HOME/standalone/configuration/
    BUILD_ID=dontKillMe sh $JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -Djboss.bind.address.management=0.0.0.0 -c standalone-full.xml </dev/null >/dev/null 2>&1 &
    sleep 10
}


function stop_jboss_eap {
    echo $(pkill -f jboss-modules)
    sleep 5
    echo $(pkill -9 -f jboss-modules)
}

function deploy_echoapp {
    $JBOSS_HOME/bin/jboss-cli.sh "connect, deploy $WS/echoapp.war"
}

function deploy_et {
    $JBOSS_HOME/bin/jboss-cli.sh "connect, deploy $WS/mysql-connector-java-5.1.17.jar"
    $JBOSS_HOME/bin/jboss-cli.sh "connect, deploy $WS/ds-expense-tracker.war"
}
