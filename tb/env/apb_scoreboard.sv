class apb_scoreboard extends uvm_scoreboard;
	uvm_analysis_imp #(apb_seq_item, apb_scoreboard) item_collect_export;
	apb_seq_item item_q[$];
	int pass_count;
	int fail_count;

	`uvm_component_utils(apb_scoreboard)

	function new(string name="apb_scoreboard", uvm_component parent= null);
		super.new(name, parent);
		item_collect_export=new("item_collect_export", this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD BUILD PHASE", UVM_LOW);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD CONNECT PHASE", UVM_LOW);
	endfunction

	function void write(apb_seq_item req);
		`uvm_info(get_type_name(), "INSIDE SCOREBOARD WRITE FUNCTION", UVM_LOW);
		item_q.push_back(req);
	endfunction

	task run_phase(uvm_phase phase);	
		apb_seq_item sb_item;
		bit [32:0] expected_mem [bit[31:0]];

		`uvm_info(get_type_name(), "INSIDE SCOREBOARD RUN PHASE", UVM_LOW);
		pass_count=0;
		fail_count=0;
			forever begin

			wait(item_q.size > 0);

			if(item_q.size>0) begin
				sb_item=item_q.pop_front();
				
				if(sb_item.pwrite==1) begin
					expected_mem[sb_item.paddr]=sb_item.pwdata;
					`uvm_info(get_type_name(), $sformatf("WRITE: addr=%0h, data=%0h, pslverr=%0h", sb_item.paddr, sb_item.pwdata, sb_item.pslverr), UVM_LOW);
				end
				else begin
					if(!expected_mem.exists(sb_item.paddr)) begin
						if(expected_mem[sb_item.paddr]==0)
							pass_count++;
						else
							fail_count++;
					end
					else if (expected_mem[sb_item.paddr] !== sb_item.prdata) begin
						fail_count++;
						`uvm_error(get_type_name(), $sformatf("MISMATCH: addr=%0h, expected=%0h, actual=%0h, pslverr=%0h", sb_item.paddr, expected_mem[sb_item.paddr], sb_item.prdata, sb_item.pslverr));
					end
					else begin
						pass_count++;
						`uvm_info(get_type_name(), $sformatf("MATCH. addr=%0h, expected=%0h, actual=%0h, pslverr=%0h", sb_item.paddr, expected_mem[sb_item.paddr], sb_item.prdata, sb_item.pslverr), UVM_LOW);
					end
				end
				`uvm_info(get_type_name(), $sformatf("pass count=%0d, fail count=%0d", pass_count, fail_count), UVM_LOW);
			end
			end
		endtask
	endclass
