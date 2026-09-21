class base_test extends uvm_test;
	
	`uvm_component_utils(base_test)
	env env_o;
	base_seq bseq;
	function new(string name= "base_test", uvm_component parent= null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info(get_full_name(), "BEFORE BUILD PHASE OF BASE TEST", UVM_MEDIUM);
		super.build_phase(phase);
		env_o= env::type_id::create("env_o", this);
		`uvm_info(get_full_name(), "AFTER BUILD PHASE OF BASE TEST", UVM_MEDIUM);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_full_name(), "BEFORE RUN PHASE OF BASE TEST", UVM_MEDIUM);
		bseq= base_seq::type_id::create("bseq", this);
		`uvm_info(get_full_name(), "AFTER RUN PHASE OF BASE TEST", UVM_MEDIUM);
	endtask
	
endclass
