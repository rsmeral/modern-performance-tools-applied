export BENCHMARKS_DIR=/root/dp/testing/faban
export DEPLOY_DIR=$BENCHMARKS_DIR/deploy
export BENCHMARK_NAME=${1:-"INVALID"}

rm -rf $BENCHMARKS_DIR/$BENCHMARK_NAME
mkdir $BENCHMARKS_DIR/$BENCHMARK_NAME

unzip -q $DEPLOY_DIR/${BENCHMARK_NAME}.jar -d $BENCHMARKS_DIR/$BENCHMARK_NAME
# rm -f $BENCHMARK_DEPLOYMENT
echo $BENCHMARK_NAME
