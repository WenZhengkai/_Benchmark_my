simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_golden/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_golden/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/_test_module_temp/_golden/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 30 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_a" -line 36 -pos 1 -win $_nTrace1
srcSelect -signal "mul_en_in" -line 38 -pos 1 -win $_nTrace1
srcSelect -signal "clk" -line 30 -pos 1 -win $_nTrace1
srcSelect -signal "error" -line 61 -pos 1 -win $_nTrace1
srcSelect -signal "mul_out" -line 61 -pos 1 -win $_nTrace1
srcSelect -signal "expected_product" -line 61 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb_multi_pipe/mul_a\[7:0\]" \
           "/tb_multi_pipe/mul_en_in" "/tb_multi_pipe/clk" \
           "/tb_multi_pipe/error\[31:0\]" "/tb_multi_pipe/mul_out\[15:0\]" \
           "/tb_multi_pipe/expected_product\[15:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_en_out" -line 61 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/mul_en_out"
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetCursor -win $_nWave2 4831.506331 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 4750.474779 -snap {("G1" 3)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSetCursor -win $_nWave2 4807.461920 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4820.123100 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4841.014047 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4858.106640 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4878.997588 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4799.865212 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4817.590864 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4836.582634 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4859.372758 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 4877.098411 -snap {("G1" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSetCursor -win $_nWave2 5500.028472 -snap {("G1" 3)}
debExit
