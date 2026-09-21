package apb_agent_pkg;
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	`include "../agent/apb_driver.sv"
	`include "../agent/apb_monitor.sv"	
	`include "../seq_lib/apb_seq_item.sv"	
	`include "../seq_lib/apb_base_seq.sv"
	`include "../seq_lib/apb_seqcr.sv"
	`include "../agent/apb_agent.sv"
endpackage
