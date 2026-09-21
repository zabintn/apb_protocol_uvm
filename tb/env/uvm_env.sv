class env extends uvm_env;
	`uvm_component_utils(env)
	agent agt;
	scoreboard sb;

	function new(string name = "env", uvm_component parent= null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "BEFORE ENVIRONMENT CONSTRUCTOR", UVM_MEDIUM);
		super.build_phase(phase);
		agt=agent::type_id::create("agt", this);
		sb=scoreboard::type_id::create("sb", this);
		`uvm_info(get_type_name(), "AFTER ENVIRONMENT CONSTRUCTOR", UVM_MEDIUM);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(), "INSIDE CONNECT PHASE OF UVM ENVIRONMENT", UVM_MEDIUM);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE RUN PHASE OF UVM ENVIRONMENT", UVM_MEDIUM);
	endtask

endclass
