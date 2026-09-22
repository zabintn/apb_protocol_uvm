class apb_monitor extends uvm_monitor;
	virtual apb_if apb_vif;
	uvm_analysis_port #(apb_seq_item) item_collect_port;
	`uvm_component_utils(apb_monitor)

	function new(string name="apb_monitor", uvm_component parent=null);
		super.new(name, parent);
		item_collect_port=new("item_collect_port", this);
	endfunction

	function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR BUILD PHASE", UVM_LOW);
		if (!uvm_config_db#(virtual apb_if) ::get(this, "", "vif", apb_vif))
			`uvm_fatal(get_type_name(), "Not Set at Top Level");
	endfunction

	function void connect_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR CONNECT PHASE", UVM_LOW);
	endfunction

	task run_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE UVM MONITOR RUN PHASE", UVM_LOW);
	endtask

endclass
