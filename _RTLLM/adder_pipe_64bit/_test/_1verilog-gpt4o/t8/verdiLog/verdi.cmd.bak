simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t1/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t1/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t1/dump.fsdb
wvCreateWindow
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {u_pip_add64}
wvAddSignal -win $_nWave2 "/tb_adder64/u_pip_add64/clk" \
           "/tb_adder64/u_pip_add64/rst_n" "/tb_adder64/u_pip_add64/i_en" \
           "/tb_adder64/u_pip_add64/adda\[63:0\]" \
           "/tb_adder64/u_pip_add64/addb\[63:0\]" \
           "/tb_adder64/u_pip_add64/result\[64:0\]" \
           "/tb_adder64/u_pip_add64/o_en"
wvSetPosition -win $_nWave2 {("u_pip_add64" 0)}
wvSetPosition -win $_nWave2 {("u_pip_add64" 7)}
wvSetPosition -win $_nWave2 {("u_pip_add64" 7)}
debExit
