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

# Derleme
VLOG_OPT = -sv -64 +cover=bcestf $(SUPPRESS_CMD) -work $(WORKDIR) $(INC_DIR) -f $(RTL_FILES) -f $(UVM_FILES)

# FAST parametresiyle acc, cover, assert gibi şeyler sadeleştirilir
VOPT_OPT_NORMAL =  -l vopt.log \
			-L /home/v2710_user2/Documents/questa_sim_libs/unisims_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/unimacro_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/secureip \
			-L /home/v2710_user2/Documents/questa_sim_libs/xpm \
			-work work work.tb_top work.glbl -o tb_top_opt \
			+cover=bcestf \
			+acc

VOPT_OPT_FAST =  -l vopt.log \
			-L /home/v2710_user2/Documents/questa_sim_libs/unisims_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/unimacro_ver \
			-L /home/v2710_user2/Documents/questa_sim_libs/secureip \
			-L /home/v2710_user2/Documents/questa_sim_libs/xpm \
			-work work work.tb_top work.glbl -o tb_top_opt \
			+acc=/tb_top/dut  \
			-O5

VSIM_OPT_NORMAL = -t 1ps \
			-assertdebug \
			-do "do ./scripts/wave.do; run $(SIM_TIME)" work.tb_top_opt

VSIM_OPT_FAST = -c -t 1ps \
			+notimingchecks \
			+UVM_NO_RELNOTES \
			-do "run $(SIM_TIME)" work.tb_top_opt

# Ayarlar ve koşullar
setup:
	@echo "File hierarchy is generating..."
	$(VLIB) $(WORKDIR)
	$(VMAP) work $(WORKDIR)

compile: setup
	@echo "Compiling Step I"
	$(VLOG) $(VLOG_OPT) $(DEFINE)

optimize: compile
	@echo "Optimize Design Step II"
ifeq ($(FAST),1)
	$(VOPT) $(VOPT_OPT_FAST)
else
	$(VOPT) $(VOPT_OPT_NORMAL)
endif

simulate: optimize
	@echo "Simulate Design Step III"
ifeq ($(FAST),1)
	$(VSIM) $(VSIM_OPT_FAST)
else
	$(VSIM) $(VSIM_OPT_NORMAL)
endif

clean:
	@echo "Cleaning up..."
	rm -rf work transcript *.log *.vcd *.wlf questa_lib