simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/LIFObuffer/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/LIFObuffer/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/LIFObuffer/dump.fsdb
wvCreateWindow
srcHBSelect "LIFObuffer_tb.uut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {uut}
wvAddSignal -win $_nWave2 "/LIFObuffer_tb/uut/dataIn\[3:0\]" \
           "/LIFObuffer_tb/uut/RW" "/LIFObuffer_tb/uut/EN" \
           "/LIFObuffer_tb/uut/Rst" "/LIFObuffer_tb/uut/Clk" \
           "/LIFObuffer_tb/uut/EMPTY" "/LIFObuffer_tb/uut/FULL" \
           "/LIFObuffer_tb/uut/dataOut\[3:0\]"
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 8)}
wvSetPosition -win $_nWave2 {("uut" 8)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "uut" 6 )} 
wvSelectSignal -win $_nWave2 {( "uut" 4 )} 
wvSelectSignal -win $_nWave2 {( "uut" 2 )} 
wvSelectSignal -win $_nWave2 {( "uut" 1 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "uut" 8 )} 
wvSelectSignal -win $_nWave2 {( "uut" 6 )} 
wvSelectSignal -win $_nWave2 {( "uut" 4 )} 
wvSetPosition -win $_nWave2 {("uut" 4)}
wvSetPosition -win $_nWave2 {("uut" 3)}
wvSetPosition -win $_nWave2 {("uut" 2)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSetPosition -win $_nWave2 {("uut" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSelectSignal -win $_nWave2 {( "uut" 5 )} 
wvSetPosition -win $_nWave2 {("uut" 5)}
wvSetPosition -win $_nWave2 {("uut" 4)}
wvSetPosition -win $_nWave2 {("uut" 3)}
wvSetPosition -win $_nWave2 {("uut" 2)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSetPosition -win $_nWave2 {("uut" 2)}
wvSelectSignal -win $_nWave2 {( "uut" 3 )} 
wvSelectSignal -win $_nWave2 {( "uut" 4 )} 
wvSelectSignal -win $_nWave2 {( "uut" 5 )} 
srcHBSelect "LIFObuffer_tb.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "LIFObuffer_tb.uut" -delim "."
srcHBSelect "LIFObuffer_tb.uut" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "SP" -line 13 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSetPosition -win $_nWave2 {("uut" 2)}
wvSetPosition -win $_nWave2 {("uut" 3)}
wvSetPosition -win $_nWave2 {("uut" 4)}
wvSetPosition -win $_nWave2 {("uut" 1)}
wvSetPosition -win $_nWave2 {("uut" 4)}
wvSetPosition -win $_nWave2 {("uut" 5)}
wvSetPosition -win $_nWave2 {("uut" 4)}
wvAddSignal -win $_nWave2 "/LIFObuffer_tb/uut/SP\[2:0\]"
wvSetPosition -win $_nWave2 {("uut" 4)}
wvSetPosition -win $_nWave2 {("uut" 5)}
debExit
