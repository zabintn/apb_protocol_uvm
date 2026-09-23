class apb_single_wr_rd_test extends apb_base_test;
	`uvm_component_utils(apb_single_wr_rd_test)

	apb_reset_seq rseq;
	apb_write_seq wrseq;
	apb_read_seq rdseq;
	apb_directed_seq dseq;

	function new(string name="apb_single_wr_rd_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_full_name(), "INSIDE SINGLE WRITE_READ TEST RUN PHASE", UVM_LOW);
		phase.raise_objection(this);
		`uvm_info(get_full_name(), "PERFORMING A WRITE", UVM_LOW);
		repeat(1) begin
			dseq=apb_directed_seq::type_id::create("dseq");
			dseq.presetn=1;
			dseq.pwrite=1;
			dseq.paddr=32'hBB;
			dseq.pwdata=32'hDEAD_BEEF;
			dseq.start(env_o.agt.seqr);
		end
		`uvm_info(get_full_name(), "PERFORMING A READ AT THE SAME ADDRESS", UVM_LOW);
		repeat(1) begin
			dseq=apb_directed_seq::type_id::create("dseq");
			dseq.presetn=1;
			dseq.pwrite=0;
			dseq.paddr=32'hBB;
			dseq.start(env_o.agt.seqr);
		end
		phase.drop_objection(this);
	endtask
endclass
