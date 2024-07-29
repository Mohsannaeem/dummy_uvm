## #####################################
## GLOBAL VARIABLES
## #####################################
WHOAMI := $(shell whoami)
PWD := $(shell pwd)
DATE := $(shell date '+%Y_%m%d_%H%M_%S')

TEST_DIR := $(shell pwd)
COMP_DIR := $(DUMMY_UVM)
SUB_DIRS := $(shell ls $(REG_DIR) )

# SIMULATOR = questa for questa and vcs for vcs
SIMULATOR :=questa
ifeq ($(SIMULATOR), questa)
	BUILD_CMD := vlog
  BUILD_CMD := $(BUILD_CMD) -L /EDA/mentor/questasim/uvm-1.2
endif

ifeq ($(SIMULATOR), questa)
	OPTM_CMD := vopt 
endif
DATABASE := tb_cuboid_prcr_db

## ####################################
## TEST VARIABLES
## ####################################
USR_OPT := $(addprefix , $(OPT))
USR_LOG := $(addprefix , $(LOG))
## Get test name from test.sv if not supplied
ifeq "$(TEST_NAME)" ""
  TEST_NAME := $(shell grep -se "^class.*base_test" test.sv | sed -e "s/^class//" | sed -e "s/extends .*base_test;//" | sed -e "s/ *//g")
endif

# SEED
SEED_NUM := $(shell python3 -c 'from random import randint; print(randint(0, 1000))')
SEED_OPT := $(addprefix , $(SEED))
ifeq "$(SEED_OPT)" ""
else
  SEED_NUM := $(SEED_OPT)
endif

# Wave options
GUI  := 1

ifeq ($(SIMULATOR), questa)
	SIM_CMD   := vsim 
	BUILD_OPT := $(BUILD_OPT) -sv -mfcu
	BUILD_OPT := $(BUILD_OPT) -work $(COMP_DIR)/work
	BUILD_OPT := $(BUILD_OPT) +define+VSIM
	BUILD_OPT := $(BUILD_OPT) -timescale=1ns/100fs
# 	BUILD_OPT := $(BUILD_OPT) -l $(COMP_DIR)/compile.log
else ifeq ($(SIMULATOR), vcs)
	BUILD_OPT := vcs
	BUILD_OPT := $(BUILD_OPT) +define+VCS
	BUILD_OPT := $(BUILD_OPT) -sverilog
	BUILD_OPT := $(BUILD_OPT) -sv_pragma
	BUILD_OPT := $(BUILD_OPT) -top tb_cuboid_prcr
	BUILD_OPT := $(BUILD_OPT) -full64
	BUILD_OPT := $(BUILD_OPT) -LDFLAGS -Wl,--no-as-needed 
	BUILD_OPT := $(BUILD_OPT) -cm line+cond+fsm+tgl+path
	BUILD_OPT := $(BUILD_OPT) -lca
	BUILD_OPT := $(BUILD_OPT) +v2k
	BUILD_OPT := $(BUILD_OPT) -debug_all
	BUILD_OPT := $(BUILD_OPT) -Mdirectory=$(COMP_DIR)/csrc
	BUILD_OPT := $(BUILD_OPT) -Mupdate
	BUILD_OPT := $(BUILD_OPT) +nbaopt
	BUILD_OPT := $(BUILD_OPT) -ntb_opts uvm-1.2+dep_check
	BUILD_OPT := $(BUILD_OPT) -timescale=1ns/100fs
	BUILD_OPT := $(BUILD_OPT) ${VCS_HOME}/etc/uvm-1.2
	BUILD_OPT := $(BUILD_OPT) -o ${COMP_DIR}/simv
# 	BUILD_OPT := $(BUILD_OPT) -l ./compile.log
else
	XCMD      := xrun
	BUILD_OPT := $(BUILD_OPT) -64bit -elaborate -libverbose -uvm -uvmhome CDNS-1.2 -sv
	BUILD_OPT := $(BUILD_OPT)	-licqueue -nowarn CSINFI -vlog_ext +.h -timescale 1ps/1fs
	BUILD_OPT := $(BUILD_OPT)	-xmlibdirpath ${COMP_DIR} -access +rwc -top tb_cuboid_prcr 
endif

# Build defines includes and files
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_agent
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_config
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_env
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_interface
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_sequence_lib                           
BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/dummy_test_suit
# BUILD_OPT := $(BUILD_OPT) +incdir+$(DUMMY_UVM)/verif/cuboid_1/uvm_tb
# BUILD_OPT := $(BUILD_OPT) +incdir+$(TEST_DIR)
# BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/design/cuboid_1/cuboid_prcr.sv
# BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/verif/cuboid_1/uvm_tb/interface/cuboid_out_intf.sv
# BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/verif/cuboid_1/uvm_tb/interface/cuboid_inp_intf.sv

BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/dummy_packages/dummy_seq_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/dummy_packages/dummy_env_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(DUMMY_UVM)/dummy_packages/dummy_test_pkg.sv
# Optimization options 
ifeq ($(SIMULATOR), questa)
  OPTM_OPT := +acc tb_cuboid_prcr -o $(DATABASE) -designfile design.bin -work $(COMP_DIR)/work
  SIM_OPT := $(SIM_OPT) -work $(COMP_DIR)/work
endif
ifeq ($(SIMULATOR), vcs)
  VCS_SIM_ARG = +UVM_CONFIG_DB_TRACE
  SIMV_CMD= $(COMP_DIR)/simv
endif

# Simulation options
ifeq ($(GUI), 1)
	ifeq ($(SIMULATOR),xcelium)
	 	SIM_OPT := $(SIM_OPT)
	else
		SIM_OPT := $(DATABASE) $(SIM_OPT)
	endif
else
		ifeq ($(SIMULATOR),xcelium)
	 	SIM_OPT := $(SIM_OPT)
	else
	SIM_OPT := -c $(DATABASE) $(SIM_OPT)
	endif
endif

# ifeq ($(SIMULATOR), 1)
SIM_OPT   := $(SIM_OPT) +UVM_TESTNAME=$(TEST_NAME)
SIM_OPT   := $(SIM_OPT) +UVM_CONFIG_DB_TRACE +UVM_REPORT
SIM_OPT   := $(SIM_OPT) -l $(TEST_NAME).log
ELAB_OPTS := $(ELAB_OPTS) -classdebug

ifeq ($(SIMULATOR), vcs)
  ifeq ($(GUI), 1)
    SIM_OPT := $(SIM_OPT) -gui
  endif
  SIM_OPT := $(SIM_OPT) -cm line+cond+fsm+tgl+path
  SIM_OPT := $(SIM_OPT) -cm_dir $(COMP_DIR)/simv.vdb
  SIM_OPT := $(SIM_OPT) -cm_name $(TEST_NAME)
  SIM_OPT := $(SIM_OPT) -lca
endif

ifeq ($(SIMULATOR), questa)
  ifeq ($(GUI), 1)
    SIM_OPT := $(SIM_OPT) -do "do wave.do; run -a; q"
  else
    SIM_OPT := $(SIM_OPT) -do "run -a; q"
  endif
endif

ifeq ($(SIMULATOR), xcelium)
	ifeq ($(GUI), 1)
		SIM_OPT := $(SIM_OPT) -gui 
	else
		SIM_OPT := $(SIM_OPT)
	endif
endif
#opening coverage in DVE
cov:
	dve -covdir $(COMP_DIR)/simv.vdb -full64
# Compile
compile:
ifeq ($(SIMULATOR), xcelium) 
	$(XCMD) $(BUILD_OPT) -uvmaccess
else
	$(BUILD_CMD) $(BUILD_OPT)
endif

# Optimize
optimize:
	$(OPTM_CMD) $(OPTM_OPT)

# Run without wave
run: build run_sim
run_sim: 
ifeq ($(SIMULATOR), questa) 
	$(SIM_CMD) $(SIM_OPT) $(USR_OPT) $(ELAB_OPTS)
else ifeq ($(SIMULATOR), vcs) 
	$(SIMV_CMD) $(SIM_OPT) $(USR_OPT) $(ELAB_OPTS)
else
	$(XCMD) -R -xmlibdirpath $(COMP_DIR) $(USR_OPT) $(SIM_OPT) 
endif

# Compile and optimize
build: compile optimize

# Build and run
build_run_sim: build run_sim

# Clean
clean:
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/cm.log 
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/DVEfiles/ 
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/inter.vpd 
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/*.log 
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/ucli.key
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/wlft*
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/vsim.wlf
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/*.bin
	@rm -rf $(DUMMY_UVM)/verif/cuboid_1/test/*/tr_db.log
	@rm -rf $(COMP_DIR)/compile.log
	@rm -rf $(COMP_DIR)/work
	@rm -rf $(COMP_DIR)/design.bin
	@rm -rf $(COMP_DIR)/csrc  
	@rm -rf $(COMP_DIR)/simv  
	@rm -rf $(COMP_DIR)/simv.cst  
	@rm -rf $(COMP_DIR)/simv.daidir  
	@rm -rf $(COMP_DIR)/simv.vdb  
	@rm -rf $(COMP_DIR)/vc_hdrs.h
	@rm -rf $(COMP_DIR)/xcelium.d 
	@rm -rf $(COMP_DIR)/waves.shm 
	@rm -rf $(COMP_DIR)/.simvision 
	@rm -rf $(COMP_DIR)/*history 
	@rm -rf $(COMP_DIR)/*.d/ 
	@rm -rf $(COMP_DIR)/*.log 
	@rm -rf $(COMP_DIR)/scrbrd_fd 
	@rm -rf $(COMP_DIR)/*.key

