class apb_driver extends uvm_driver#(apb_seq_item);
	virtual apb_if apb_vif;
	`uvm_component_utils(apb_driver)

	function new(string name="apb_driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "INSIDE DRIVER BUILD PHASE", UVM_LOW);
		if(!uvm_config_db#(virtual apb_if) :: get(this, "", "vif", apb_vif))
			`uvm_fatal(get_type_name(), "Not Set at Top Level");
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(), "INSIDE DRIVER CONNECT PHASE", UVM_LOW);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			`uvm_info(get_type_name(), "INSIDE DRIVER RUN PHASE", UVM_LOW);
			seq_item_port.get_next_item(req);
			
			//begin setup phase
			apb_vif.psel<=1'b1;
			apb_vif.penable<=1'b0;
			apb_vif.pwrite<=req.pwrite;
			apb_vif.paddr<=req.paddr;
			apb_vif.pwdata<=req.pwdata;
			
			//begin access phase
			
			@(posedge apb_vif.pclk);
			apb_vif.penable<=1'b1;
			
			fork
				wait(apb_vif.pready);
			begin
				repeat(100) @(posedge apb_vif.pclk);
				`uvm_fatal("TIMEOUT", "PREADY NOT HIGH FOR 100 CYCLES");
			end
			join_any
			disable fork;
			
			@(negedge apb_vif.pclk);
			req.pready=apb_vif.pready;
			
			seq_item_port.item_done();
		end
	endtask

endclass

