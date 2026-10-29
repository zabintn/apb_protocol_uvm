// Minimal compatibility header for common_cells/registers.svh
`ifndef COMMON_CELLS_REGISTERS_SVH_
`define COMMON_CELLS_REGISTERS_SVH_

`define FFARN(__q, __d, __reset_val, __clk, __reset_n) \
  always_ff @(posedge (__clk) or negedge (__reset_n)) begin \
    if (!(__reset_n)) begin \
      __q <= (__reset_val); \
    end else begin \
      __q <= (__d); \
    end \
  end

`define FFLARN(__q, __d, __load, __reset_val, __clk, __reset_n) \
  always_ff @(posedge (__clk) or negedge (__reset_n)) begin \
    if (!(__reset_n)) begin \
      __q <= (__reset_val); \
    end else if (__load) begin \
      __q <= (__d); \
    end \
  end

`endif
