class driver extends uvm_driver#(seq_item);
	`uvm_component_utils(driver)

	function new(string name="driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "INSIDE DRIVER BUILD PHASE", UVM_MEDIUM);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(), "INSIDE DRIVER CONNECT PHASE", UVM_MEDIUM);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE DRIVER RUN PHASE", UVM_MEDIUM);
	endtask

endclass

