class seqcr extends uvm_sequencer#(seq_item);
	`uvm_component_utils(seqcr)

	function new(string name="seqcr", uvm_component parent= null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "INSIDE SEQUENCER BUILD PHASE", UVM_MEDIUM);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(), "INSIDE SEQUENCER CONNECT PHASE", UVM_MEDIUM);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE SEQUENCER RUN PHASE", UVM_MEDIUM);
	endtask
endclass
