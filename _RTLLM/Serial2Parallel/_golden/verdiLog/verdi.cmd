simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/Serial2Parallel/_golden/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/Serial2Parallel/_golden/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_RTLLM/Serial2Parallel/_golden/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "error" -line 59 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "error" -line 57 -pos 1 -win $_nTrace1
srcSelect -signal "clk" -line 71 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "error" -line 57 -pos 1 -win $_nTrace1
srcSelect -signal "clk" -line 71 -pos 2 -win $_nTrace1
srcSelect -signal "rst_n" -line 72 -pos 2 -win $_nTrace1
srcSelect -signal "din_serial" -line 73 -pos 2 -win $_nTrace1
srcSelect -signal "dout_parallel" -line 74 -pos 2 -win $_nTrace1
srcSelect -signal "din_valid" -line 75 -pos 2 -win $_nTrace1
srcSelect -signal "dout_valid" -line 76 -pos 2 -win $_nTrace1
wvAddSignal -win $_nWave2 "/tb/error\[31:0\]" "/tb/clk" "/tb/rst_n" \
           "/tb/din_serial" "/tb/dout_parallel\[7:0\]" "/tb/din_valid" \
           "/tb/dout_valid"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 6 )} 
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 94.777991 -snap {("G1" 6)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 96.293630 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 94.171735 -snap {("G1" 6)}
wvSetCursor -win $_nWave2 104.680169 -snap {("G2" 0)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "din_valid" -line 75 -pos 2 -win $_nTrace1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 126.909548 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 135.094002 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 144.895137 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 155.100443 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 165.305749 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 174.298544 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 184.604892 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 194.608113 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 204.712377 -snap {("G1" 2)}
srcDeselectAll -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetCursor -win $_nWave2 135.599215 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 145.703478 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 154.999401 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 165.103664 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 174.803757 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 184.503850 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 195.214369 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 205.318632 -snap {("G1" 2)}
srcHBSelect "tb.u0" -win $_nTrace1
srcSetScope -win $_nTrace1 "tb.u0" -delim "."
srcHBSelect "tb.u0" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "cnt" -line 18 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvAddSignal -win $_nWave2 "/tb/u0/cnt\[3:0\]"
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetCursor -win $_nWave2 13.438670 -snap {("G1" 4)}
debExit
