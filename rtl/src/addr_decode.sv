// Copyright 2018 ETH Zurich and University of Bologna.
// Licensed under the Solderpad Hardware License, Version 0.51.
// Address Decoder module (from common_cells)

module addr_decode #(
  parameter int unsigned NoIndices = 32'd0,
  parameter int unsigned NoRules   = 32'd0,
  parameter type         addr_t    = logic,
  parameter type         rule_t    = logic,
  // Dependent parameters DO NOT OVERWRITE!
  parameter int unsigned IdxWidth  = (NoIndices > 32'd1) ? $clog2(NoIndices) : 32'd1,
  parameter type         idx_t     = logic [IdxWidth-1:0]
) (
  input  addr_t               addr_i,
  input  rule_t [NoRules-1:0] addr_map_i,
  output idx_t                idx_o,
  output logic                dec_valid_o,
  output logic                dec_error_o,
  input  logic                en_default_idx_i,
  input  idx_t                default_idx_i
);

  logic [NoRules-1:0] matched_rules;

  for (genvar i = 0; i < NoRules; i++) begin : gen_rule_match
    assign matched_rules[i] = (addr_i >= addr_map_i[i].start_addr) &&
                              (addr_i <  addr_map_i[i].end_addr);
  end

  always_comb begin
    idx_o       = '0;
    dec_valid_o = 1'b0;
    dec_error_o = 1'b0;

    for (int unsigned i = 0; i < NoRules; i++) begin
      if (matched_rules[i]) begin
        idx_o       = idx_t'(addr_map_i[i].idx);
        dec_valid_o = 1'b1;
        break;
      end
    end

    if (!dec_valid_o) begin
      if (en_default_idx_i) begin
        idx_o       = default_idx_i;
        dec_valid_o = 1'b1;
      end else begin
        dec_error_o = 1'b1;
      end
    end
  end

endmodule
