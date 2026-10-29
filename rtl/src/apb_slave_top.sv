// Copyright 2026 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Description:
// APB Slave Top Wrapper / Bridge.
// Converts discrete pin-level APB slave signals (paddr_i, pwdata_i, pready_o, etc.)
// into APB request/response structs (apb_slave_top) or a SystemVerilog APB interface
// (apb_slave_top_intf). This module is designed for chip top-level boundaries,
// FPGA/ASIC synthesis, and integration with blocks that do not use SystemVerilog interfaces.

module apb_slave_top #(
  parameter int unsigned ADDR_WIDTH = 32'd32,
  parameter int unsigned DATA_WIDTH = 32'd32,
  parameter int unsigned STRB_WIDTH = (DATA_WIDTH + 7) / 8,
  parameter type         req_t      = logic,
  parameter type         resp_t     = logic
) (
  // Flat APB Slave Pin Ports
  input  logic [ADDR_WIDTH-1:0] paddr_i,
  input  apb_pkg::prot_t        pprot_i,
  input  logic                  psel_i,
  input  logic                  penable_i,
  input  logic                  pwrite_i,
  input  logic [DATA_WIDTH-1:0] pwdata_i,
  input  logic [STRB_WIDTH-1:0] pstrb_i,
  output logic                  pready_o,
  output logic [DATA_WIDTH-1:0] prdata_o,
  output logic                  pslverr_o,

  // Struct Interface (connects to struct-based APB slaves/buses)
  output req_t                  slv_req_o,
  input  resp_t                 slv_resp_i
);

  assign slv_req_o.paddr   = paddr_i;
  assign slv_req_o.pprot   = pprot_i;
  assign slv_req_o.psel    = psel_i;
  assign slv_req_o.penable = penable_i;
  assign slv_req_o.pwrite  = pwrite_i;
  assign slv_req_o.pwdata  = pwdata_i;
  assign slv_req_o.pstrb   = pstrb_i;

  assign pready_o  = slv_resp_i.pready;
  assign prdata_o  = slv_resp_i.prdata;
  assign pslverr_o = slv_resp_i.pslverr;

endmodule

`include "apb/typedef.svh"
`include "apb/assign.svh"

module apb_slave_top_intf #(
  parameter int unsigned APB_ADDR_WIDTH = 32'd32,
  parameter int unsigned APB_DATA_WIDTH = 32'd32,
  parameter int unsigned APB_STRB_WIDTH = (APB_DATA_WIDTH + 7) / 8
) (
  // Flat APB Slave Pin Ports
  input  logic [APB_ADDR_WIDTH-1:0] paddr_i,
  input  apb_pkg::prot_t            pprot_i,
  input  logic                      psel_i,
  input  logic                      penable_i,
  input  logic                      pwrite_i,
  input  logic [APB_DATA_WIDTH-1:0] pwdata_i,
  input  logic [APB_STRB_WIDTH-1:0] pstrb_i,
  output logic                      pready_o,
  output logic [APB_DATA_WIDTH-1:0] prdata_o,
  output logic                      pslverr_o,

  // Internal APB Master Interface Port (drives downstream APB slave/bus)
  APB.Master                        mst
);

  assign mst.paddr   = paddr_i;
  assign mst.pprot   = pprot_i;
  assign mst.psel    = psel_i;
  assign mst.penable = penable_i;
  assign mst.pwrite  = pwrite_i;
  assign mst.pwdata  = pwdata_i;
  assign mst.pstrb   = pstrb_i;

  assign pready_o    = mst.pready;
  assign prdata_o    = mst.prdata;
  assign pslverr_o   = mst.pslverr;

  // Validate parameters
  // pragma translate_off
  `ifndef VERILATOR
    initial begin: p_assertions
      assert (APB_ADDR_WIDTH == $bits(mst.paddr))
          else $fatal(1, "APB_ADDR_WIDTH does not match mst interface!");
      assert (APB_DATA_WIDTH == $bits(mst.pwdata))
          else $fatal(1, "APB_DATA_WIDTH does not match mst interface!");
    end
  `endif
  // pragma translate_on

endmodule
