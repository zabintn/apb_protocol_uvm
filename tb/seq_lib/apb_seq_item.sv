class apb_seq_item extends uvm_sequence_item;
	
	function new(string name= "apb_seq_item");
		super.new(name);
	endfunction

	`uvm_object_utils(apb_seq_item)
endclass
