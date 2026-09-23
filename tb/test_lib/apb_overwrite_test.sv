class apb_overwrite_test extends apb_base_test;
	`uvm_component_utils(apb_overwrite_test)

	apb_reset_seq rseq;
	apb_write_seq wrseq;
	apb_read_seq rdseq;
	apb_directed_seq dseq;

	function new(string name="apb_overwrite_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_full_name(), "INSIDE OVERWRITE TEST RUN PHASE", UVM_LOW);
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

		`uvm_info(get_full_name(), "PERFORMING ANOTHER WRITE AT THE SAME ADDRESS", UVM_LOW);
		repeat(1) begin
			dseq=apb_directed_seq::type_id::create("dseq");
			dseq.presetn=1;
			dseq.pwrite=1;
			dseq.paddr=32'hBB;
			dseq.pwdata=32'hBAAD_CAFE;
			dseq.start(env_o.agt.seqr);
		end
		`uvm_info(get_full_name(), "PERFORMING A READ AT THE SAME ADDRESS", UVM_LOW);
		repeat(1) begin
			rdseq=apb_read_seq::type_id::create("rdseq");
			rdseq.paddr=32'hBB;
			rdseq.start(env_o.agt.seqr);
		end
		phase.drop_objection(this);
		`uvm_info(get_full_name(), "AFTER OVERWRITE TEST", UVM_LOW);
	endtask
endclass
