.PHONY: vcs sim clean tcl

TEST_DESIGN = dut

TCL_FILE = wave_gen.tcl

tcl:
	@if [ -f $(TCL_FILE) ]; then \
		echo "Removing existing $(TCL_FILE)"; \
		rm $(TCL_FILE); \
    fi
	@echo 'call {$$fsdbDumpfile("dump.fsdb")}' > $(TCL_FILE)
	@echo 'call {$$fsdbDumpvars("+all")}' >> $(TCL_FILE)
	@echo 'run' >> $(TCL_FILE)
	@echo "$(TCL_FILE) created."

vcs:
		vcs \
		-cpp /usr/bin/g++-4.4 -cc /usr/bin/gcc-4.4 \
		-sverilog +v2k -timescale=1ns/1ns \
		-debug_all \
		-l compile.log \
		+plusarg_save +libext+.v+.V+.sv+.svh -sverilog +memcbk \
		-P ${Verdi_HOME}/share/PLI/VCS/LINUX64/novas.tab \
		${Verdi_HOME}/share/PLI/VCS/LINUX64/pli.a \
		-kdb -lca\
		${TEST_DESIGN}.v testbench.sv

sim: tcl
		./simv -ucli -i wave_gen.tcl -l sim.log

verdi:
		verdi -ssf dump.fsdb &

clean:
		rm -rf *.log  csrc  simv*  *.key *.vpd  DVEfiles coverage *.vdb output.txt novas.* *.fsdb verdiLog ${TCL_FILE}
