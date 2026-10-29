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

typedef struct packed {
  logic [ADDR_WIDTH-1:0]   paddr;
  apb_pkg::prot_t          pprot;
  logic                    psel;
  logic                    penable;
  logic                    pwrite;
  logic [DATA_WIDTH-1:0]   pwdata;
  logic [DATA_WIDTH/8-1:0] pstrb;
} req_t;

typedef struct packed {
  logic                  pready;
  logic [DATA_WIDTH-1:0] prdata;
  logic                  pslverr;
} resp_t;

req_t  req;
resp_t resp;

//instantiate interface and DUT
apb_if apb_vif(pclk);

initial begin
	uvm_config_db#(virtual apb_if)::set(uvm_root::get(), "*", "vif", apb_vif);
end

apb_slave_top #(.ADDR_WIDTH(ADDR_WIDTH),
	.DATA_WIDTH(DATA_WIDTH),
	.STRB_WIDTH((DATA_WIDTH + 7) / 8),
	.req_t(req_t), 
	.resp_t(resp_t) 
	) dut_2(.paddr_i(apb_vif.paddr),
		.psel_i(apb_vif.psel),
		.penable_i(apb_vif.penable),
		.pwrite_i(apb_vif.pwrite),
		.pwdata_i(apb_vif.pwdata),
		.pready_o(apb_vif.pready),
		.prdata_o(apb_vif.prdata),
		.pslverr_o(apb_vif.pslverr),
		.pstrb_i('1),
		.pprot_i('0),
		.slv_req_o(req),
		.slv_resp_i(resp)
		);

apb_regs #(.NoApbRegs(64), 
	.ApbAddrWidth(ADDR_WIDTH),
	.AddrOffset(4),
	.ApbDataWidth(DATA_WIDTH),
	.RegDataWidth(DATA_WIDTH),
	.req_t(req_t),
	.resp_t(resp_t)
	) dut_1(.pclk_i(apb_vif.pclk),
		.preset_ni(apb_vif.presetn),
		.req_i(req),
		.resp_o(resp),
		.base_addr_i('0),
		.reg_init_i('0),
		.reg_q_o()
		);
apb_assertion_module all_inst(.pclk(apb_vif.pclk),
	.presetn (apb_vif.presetn),
        .pwrite  (apb_vif.pwrite),
        .psel    (apb_vif.psel),
        .penable (apb_vif.penable),
        .pready  (apb_vif.pready),
        .pslverr (apb_vif.pslverr));

	
initial begin
	run_test("base_test");
end
endmodule
