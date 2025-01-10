simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/multi_pipe_8bit/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/multi_pipe_8bit/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/multi_pipe_8bit/dump.fsdb
wvCreateWindow
srcHBSelect "tb_multi_pipe.u1" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {u1}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/clk" "/tb_multi_pipe/u1/rst_n" \
           "/tb_multi_pipe/u1/mul_a\[7:0\]" "/tb_multi_pipe/u1/mul_b\[7:0\]" \
           "/tb_multi_pipe/u1/mul_en_in" "/tb_multi_pipe/u1/mul_en_out" \
           "/tb_multi_pipe/u1/mul_out\[15:0\]"
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 7)}
wvSetPosition -win $_nWave2 {("u1" 7)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 4841.230279 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4820.747876 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4841.706614 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4862.189017 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4881.718750 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4820.747876 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4839.801274 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4856.949333 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4882.671420 -snap {("u1" 1)}
srcHBSelect "tb_multi_pipe.u1" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_multi_pipe.u1" -delim "."
srcHBSelect "tb_multi_pipe.u1" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_en_out_reg" -line 31 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 1)}
wvSetPosition -win $_nWave2 {("u1" 2)}
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/mul_en_out_reg\[2:0\]"
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSelectSignal -win $_nWave2 {( "u1" 6 )} 
wvSetRadix -win $_nWave2 -format Bin
wvSetCursor -win $_nWave2 4819.795206 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4839.801274 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4858.854672 -snap {("u1" 1)}
wvSetCursor -win $_nWave2 4882.195085 -snap {("u1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_a_reg" -line 44 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 1)}
wvSetPosition -win $_nWave2 {("u1" 2)}
wvSetPosition -win $_nWave2 {("u1" 3)}
wvSetPosition -win $_nWave2 {("u1" 4)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/mul_a_reg\[7:0\]"
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSetPosition -win $_nWave2 {("u1" 7)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "sum\[0\]" -line 69 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 1)}
wvSetPosition -win $_nWave2 {("u1" 2)}
wvSetPosition -win $_nWave2 {("u1" 3)}
wvSetPosition -win $_nWave2 {("u1" 4)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 6)}
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 7)}
wvSetPosition -win $_nWave2 {("u1" 8)}
wvSetPosition -win $_nWave2 {("u1" 7)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/sum\[0\]\[15:0\]"
wvSetPosition -win $_nWave2 {("u1" 7)}
wvSetPosition -win $_nWave2 {("u1" 8)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_out_reg" -line 80 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 1)}
wvSetPosition -win $_nWave2 {("u1" 2)}
wvSetPosition -win $_nWave2 {("u1" 3)}
wvSetPosition -win $_nWave2 {("u1" 4)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 8)}
wvSetPosition -win $_nWave2 {("u1" 9)}
wvSetPosition -win $_nWave2 {("u1" 8)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/mul_out_reg\[15:0\]"
wvSetPosition -win $_nWave2 {("u1" 8)}
wvSetPosition -win $_nWave2 {("u1" 9)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "mul_out" -line 87 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 1)}
wvSetPosition -win $_nWave2 {("u1" 2)}
wvSetPosition -win $_nWave2 {("u1" 3)}
wvSetPosition -win $_nWave2 {("u1" 4)}
wvSetPosition -win $_nWave2 {("u1" 5)}
wvSetPosition -win $_nWave2 {("u1" 0)}
wvSetPosition -win $_nWave2 {("u1" 9)}
wvAddSignal -win $_nWave2 "/tb_multi_pipe/u1/mul_out\[15:0\]"
wvSetPosition -win $_nWave2 {("u1" 9)}
wvSetPosition -win $_nWave2 {("u1" 10)}
debExit
