.PHONY: vcs sim clean

TEST_DESIGN = MyFir

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
		../${TEST_DESIGN}.v ./vsrc/${TEST_DESIGN}_golden.v ./vsrc/testbench.sv

sim:
		./simv -ucli -i wave_gen.tcl -l sim.log

verdi:
		verdi -ssf dump.fsdb &

clean:
		rm -rf *.log  csrc  simv*  *.key *.vpd  DVEfiles coverage *.vdb output.txt novas.* *.fsdb
