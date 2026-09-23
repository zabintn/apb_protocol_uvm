package apb_test_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import apb_agent_pkg::*;
	import apb_env_pkg::*;
	`include "../test_lib/apb_base_test.sv"
	`include "../test_lib/apb_dummy_test.sv"
	`include "../test_lib/apb_single_wr_rd_test.sv"
	`include "../test_lib/apb_overwrite_test.sv"
	`include "../test_lib/apb_seq_wr_rd_test.sv"
	`include "../test_lib/apb_conseq_wr_rd_test.sv"
	`include "../test_lib/apb_invalid_addr_wr_test.sv"
	`include "../test_lib/apb_invalid_addr_rd_test.sv"
endpackage
