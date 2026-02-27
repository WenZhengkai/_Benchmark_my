export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-verilog
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-backtest-verilog-claude.xlsx
export LLMCALL=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/gpt-thread-batch.py
export BATCH_DIR=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch

$SC/s1-temp.sh
$SC/s2-dutfile.sh
(cd $BATCH_DIR && python3 $LLMCALL 10 $EX Dpram)
$SC/s4-copy.sh $EX Dpram
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s9-vcs.sh