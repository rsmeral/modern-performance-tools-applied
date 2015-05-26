export FABAN_HOME=/root/dp/faban
export FABAN_CP=$FABAN_HOME/lib/fabancommon.jar:$FABAN_HOME/lib/fabandriver.jar
export FABAN_BENCHMARKS=/root/dp/testing/faban
export FABAN_POLICY=$FABAN_HOME/config/faban.policy

export BENCHMARK_NAME=$1

java -cp "${FABAN_CP}:${FABAN_BENCHMARKS}/${BENCHMARK_NAME}/lib/*" -Djava.security.policy=$FABAN_POLICY -Dbenchmark.config=$FABAN_BENCHMARKS/$BENCHMARK_NAME/META-INF/run.xml com.sun.faban.driver.engine.MasterImpl
