simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t-temp/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t-temp/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/t-temp/dump.fsdb
wvCreateWindow
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64.u_pip_add64" -delim "."
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
debExit
