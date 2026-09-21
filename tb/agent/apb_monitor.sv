class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)

	function new(string name="apb_monitor", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR BUILD PHASE", UVM_LOW);
	endfunction

	function void connect_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR CONNECT PHASE", UVM_LOW);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR RUN PHASE", UVM_LOW);
	endtask

endclass
