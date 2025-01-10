simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCOutput/_test/_cache/t9/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCOutput/_test/_cache/t9/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCOutput/_test/_cache/t9/dump.fsdb
wvCreateWindow
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {golden_model}
wvAddSignal -win $_nWave2 "/testbench/golden_model/clock" \
           "/testbench/golden_model/reset" \
           "/testbench/golden_model/io_enq_ready" \
           "/testbench/golden_model/io_enq_valid" \
           "/testbench/golden_model/io_enq_bits\[7:0\]" \
           "/testbench/golden_model/io_deq_ready" \
           "/testbench/golden_model/io_deq_valid" \
           "/testbench/golden_model/io_deq_bits\[7:0\]"
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 8)}
wvSetPosition -win $_nWave2 {("golden_model" 8)}
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "golden_model" 3 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 4 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 7 )} 
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "golden_model" 6 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 7 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 6 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 4 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 3 )} 
wvSelectSignal -win $_nWave2 {( "golden_model" 4 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "testbench.golden_model"
srcHBSelect "testbench.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.uut" -delim "."
srcHBSelect "testbench.uut" -win $_nTrace1
schCreateWindow -delim "." -win $_nSchema1 -scope "testbench.uut"
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiDockWidgetSetCurTab -dock windowDock_nSchema_4
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
srcHBSelect "testbench.unnamed\$\$_0" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvRenameGroup -win $_nWave2 {G2} {golden_model#1}
wvAddSignal -win $_nWave2 "/testbench/golden_model/clock" \
           "/testbench/golden_model/reset" \
           "/testbench/golden_model/io_enq_ready" \
           "/testbench/golden_model/io_enq_valid" \
           "/testbench/golden_model/io_enq_bits\[7:0\]" \
           "/testbench/golden_model/io_deq_ready" \
           "/testbench/golden_model/io_deq_valid" \
           "/testbench/golden_model/io_deq_bits\[7:0\]"
wvSetPosition -win $_nWave2 {("golden_model#1" 0)}
wvSetPosition -win $_nWave2 {("golden_model#1" 8)}
wvSetPosition -win $_nWave2 {("golden_model#1" 8)}
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
debExit
