simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-util/Queue_testcase/_test/_cache/t9/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-util/Queue_testcase/_test/_cache/t9/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-util/Queue_testcase/_test/_cache/t9/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "match" -line 22 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/testbench/match"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 4664281.342339 -snap {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 1 -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_enq_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcSelect -signal "io_enq_ready" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_enq_ready_golden" \
           "/testbench/io_enq_ready"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_deq_valid_golden" -line 23 -pos 2 -win $_nTrace1
srcSelect -signal "io_deq_valid" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_deq_valid_golden" \
           "/testbench/io_deq_valid"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_deq_bits_golden" -line 23 -pos 2 -win $_nTrace1
srcSelect -signal "io_deq_bits" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_deq_bits_golden\[7:0\]" \
           "/testbench/io_deq_bits\[7:0\]"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G4" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_count_golden" -line 23 -pos 2 -win $_nTrace1
srcSelect -signal "io_count" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_count_golden\[4:0\]" \
           "/testbench/io_count\[4:0\]"
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvSetPosition -win $_nWave2 {("G5" 2)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvSelectGroup -win $_nWave2 {G4}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G5" 1)}
wvZoomOut -win $_nWave2
debExit
