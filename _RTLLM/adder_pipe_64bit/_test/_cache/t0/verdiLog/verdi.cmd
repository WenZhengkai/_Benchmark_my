simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/_cache/t0/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/_cache/t0/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/_test/_cache/t0/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "CLK" -line 66 -pos 1 -win $_nTrace1
srcSelect -signal "i_en" -line 68 -pos 1 -win $_nTrace1
srcSelect -signal "PLUS_A" -line 69 -pos 1 -win $_nTrace1
srcSelect -signal "o_en" -line 72 -pos 1 -win $_nTrace1
srcSelect -signal "SUM_OUT" -line 71 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb_adder64/CLK" "/tb_adder64/i_en" \
           "/tb_adder64/PLUS_A\[63:0\]" "/tb_adder64/o_en" \
           "/tb_adder64/SUM_OUT\[64:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetCursor -win $_nWave2 20.027876 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 18.064359 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 8.639476 -snap {("G1" 2)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 9.424883 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 14.530028 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 17.278952 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 21.598690 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 25.133021 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 30.434518 -snap {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "PLUS_A" -line 36 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "error" -line 36 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "PLUS_A" -line 36 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
wvSetCursor -win $_nWave2 28.078297 -snap {("G1" 2)}
debExit
