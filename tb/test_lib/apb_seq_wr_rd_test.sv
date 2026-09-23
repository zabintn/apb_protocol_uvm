class apb_seq_wr_rd_test extends apb_base_test;
	`uvm_component_utils(apb_seq_wr_rd_test)

	apb_write_seq wrseq;
	apb_read_seq rdseq;

	function new(string name="apb_seq_wr_rd_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		`uvm_info(get_full_name(), "STARTING SEQUENTIAL WRITE-READ TEST", UVM_LOW);
		phase.raise_objection(this);
		for(int i=0; i<5; i++) begin
			wrseq=apb_write_seq::type_id::create("wrseq");
			wrseq.paddr= 32'h20+ i*4;
			wrseq.start(env_o.agt.seqr);
		end
		`uvm_info(get_full_name(), "END OF WRITES, STARTING READS", UVM_LOW);
		for(int j=0; j<5; j++) begin
			rdseq=apb_read_seq::type_id::create("rdseq");
			rdseq.paddr= 32'h20+ j*4;
			rdseq.start(env_o.agt.seqr);
		end
		phase.drop_objection(this);
		`uvm_info(get_full_name(), "END OF SEQUENTIAL WRITE AND READ TEST", UVM_LOW);
	endtask
endclass

		
