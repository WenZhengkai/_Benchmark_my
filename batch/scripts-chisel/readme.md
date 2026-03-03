export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-backtest-ds.xlsx
export LLMCALL=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/gpt-thread-batch.py
export BATCH_DIR=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch

$SC/s1-temp.sh
$SC/s2-dutfile.sh
(cd $BATCH_DIR && python3 $LLMCALL 10 $EX Dpram)
$SC/s4-copy.sh $EX Dpram
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh


##deepseek

export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-base-deepseek.xlsx


export Name=$(basename "$(dirname "$PWD")")
$SC/s1-temp.sh
$SC/s2-dutfile.sh
$SC/s4-copy.sh $EX $Name
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh
mv ../_test/_cache ../_test/_chisel-ds

## claude

export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-base-claude.xlsx

export Name=$(basename "$(dirname "$PWD")")
$SC/s1-temp.sh
$SC/s2-dutfile.sh
$SC/s4-copy.sh $EX $Name
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh
mv ../_test/_cache ../_test/_chisel-claude


## gpt-5.2

export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-base-gpt_5_2.xlsx

export Name=$(basename "$(dirname "$PWD")")
$SC/s1-temp.sh
$SC/s2-dutfile.sh
$SC/s4-copy.sh $EX $Name
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh
mv ../_test/_cache ../_test/_chisel-gpt_5_2

## claude-4-5

export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-base-claude-sonnet-4-5.xlsx

export Name=$(basename "$(dirname "$PWD")")
$SC/s1-temp.sh
$SC/s2-dutfile.sh
$SC/s4-copy.sh $EX $Name
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh
mv ../_test/_cache ../_test/_chisel-claude-4-5

## codex

export SC=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/scripts-chisel
export EX=/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/results-base-codex.xlsx

export Name=$(basename "$(dirname "$PWD")")
$SC/s1-temp.sh
$SC/s2-dutfile.sh
$SC/s4-copy.sh $EX $Name
$SC/s5-annote.sh
$SC/s6-fix.sh dut
$SC/s7-mov.sh
$SC/s8-comp.sh
$SC/s9-vcs.sh
mv ../_test/_cache ../_test/_chisel-codex

