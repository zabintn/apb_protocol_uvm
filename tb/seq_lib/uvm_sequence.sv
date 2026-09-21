class base_seq extends uvm_sequence#(seq_item);
	seq_item req;
	`uvm_object_utils(base_seq);

	function new(string name="base_seq");
		super.new(name);
	endfunction
	task body();
		`uvm_info(get_type_name(), "BASE SEQUENCE INSIDE BODY", UVM_MEDIUM);
	endtask
endclass
