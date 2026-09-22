`include "uvm_macros.svh"
import uvm_pkg::*;
import apb_test_pkg::*;


module apb_tb_top;

bit pclk;
bit presetn;

always #5 pclk=~pclk;


apb_if apb_vif(pclk);
initial begin
	apb_vif.presetn=0;
	#20;
	apb_vif.presetn=1;
end
initial begin
	uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "*", "vif", apb_vif);
end

initial begin
	run_test("base test");
end
endmodule
