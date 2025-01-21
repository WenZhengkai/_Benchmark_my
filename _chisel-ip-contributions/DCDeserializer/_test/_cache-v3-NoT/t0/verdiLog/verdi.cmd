simSetSimulator "-vcssv" -exec \
           "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCDeserializer/_test/_cache/t0/simv" \
           -args "-ucli"
debImport "-dbdir" \
          "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCDeserializer/_test/_cache/t0/simv.daidir"
debLoadSimResult \
           /home/kai/ChiselProject/Benchmarks/_Benchmark_my/_chisel-ip-contributions/DCDeserializer/_test/_cache/t0/dump.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "match" -line 22 -pos 1 -win $_nTrace1
wvAddSignal -win $_nWave2 "/testbench/match"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "clock" -line 9 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/testbench/clock"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits_golden" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits" -line 23 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready_golden" -line 23 -pos 3 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid_golden" -line 23 -pos 3 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits_golden" -line 23 -pos 3 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready_golden" -line 23 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_dataIn_ready_golden"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvAddSignal -win $_nWave2 "/testbench/io_dataIn_ready"
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetCursor -win $_nWave2 8570.886350 -snap {("G2" 1)}
wvSetCursor -win $_nWave2 10129.229323 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 9263.483227 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 9523.207056 -snap {("G2" 1)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 254875.650665 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 255914.545980 -snap {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready_golden" -line 23 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid_golden" -line 23 -pos 2 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvAddSignal -win $_nWave2 "/testbench/io_dataOut_valid_golden"
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 23 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvAddSignal -win $_nWave2 "/testbench/io_dataOut_valid"
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetCursor -win $_nWave2 234444.042799 -snap {("G1" 1)}
srcHBSelect "testbench.uut" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits" -line 200 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 199 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 198 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_valid" -line 196 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 195 -pos 1 -win $_nTrace1
srcActiveTrace "testbench.golden_model.io_dataIn_ready" -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/io_dataIn_ready"
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G5" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/dataValid"
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G4" 2)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/io_dataOut_ready"
wvSetPosition -win $_nWave2 {("G4" 2)}
wvSetPosition -win $_nWave2 {("G4" 3)}
wvSetCursor -win $_nWave2 16622.325043 -snap {("G4" 3)}
wvSelectSignal -win $_nWave2 {( "G4" 1 )} 
wvSelectSignal -win $_nWave2 {( "G4" 3 )} 
wvSelectSignal -win $_nWave2 {( "G4" 2 )} 
wvSetCursor -win $_nWave2 179728.889532 -snap {("G4" 1)}
wvSetCursor -win $_nWave2 179728.889532 -snap {("G4" 1)}
wvSetCursor -win $_nWave2 179728.889532 -snap {("G4" 1)}
wvSetCursor -win $_nWave2 300933.342973 -snap {("G1" 0)}
wvSetCursor -win $_nWave2 199121.602082 -snap {("G1" 2)}
wvSetCursor -win $_nWave2 191849.334876 -snap {("G4" 2)}
wvSetCursor -win $_nWave2 201891.989589 -snap {("G4" 3)}
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G4" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
srcHBSelect "testbench.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.uut" -delim "."
srcHBSelect "testbench.uut" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 26 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 26 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G4" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G4" 0)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvAddSignal -win $_nWave2 "/testbench/uut/dataValid"
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
srcTraceLoad "testbench.uut.dataValid" -win $_nTrace1
srcActiveTrace "testbench.uut.dataValid" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 2 -win $_nTrace1
srcTraceLoad "testbench.golden_model.dataValid" -win $_nTrace1
srcActiveTrace "testbench.golden_model.dataValid" -win $_nTrace1
srcActiveTrace "testbench.golden_model.dataValid" -win $_nTrace1
wvSetCursor -win $_nWave2 250373.770966 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 244486.697513 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 235482.938115 -snap {("G3" 2)}
wvSetCursor -win $_nWave2 234097.744361 -snap {("G3" 1)}
wvSetCursor -win $_nWave2 243794.100636 -snap {("G3" 1)}
wvSetCursor -win $_nWave2 234790.341238 -snap {("G3" 1)}
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/io_dataOut_valid" -driver
wvScrollDown -win $_nWave2 2
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver" \
           2 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/uut/dataValid" -driver
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 3
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 0
wvScrollUp -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           1 )} 
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" 1)}
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" 2)}
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" 1)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" 1)}
wvSelectGroup -win $_nWave2 \
           {G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver}
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           1 )} 
wvSelectGroup -win $_nWave2 \
           {G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver}
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           1 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           2 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           3 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           4 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           5 )} 
wvSelectSignal -win $_nWave2 {( "G3" 12 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           1 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           2 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           5 )} 
wvSelectSignal -win $_nWave2 {( "G3" 12 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver" \
           3 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/uut/_T_2" -driver
wvScrollDown -win $_nWave2 2
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver//testbench/uut/_T_2@225000(1ps)#ActiveDriver" \
           3 )} 
wvScrollUp -win $_nWave2 10
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/io_dataOut_valid_golden" \
           -driver
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver" \
           2 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/golden_model/dataValid" \
           -driver
wvScrollDown -win $_nWave2 3
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver//testbench/golden_model/dataValid@235000(1ps)#ActiveDriver" \
           3 )} 
wvShowOneTraceSignals -win $_nWave2 -signal "/testbench/golden_model/_T_2" \
           -driver
wvScrollDown -win $_nWave2 2
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver//testbench/golden_model/dataValid@235000(1ps)#ActiveDriver//testbench/golden_model/_T_2@235000(1ps)#ActiveDriver" \
           3 )} 
wvSelectSignal -win $_nWave2 \
           {( "G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver" \
           2 )} 
wvSelectAll -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver//testbench/golden_model/dataValid@235000(1ps)#ActiveDriver" 0)}
wvSelectGroup -win $_nWave2 {G5}
wvSelectAll -win $_nWave2
wvSelectGroup -win $_nWave2 \
           {G3//testbench/io_dataOut_valid@225000(1ps)#ActiveDriver//testbench/uut/dataValid@225000(1ps)#ActiveDriver//testbench/uut/_T_2@225000(1ps)#ActiveDriver}
wvSelectGroup -win $_nWave2 {G5}
wvSelectGroup -win $_nWave2 {G5}
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 195 -pos 1 -win $_nTrace1
srcAction -pos 194 3 9 -win $_nTrace1 -name "io_dataIn_ready" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 216 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/io_dataIn_ready"
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/dataValid"
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvAddSignal -win $_nWave2 "/testbench/golden_model/io_dataOut_ready"
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {216 216 8 11 1 1}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {216 216 11 17 1 7}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 215 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
srcAction -pos 215 16 7 -win $_nTrace1 -name "io_dataOut_ready" -ctrlKey off
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 199 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_bits" -line 200 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 198 -pos 1 -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 217 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 216 -pos 2 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
srcActiveTrace "testbench.golden_model.io_dataOut_ready" -win $_nTrace1
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.golden_model" -delim "."
srcHBSelect "testbench.golden_model" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 216 -pos 1 -win $_nTrace1
srcTraceLoad "testbench.golden_model.io_dataOut_ready" -win $_nTrace1
srcActiveTrace "testbench.golden_model.io_dataOut_ready" -win $_nTrace1
srcActiveTrace "testbench.io_dataOut_ready" -win $_nTrace1
srcActiveTrace "testbench.io_dataOut_ready" -win $_nTrace1
srcActiveTrace "testbench.io_dataOut_ready" -win $_nTrace1
srcTraceLoad "testbench.io_dataOut_ready" -win $_nTrace1
srcTraceLoad "testbench.golden_model.io_dataOut_ready" -win $_nTrace1
srcTraceLoad "testbench.golden_model.io_dataOut_ready" -win $_nTrace1
srcNextTraced
srcHBSelect "testbench.golden_model" -win $_nTrace1
wvSetCursor -win $_nWave2 7618.565645 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 25626.084442 -snap {("G1" 3)}
wvSetCursor -win $_nWave2 198082.706767 -snap {("G1" 3)}
srcHBSelect "testbench.uut" -win $_nTrace1
srcSetScope -win $_nTrace1 "testbench.uut" -delim "."
srcHBSelect "testbench.uut" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 25 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "dataValid" -line 25 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/testbench/uut/dataValid"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataIn_ready" -line 25 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvAddSignal -win $_nWave2 "/testbench/uut/io_dataIn_ready"
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_valid" -line 24 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "io_dataOut_ready" -line 25 -pos 1 -win $_nTrace1
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 \
           {("G3//testbench/io_dataOut_valid_golden@235000(1ps)#ActiveDriver" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvAddSignal -win $_nWave2 "/testbench/uut/io_dataOut_ready"
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSelectSignal -win $_nWave2 {( "G2" 1 )} 
debExit
