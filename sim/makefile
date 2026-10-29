# ----------------------------------------
# Vivado xsim-based Makefile
# Compile -> Elaborate -> Simulate flow
# ----------------------------------------

TEST ?= apb_base_test
UVM_VERBOSITY ?= UVM_MEDIUM
SEED ?= random
CLK_FREQUENCY ?= 100

RTL_DIR   = ../rtl
TB_DIR    = .
SIM_DIR   = .

TOP       = apb_tb_top
SNAPSHOT  = apb_tb_top_snap
TIMESCALE = 1ns/1ps
RTL_SRC   = $(RTL_DIR)/apb_slave_rtl.f
RTL_SRC_X = rtl_xsim.f
TB_SRC    = $(TB_DIR)/compile.f

TESTLIST = apb_single_wr_rd_test apb_overwrite_test apb_seq_wr_rd_test apb_conseq_wr_rd_test apb_invalid_addr_rd_test apb_invalid_addr_wr_test
NUM_RUNS ?=1
COV_TYPE= sbct
COV_DIR=cov_db

REGR_SEEDS ?= 1
REGRESS_DIR   ?= regr
MERGE_DIR  ?= cov_merged

.PHONY: compile elaborate simulate run clean regress regress_run regress_merge

$(RTL_SRC_X): $(RTL_SRC)
	sed -e 's|^+incdir+\(.*\)|-i $(RTL_DIR)/\1|' \
		-e 's|^src/|$(RTL_DIR)/src/|' $< > $@

# Step 1: Compile RTL + testbench sources
compile: $(RTL_SRC_X)
	xvlog --sv -L uvm -f $(RTL_SRC_X) -f $(TB_SRC)

# Step 2: Elaborate design into a simulation snapshot
elaborate: compile
	xelab $(TOP) -timescale=$(TIMESCALE) -s $(SNAPSHOT)\
                -cc_type $(COV_TYPE)\
                -cov_db_name $(SNAPSHOT) -cov_db_dir $(COV_DIR)\
                -L uvm -debug typical

# Step 3: Run simulation:
simulate: elaborate
	xsim $(SNAPSHOT) -runall\
                -testplusarg "UVM_TESTNAME=$(TEST)" \
                -testplusarg "UVM_VERBOSITY=$(UVM_VERBOSITY)"\
                -testplusarg "CLK_FREQUENCY=$(CLK_FREQUENCY)"\
                -log xsim_$(TEST).log

gui_sim: elaborate
	xsim $(SNAPSHOT) -gui \
                -testplusarg "UVM_TESTNAME=$(TEST)" \
                -testplusarg "UVM_VERBOSITY=$(UVM_VERBOSITY)"\
                -log xsim_$(TEST).log

cov_report:
	rm -rf $(COV_DIR)/xsim.covdb/$(SNAPSHOT)
	xcrg -cov_db_name $(SNAPSHOT) -cov_db_dir $(COV_DIR) \
             -report_dir cov_html -report_format html


# Convenience target: does all three in order
all: compile elaborate simulate cov_report
allg: compile elaborate gui_sim
regress: compile elaborate
	@mkdir -p $(REGRESS_DIR)
	@rm -f $(REGRESS_DIR)/summary.log
	@rm -rf $(COV_DIR)
	@for t in $(TESTLIST); do \
	  for i in $$(seq 1 $(NUM_RUNS)); do \
	    seed=$$(( $(SEED) + i )); \
	    logf=$(REGRESS_DIR)/$${t}_run$${i}.log; \
	    echo "=== Running $$t (run $$i/$(NUM_RUNS)) seed=$$seed ==="; \
	    xsim $(SNAPSHOT) -runall \
	      -testplusarg "UVM_TESTNAME=$$t" \
	      -testplusarg "UVM_VERBOSITY=$(UVM_VERBOSITY)" \
	      -testplusarg "CLK_FREQUENCY=$(CLK_FREQUENCY)" \
	      -sv_seed $$seed \
	      -cov_db_dir $(COV_DIR) -cov_db_name $${t}_run$${i} \
	      -log $$logf; \
	    if [ -f $$logf ] \
	       && grep -q "UVM Report Summary" $$logf \
	       && grep -qE "^UVM_ERROR :[[:space:]]+0[[:space:]]*$$" $$logf \
	       && grep -qE "^UVM_FATAL :[[:space:]]+0[[:space:]]*$$" $$logf; then \
	      echo "$$t (run $$i seed=$$seed) : PASS" | tee -a $(REGRESS_DIR)/summary.log; \
	    else \
	      echo "$$t (run $$i seed=$$seed) : FAIL" | tee -a $(REGRESS_DIR)/summary.log; \
	    fi; \
	  done; \
	done
	@echo ""; echo "=== REGRESSION SUMMARY ==="; cat $(REGRESS_DIR)/summary.log
	@$(MAKE) regress_report
	@! grep -q ": FAIL" $(REGRESS_DIR)/summary.log
regress_report:
	xcrg -report_format text -dir $(COV_DIR) -report_dir $(COV_DIR)/report
	@grep -m1 "Coverage Score" $(COV_DIR)/report/functionalCoverageReport/xcrg_func_cov_report.txt | \
		awk -F',' '{printf "MERGED FUNCTIONAL COVERAGE = %.2f%%\n", $$2}'


clean:
	rm -rf xsim.dir *.log *.jou *.pb *.wdb .Xil xelab.pb webtalk*                                                                                            
