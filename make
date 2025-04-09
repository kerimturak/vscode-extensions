
VSIM   = vsim
VOPT   = vopt
VLOG   = vlog
VLIB   = vlib
VMAP   = vmap
PYTHON = python

WORKDIR = work

DEFINE = +define+

INC_DIR = +incdir+./srcs/incl \
		  +incdir+/tools/xlinx_new/Vivado/2018.1/data/xilinx_vip/include \
		  +incdir+/home/v2710_user2/Documents/questa/questa/srcs \
		  +incdir+uvm_macros.svh \
		  +incdir+uvm_pkg.sv

RTL_FILES = ./scripts/default_libs.f
UVM_FILES = ./scripts/uvm.f

SUPPRESS_CMD = -suppress vlog-2583 -suppress vlog-8386 -suppress vlog-2575 -svinputport=relaxed

SIM_TIME = 100ns;

VLOG_OPT = -sv -64 +cover=bcestf $(SUPPRESS_CMD) -work $(WORKDIR) $(INC_DIR) -f $(RTL_FILES) -f $(UVM_FILES)

VOPT_OPT =  -l vopt.log  \
			-L /home/v2710_user2/Documents/questa_sim_libs/unisims_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/unimacro_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/secureip \
			-L /home/v2710_user2/Documents/questa_sim_libs/xpm \
			-work work work.tb_top work.glbl -o tb_top_opt \
			+cover=bcestf \
			+acc 

VSIM_OPT =  -t 1ps \
			-assertdebug \
			-do "do ./scripts/wave.do; run $(SIM_TIME)" work.tb_top_opt

setup:
	@echo "File hierarchy is generating..."
	$(VLIB) $(WORKDIR)
	$(VMAP) work $(WORKDIR)

compile: setup
	@echo "Compiling Step I"
	$(VLOG) $(VLOG_OPT) $(DEFINE)

optimize: compile
	@echo "Optimize Design Step II"
	$(VOPT) $(VOPT_OPT) 

simulate: optimize
	@echo "Simulate Design Step III"
	vsim $(VSIM_OPT)


clean:
	@echo "Cleaning up..."
	rm -rf work transcript *.log *.vcd *.wlf questa_lib
