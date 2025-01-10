simSetSimulator "-vcssv" -exec "/home/kai/ChiselProject/Benchmarks/TESTBASE/simv" \
           -args "-ucli"
debImport "-dbdir" "/home/kai/ChiselProject/Benchmarks/TESTBASE/simv.daidir"
debLoadSimResult /home/kai/ChiselProject/Benchmarks/TESTBASE/dump.fsdb
wvCreateWindow
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcHBDrag -win $_nTrace1
wvRenameGroup -win $_nWave2 {G1} {golden_model}
wvAddSignal -win $_nWave2 "/testbench/golden_model/clock" \
           "/testbench/golden_model/reset" \
           "/testbench/golden_model/io_in_0\[15:0\]" \
           "/testbench/golden_model/io_in_1\[15:0\]" \
           "/testbench/golden_model/io_in_2\[15:0\]" \
           "/testbench/golden_model/io_in_3\[15:0\]" \
           "/testbench/golden_model/io_in_4\[15:0\]" \
           "/testbench/golden_model/io_in_5\[15:0\]" \
           "/testbench/golden_model/io_in_6\[15:0\]" \
           "/testbench/golden_model/io_in_7\[15:0\]" \
           "/testbench/golden_model/io_weights_0\[15:0\]" \
           "/testbench/golden_model/io_weights_1\[15:0\]" \
           "/testbench/golden_model/io_weights_2\[15:0\]" \
           "/testbench/golden_model/io_weights_3\[15:0\]" \
           "/testbench/golden_model/io_weights_4\[15:0\]" \
           "/testbench/golden_model/io_weights_5\[15:0\]" \
           "/testbench/golden_model/io_weights_6\[15:0\]" \
           "/testbench/golden_model/io_weights_7\[15:0\]" \
           "/testbench/golden_model/io_out\[15:0\]"
wvSetPosition -win $_nWave2 {("golden_model" 0)}
wvSetPosition -win $_nWave2 {("golden_model" 19)}
wvSetPosition -win $_nWave2 {("golden_model" 19)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
srcHBSelect "testbench.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.uut" -delim "."
srcHBSelect "testbench.uut" -win $_nTrace1
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
