class apb_scoreboard extends uvm_scoreboard;
	uvm_analysis_imp #(apb_seq_item, apb_scoreboard) item_collect_export;
	`uvm_component_utils(apb_scoreboard)

	function new(string name="apb_scoreboard", uvm_component parent= null);
		super.new(name, parent);
		item_collect_export=new("item_collect_export", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD BUILD PHASE", UVM_LOW);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD CONNECT PHASE", UVM_LOW);
	endfunction

	function void write(apb_seq_item req);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD WRITE FUNCTION", UVM_LOW);
	endfunction



	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD RUN PHASE", UVM_LOW);
	endtask

endclass
