export GRINDER_HOME=/root/dp/grinder
export TESTS_DIR=/root/dp/testing/grinder/tests
export TEST_NAME=$1

java -classpath "$GRINDER_HOME/lib/grinder.jar:$TESTS_DIR/$TEST_NAME/lib/*" -Djava.net.preferIPv4Stack=true net.grinder.Grinder $TESTS_DIR/$TEST_NAME/grinder.properties </dev/null >/dev/null 2>&1 &
