export FABAN_HOME=/root/dp/faban
export FABAN_CP=$FABAN_HOME/lib/fabancommon.jar:$FABAN_HOME/lib/fabandriver.jar
export FABAN_POLICY=$FABAN_HOME/config/faban.policy

java -cp ${FABAN_CP} -Djava.security.policy=${FABAN_POLICY} com.sun.faban.common.RegistryImpl </dev/null >/dev/null &
