`include "uvm_macros.svh"
import uvm_pkg::*;
import apb_test_pkg::*;


module apb_tb_top;

bit pclk;
bit presetn;

int clk_frequency_mhz;
int clk_period_ns;
initial begin
	if($value$plusargs("CLK_FREQUENCY=%d", clk_frequency_mhz)) begin
		$display("Clock frequency overwritten to %0d MHz", clk_frequency_mhz);
	end
	
	clk_period_ns=1000/clk_frequency_mhz;
end


always #(clk_period_ns/2) pclk = ~pclk;

//instantiate interface and DUT
apb_if apb_vif(pclk);

initial begin
	uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "uvm_test_top.env_o.agt.*", "vif", apb_vif);
end

/*apb_assertion_module all_inst(.pclk(apb_vif.pclk),
	.presetn (apb_vif.presetn),
        .pwrite  (apb_vif.pwrite),
        .psel    (apb_vif.psel),
        .penable (apb_vif.penable),
        .pready  (apb_vif.pready),
        .pslverr (apb_vif.pslverr));
*/

bind apb_if apb_assertion_module all_inst (
  .pclk    (pclk),
  .presetn (presetn),
  .pwrite  (pwrite),
  .psel    (psel),
  .penable (penable),
  .pready  (pready),
  .pslverr (pslverr)
);

initial begin
	run_test("base_test");
end
endmodule
