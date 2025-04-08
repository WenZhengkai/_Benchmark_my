simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_test/_cache/t0/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_test/_cache/t0/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_test/_cache/t0/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 18 -pos 1 -win $_nTrace1
srcSelect -signal "mul_a" -line 20 -pos 1 -win $_nTrace1
srcSelect -signal "mul_en_in" -line 22 -pos 1 -win $_nTrace1
srcSelect -signal "mul_en_out" -line 24 -pos 1 -win $_nTrace1
srcSelect -signal "mul_out" -line 25 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb_multi_pipe/clk" "/tb_multi_pipe/mul_a\[7:0\]" \
           "/tb_multi_pipe/mul_en_in" "/tb_multi_pipe/mul_en_out" \
           "/tb_multi_pipe/mul_out\[15:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetCursor -win $_nWave2 4777.935970 -snap {("G1" 3)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
debExit
