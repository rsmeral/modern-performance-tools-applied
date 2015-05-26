export GRINDER_HOME=/root/dp/grinder

java -classpath $GRINDER_HOME/lib/grinder.jar -Djava.net.preferIPv4Stack=true -Dgrinder.console.httpHost=0.0.0.0 net.grinder.Console -headless </dev/null 2>&1 >/dev/null &
