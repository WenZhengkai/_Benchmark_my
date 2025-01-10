simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/adder_pipe_64bit/dump.fsdb
wvCreateWindow
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcHBDrag -win $_nTrace1
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64.u_pip_add64" -delim "."
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64.u_pip_add64" -delim "."
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcHBSelect "tb_adder64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64" -delim "."
srcHBSelect "tb_adder64" -win $_nTrace1
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64.u_pip_add64" -delim "."
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {7 15 1 1 1 1} -backward
wvAddSignal -win $_nWave2 "tb_adder64/u_pip_add64/DATA_WIDTH"
wvAddSignal -win $_nWave2 "/tb_adder64/u_pip_add64/clk" \
           "/tb_adder64/u_pip_add64/rst_n" "/tb_adder64/u_pip_add64/i_en" \
           "/tb_adder64/u_pip_add64/adda\[63:0\]" \
           "/tb_adder64/u_pip_add64/addb\[63:0\]" \
           "/tb_adder64/u_pip_add64/result\[64:0\]" \
           "/tb_adder64/u_pip_add64/o_en"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {16 19 1 1 1 1} -backward
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/tb_adder64/u_pip_add64/stage1" \
           "/tb_adder64/u_pip_add64/stage2" "/tb_adder64/u_pip_add64/stage3"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G2" 3)}
srcDeselectAll -win $_nTrace1
srcHBSelect "tb_adder64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64" -delim "."
srcHBSelect "tb_adder64" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "SUM_OUT" -line 36 -pos 1 -win $_nTrace1
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb_adder64.u_pip_add64" -delim "."
srcHBSelect "tb_adder64.u_pip_add64" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {44 48 1 1 1 1} -backward
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/tb_adder64/u_pip_add64/c1" \
           "/tb_adder64/u_pip_add64/c2" "/tb_adder64/u_pip_add64/c3" \
           "/tb_adder64/u_pip_add64/c4"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 4)}
wvSetPosition -win $_nWave2 {("G3" 4)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {37 43 1 1 1 1} -backward
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "tb_adder64/u_pip_add64/STG_WIDTH"
wvAddSignal -win $_nWave2 "/tb_adder64/u_pip_add64/a4_ff1\[15:0\]" \
           "/tb_adder64/u_pip_add64/b4_ff1\[15:0\]" \
           "/tb_adder64/u_pip_add64/a4_ff2\[15:0\]" \
           "/tb_adder64/u_pip_add64/b4_ff2\[15:0\]" \
           "/tb_adder64/u_pip_add64/a4_ff3\[15:0\]" \
           "/tb_adder64/u_pip_add64/b4_ff3\[15:0\]"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 6)}
wvSetPosition -win $_nWave2 {("G4" 6)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSelectSignal -win $_nWave2 {( "G2" 1 )} 
wvSelectSignal -win $_nWave2 {( "G2" 3 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
verdiDockWidgetSetCurTab -dock windowDock_OneSearch
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Decl._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
verdiDockWidgetSetCurTab -dock widgetDock_<Message>
nsMsgSwitchTab -tab cmpl
nsMsgSwitchTab -tab trace
nsMsgSwitchTab -tab general
nsMsgSwitchTab -tab cmpl
nsMsgSwitchTab -tab trace
nsMsgSwitchTab -tab search
nsMsgSwitchTab -tab intercon
nsMsgSwitchTab -tab trace
nsMsgSwitchTab -tab general
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
debExit
