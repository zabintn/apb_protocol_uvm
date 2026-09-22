class apb_dummy_seq extends apb_base_seq;
	`uvm_object_utils(apb_dummy_seq);

	typedef enum {WRITE, READ} oper;
	oper op;


	function new(string name="apb_dummy_seq");
		super.new(name);
	endfunction

	task body();
		super.body();
		req=apb_seq_item::type_id::create("req");
		start_item(req);
		case(op)
			WRITE: req.randomize() with {pwrite ==1;};
			READ: req.randomize() with {pwrite ==0;};
		endcase
		finish_item(req);
	endtask
endclass

	
