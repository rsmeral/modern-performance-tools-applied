export PERFCAKE_HOME=/root/dp/perfcake
export SCENARIOS_DIR=/root/dp/testing/perfcake/scenarios
export SCENARIO=$1

$PERFCAKE_HOME/bin/perfcake.sh -sd $SCENARIOS_DIR/$SCENARIO -md $SCENARIOS_DIR/$SCENARIO -s $SCENARIOS_DIR/$SCENARIO/${SCENARIO}.xml 
