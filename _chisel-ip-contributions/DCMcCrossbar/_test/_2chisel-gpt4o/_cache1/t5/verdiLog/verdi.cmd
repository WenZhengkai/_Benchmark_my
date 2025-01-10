simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCMcCrossbar/_test/_cache/t5/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCMcCrossbar/_test/_cache/t5/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCMcCrossbar/_test/_cache/t5/dump.fsdb
wvCreateWindow
srcHBSelect "testbench.uut" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {golden_model}
wvAddSignal -win $_nWave2 "/testbench/golden_model/clock" \
           "/testbench/golden_model/reset" \
           "/testbench/golden_model/io_sel_0\[1:0\]" \
           "/testbench/golden_model/io_sel_1\[1:0\]" \
           "/testbench/golden_model/io_c_0_ready" \
           "/testbench/golden_model/io_c_0_valid" \
           "/testbench/golden_model/io_c_0_bits\[7:0\]" \
           "/testbench/golden_model/io_c_1_ready" \
           "/testbench/golden_model/io_c_1_valid" \
           "/testbench/golden_model/io_c_1_bits\[7:0\]" \
           "/testbench/golden_model/io_p_0_ready" \
           "/testbench/golden_model/io_p_0_valid" \
           "/testbench/golden_model/io_p_0_bits\[7:0\]" \
           "/testbench/golden_model/io_p_1_ready" \
           "/testbench/golden_model/io_p_1_valid" \
           "/testbench/golden_model/io_p_1_bits\[7:0\]"
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 16)}
wvSetPosition -win $_nWave2 {("golden_model" 16)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
srcHBSelect "testbench.uut" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 3)}
wvSetPosition -win $_nWave2 {("golden_model" 2)}
wvSetPosition -win $_nWave2 {("golden_model" 1)}
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 1)}
wvSetPosition -win $_nWave2 {("golden_model" 2)}
wvSetPosition -win $_nWave2 {("golden_model" 3)}
wvSetPosition -win $_nWave2 {("golden_model" 4)}
wvSetPosition -win $_nWave2 {("golden_model" 5)}
wvSetPosition -win $_nWave2 {("golden_model" 6)}
wvSetPosition -win $_nWave2 {("golden_model" 7)}
wvSetPosition -win $_nWave2 {("golden_model" 8)}
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 11)}
wvSetPosition -win $_nWave2 {("golden_model" 12)}
wvSetPosition -win $_nWave2 {("golden_model" 13)}
wvSetPosition -win $_nWave2 {("golden_model" 14)}
wvSetPosition -win $_nWave2 {("golden_model" 15)}
wvSetPosition -win $_nWave2 {("golden_model" 16)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvRenameGroup -win $_nWave2 {G2} {uut}
wvAddSignal -win $_nWave2 "/testbench/uut/clock" "/testbench/uut/reset" \
           "/testbench/uut/io_sel_0\[1:0\]" "/testbench/uut/io_sel_1\[1:0\]" \
           "/testbench/uut/io_c_0_ready" "/testbench/uut/io_c_0_valid" \
           "/testbench/uut/io_c_0_bits\[7:0\]" "/testbench/uut/io_c_1_ready" \
           "/testbench/uut/io_c_1_valid" "/testbench/uut/io_c_1_bits\[7:0\]" \
           "/testbench/uut/io_p_0_ready" "/testbench/uut/io_p_0_valid" \
           "/testbench/uut/io_p_0_bits\[7:0\]" "/testbench/uut/io_p_1_ready" \
           "/testbench/uut/io_p_1_valid" "/testbench/uut/io_p_1_bits\[7:0\]"
wvSetPosition -win $_nWave2 {("uut" 0)}
wvSetPosition -win $_nWave2 {("uut" 16)}
wvSetPosition -win $_nWave2 {("uut" 16)}
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 {( "uut" 12 )} 
wvSelectSignal -win $_nWave2 {( "uut" 13 )} 
wvScrollDown -win $_nWave2 3
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
