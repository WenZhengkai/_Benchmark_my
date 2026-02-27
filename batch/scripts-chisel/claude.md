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
