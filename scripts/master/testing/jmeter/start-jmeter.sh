export JMETER_HOME=/root/dp/jmeter
export TESTS_DIR=/root/dp/testing/jmeter/tests
export TEST_NAME=$1

$JMETER_HOME/bin/jmeter -n -R${CLIENT_HOST} -t $TESTS_DIR/$TEST_NAME/test.jmx 
