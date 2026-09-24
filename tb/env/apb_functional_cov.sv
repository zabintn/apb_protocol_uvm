class apb_functional_cov extends uvm_subscriber #(apb_seq_item);
	`uvm_component_utils(apb_functional_cov)

	apb_seq_item req;

	covergroup apb_cg;
		cp_pwrite: coverpoint req.pwrite {
			bins write={1};
			bins read={0};
			}
		cp_paddr: coverpoint req.paddr {
			bins valid={[32'h0000_0000:32'h0000_00FF]};
			bins invalid={[32'h0000_0010:$]};
			}
		cp_pslverr: coverpoint req.pslverr{
			bins okay = {0};
			bins error = {1};
			}
		cx_addr_err: cross cp_pwrite, cp_paddr, cp_pslverr{
			bins wr_err= binsof(cp_pwrite.write);
			bins rd_err= binsof(cp_pwrite.read);
			}

	endgroup

	function new(string name= "apb_functional_cov", uvm_component parent=null);
		super.new(name, parent);
		apb_cg=new();
	endfunction

	
	function void write (apb_seq_item t);
		req=t;
		apb_cg.sample();
	endfunction

	function void report_phase(uvm_phase phase);
		`uvm_info(get_full_name(), $sformatf("FUNCTIONAL COVERAGE=%.2f", apb_cg.get_coverage()), UVM_LOW)
	endfunction

endclass






