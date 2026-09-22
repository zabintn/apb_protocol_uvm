class apb_dummy_test extends apb_base_test;
	`uvm_component_utils(apb_dummy_test)
	apb_dummy_seq dseq;
	function new(string name= "dummy_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_full_name(), "BEFORE RUN PHASE OF DUMMY TEST", UVM_LOW);
		phase.raise_objection(this);

		`uvm_info(get_type_name(), "REQUESTING 60 WRITES", UVM_LOW);
		repeat(10) begin
			dseq= apb_dummy_seq::type_id::create("dseq");
			dseq.op=apb_dummy_seq::WRITE;
			dseq.start(env_o.agt.seqr);
		end
		`uvm_info(get_type_name(), "REQUESTED 60 WRITES", UVM_LOW);
		`uvm_info(get_type_name(), "REQUESTING 60 READS", UVM_LOW);
		repeat(10) begin
			dseq= apb_dummy_seq::type_id::create("dseq");
			dseq.op=apb_dummy_seq::READ;
			dseq.start(env_o.agt.seqr);
		end
		`uvm_info(get_type_name(), "REQUESTED 60 READS", UVM_LOW);
		phase.drop_objection(this);
		`uvm_info(get_full_name(), "AFTER RUN PHASE OF DUMMY TEST", UVM_LOW);
	endtask
endclass
