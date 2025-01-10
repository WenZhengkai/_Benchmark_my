.PHONY: vcs sim clean
#urg -dir simv.vdb  ## merge function coverage
# firefox dashboard.html  # open report
# dve -full64 -cov -covdir coverage/cov.vdb &


######generate html file
#urg -dir coverage/cov.vdb
#cd urgReport
#firefox dashboard.html
TEST_DESIGN = width_8to16
TB = ./testbench.sv

#-cm_name coverage 
all:vcs sim

vcs:
	vcs -full64 -sverilog +v2k -sverilog -debug_access+all \
	-f dut.f \
	-timescale=1ns/1ns \
	-debug_all \
	-cm line+cond+tgl+fsm+assert+branch \
	-cm_dir coverage/cov.vdb \
	-l compile.log 								

sim:
	./simv +fsdb+sva_success \
	-cm line+cond+tgl+fsm+assert+branch \
	-l run.log


verdi:
	verdi \
	-sv \
	-top ${TB} \
	-f dut.f \
	-nologo \
	-ssf sim.fsdb

dve:
	dve -full64 -cov -covdir coverage/cov.vdb &

urg:
	urg -dir coverage/cov.vdb -format both

clean:
	rm -rf *.log *.dat *.fsdb *.key *.h ${COVERAGE_DIR} csrc ${LOG_DIR} simv.daidir \
	simv DVEfiles verdiLog *.conf *.rc verdi_config_file coverage urgReport \
	mod0_red_texts.txt mod1_red_texts.txt extracted_*.txt renew_stimulate.txt 

