class apb_seq_item extends uvm_sequence_item;

	rand int paddr;
	rand int pwdata;
	rand int pwrite;
	int pready;
	int psel;
	int penable;
	int presetn;	
	`uvm_object_utils_begin(apb_seq_item)
	`uvm_field_int(paddr, UVM_ALL_ON)
	`uvm_field_int(pwdata, UVM_ALL_ON)
	`uvm_field_int(pwrite, UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name= "apb_seq_item");
		super.new(name);
	endfunction

endclass
