class apb_invalid_addr_wr_test extends apb_base_test;
	`uvm_component_utils(apb_invalid_addr_wr_test)

	apb_write_seq wrseq;
	apb_read_seq rdseq;

	function new(string name="apb_invalid_addr_wr_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_full_name(), "INSIDE INVALID ADDRESS WRITE TEST RUN PHASE", UVM_LOW);
		phase.raise_objection(this);
		`uvm_info(get_full_name(), "PERFORMING A WRITE", UVM_LOW);
		repeat(1) begin
			wrseq=apb_write_seq::type_id::create("wrseq");
			wrseq.paddr=32'h500;
			wrseq.start(env_o.agt.seqr);
		end

		`uvm_info(get_full_name(), "PERFORMING A READ AT THE SAME ADDRESS", UVM_LOW);
		repeat(1) begin
			rdseq=apb_read_seq::type_id::create("rdseq");
			rdseq.paddr=32'h500;
			rdseq.start(env_o.agt.seqr);
		end
		phase.drop_objection(this);
		`uvm_info(get_full_name(), "AFTER OVERWRITE TEST", UVM_LOW);
	endtask
endclass
