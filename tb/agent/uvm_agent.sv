class agent extends uvm_agent;
	`uvm_component_utils(agent)
	driver drv;
	seqcr seqr;
	monitor mon;

	function new(string name= "agent", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "BEFORE AGENT BUILD PHASE", UVM_MEDIUM);
		if(get_is_active == UVM_ACTIVE) begin
			drv=driver::type_id::create("drv", this);
			seqr=seqcr::type_id::create("seqr", this);
		end

		mon=monitor::type_id::create("mon", this);
		`uvm_info(get_type_name(), "AFTER AGENT BUILD PHASE", UVM_MEDIUM);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(), "INSIDE AGENT CONNECT PHASE", UVM_MEDIUM);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE AGENT RUN PHASE", UVM_MEDIUM);
	endtask
endclass
