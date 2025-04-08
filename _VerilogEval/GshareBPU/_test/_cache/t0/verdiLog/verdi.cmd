simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_VerilogEval/GshareBPU/_test/_cache/t0/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_VerilogEval/GshareBPU/_test/_cache/t0/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_VerilogEval/GshareBPU/_test/_cache/t0/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "tb_mismatch" -line 210 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb/tb_mismatch"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 224 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "areset" -line 225 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 224 -pos 1 -win $_nTrace1
srcSelect -signal "predict_valid" -line 226 -pos 1 -win $_nTrace1
srcSelect -signal "predict_pc" -line 227 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "stats1.errors_predict_taken" -line 260 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "predict_taken_ref" -line 281 -pos 2 -win $_nTrace1
srcSelect -signal "predict_taken_dut" -line 281 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/tb/predict_taken_ref" "/tb/predict_taken_dut"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 2)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 224 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/tb/good1/clk"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetCursor -win $_nWave2 73.681266 -snap {("G2" 1)}
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 75.200467 -snap {("G2" 2)}
wvSetCursor -win $_nWave2 69.503462 -snap {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "train_taken" -line 229 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "train_mispredicted" -line 230 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "predict_history_ref" -line 234 -pos 1 -win $_nTrace1
srcSelect -signal "predict_history_dut" -line 247 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/tb/predict_history_ref\[6:0\]" \
           "/tb/predict_history_dut\[6:0\]"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 2)}
srcHBSelect "tb.good1" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb.good1" -delim "."
srcHBSelect "tb.good1" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "predict_history" -line 306 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "predict_taken" -line 305 -pos 1 -win $_nTrace1
srcActiveTrace "tb.good1.predict_taken" -win $_nTrace1
srcActiveTrace "tb.good1.predict_taken" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht\[predict_index\]\[1\]" -line 342 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht\[predict_index\]\[1\]" -line 342 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht\[predict_index\]\[1\]" -line 342 -pos 1 -win $_nTrace1
srcActiveTrace "tb.good1.pht" -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht\[i\]" -line 327 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht\[train_index\]" -line 333 -pos 1 -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
srcShowDefine -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "pht" -line 316 -pos 1 -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
srcActiveTrace "tb.good1.pht\[127:0\]" -win $_nTrace1
debExit
