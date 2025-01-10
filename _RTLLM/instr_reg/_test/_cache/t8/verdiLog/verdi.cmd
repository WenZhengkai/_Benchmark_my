simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/instr_reg/_test/_cache/t8/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/instr_reg/_test/_cache/t8/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/instr_reg/_test/_cache/t8/dump.fsdb
wvCreateWindow
srcHBSelect "instr_reg_tb.uut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {uut}
wvAddSignal -win $_nWave2 "/instr_reg_tb/uut/clk" "/instr_reg_tb/uut/rst" \
           "/instr_reg_tb/uut/fetch\[1:0\]" "/instr_reg_tb/uut/data\[7:0\]" \
           "/instr_reg_tb/uut/ins\[2:0\]" "/instr_reg_tb/uut/ad1\[4:0\]" \
           "/instr_reg_tb/uut/ad2\[7:0\]"
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 7)}
wvSetPosition -win $_nWave2 {("uut" 7)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
schCreateWindow -delim "." -win $_nSchema1 -scope "instr_reg_tb"
srcHBSelect "instr_reg_tb.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "instr_reg_tb.uut" -delim "."
srcHBSelect "instr_reg_tb.uut" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "instr_reg_tb.uut"
schSelect -win $_nSchema4 -inst "instr_reg:Always0:15:32:RegCombo"
schSelect -win $_nSchema4 -inst "instr_reg:Always0:15:32:RegCombo"
schPushViewIn -win $_nSchema4
srcSelect -win $_nTrace1 -range {15 32 1 3 1 1}
verdiDockWidgetSetCurTab -dock windowDock_nSchema_4
schSelect -win $_nSchema4 -port "fetch\[1:0\]"
schSelect -win $_nSchema4 -inst "instr_reg:Always0:15:32:RegCombo"
schPushViewIn -win $_nSchema4
srcSelect -win $_nTrace1 -range {15 32 1 3 1 1}
srcDeselectAll -win $_nTrace1
debExit
