simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_ChatChisel/BHT/_test/_cache/t0/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_ChatChisel/BHT/_test/_cache/t0/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_ChatChisel/BHT/_test/_cache/t0/dump.fsdb
wvCreateWindow
srcHBSelect "BHT_tb.print_report" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.print_report" -delim "."
srcHBSelect "BHT_tb.print_report" -win $_nTrace1
srcHBSelect "BHT_tb.goldenModule" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.goldenModule" -delim "."
srcHBSelect "BHT_tb.goldenModule" -win $_nTrace1
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.dut" -delim "."
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcHBSelect "BHT_tb" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb" -delim "."
srcHBSelect "BHT_tb" -win $_nTrace1
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.dut" -delim "."
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcHBSelect "BHT_tb" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb" -delim "."
srcHBSelect "BHT_tb" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "ref_bht_pred_pc" -line 57 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/BHT_tb/ref_bht_pred_pc\[31:0\]"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dut_bht_pred_pc" -line 44 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/BHT_tb/dut_bht_pred_pc\[31:0\]"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "dut_matched" -line 99 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/BHT_tb/dut_matched"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dut_valid" -line 100 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/BHT_tb/dut_valid"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "ref_valid" -line 100 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvAddSignal -win $_nWave2 "/BHT_tb/ref_valid"
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetCursor -win $_nWave2 40353.614183 -snap {("G4" 1)}
wvSetCursor -win $_nWave2 44623.837906 -snap {("G4" 2)}
wvSetCursor -win $_nWave2 33734.767412 -snap {("G3" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dut_bht_pred_pc" -line 101 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvAddSignal -win $_nWave2 "/BHT_tb/dut_bht_pred_pc\[31:0\]"
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "ref_bht_pred_pc" -line 101 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G6" 0)}
wvSetPosition -win $_nWave2 {("G5" 1)}
wvAddSignal -win $_nWave2 "/BHT_tb/ref_bht_pred_pc\[31:0\]"
wvSetPosition -win $_nWave2 {("G5" 1)}
wvSetPosition -win $_nWave2 {("G5" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dut_matched" -line 99 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "ref_matched" -line 99 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvAddSignal -win $_nWave2 "/BHT_tb/ref_matched"
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
srcHBSelect "BHT_tb.goldenModule" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.goldenModule" -delim "."
srcHBSelect "BHT_tb.goldenModule" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_bht_pred_pc" -line 165 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_matched" -line 163 -pos 1 -win $_nTrace1
srcActiveTrace "BHT_tb.goldenModule.io_matched" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_valid" -line 218 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "bhtTable_valid_bhtEntry_data" -line 218 -pos 1 -win $_nTrace1
srcActiveTrace "BHT_tb.goldenModule.bhtTable_valid_bhtEntry_data" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "bhtTable_valid\[bhtTable_valid_bhtEntry_addr\]" -line 205 -pos \
          1 -win $_nTrace1
srcActiveTrace "BHT_tb.goldenModule.bhtTable_valid\[0:15\]" -win $_nTrace1
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcSetScope -win $_nTrace1 "BHT_tb.dut" -delim "."
srcHBSelect "BHT_tb.dut" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_valid" -line 9 -pos 1 -win $_nTrace1
srcActiveTrace "BHT_tb.dut.io_valid" -win $_nTrace1
debExit
