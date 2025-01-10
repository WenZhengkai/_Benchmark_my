module DCDemux_UInt8(
  input  [2:0] io_sel,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);
  wire  _GEN_1 = 3'h0 == io_sel & io_p_0_ready; // @[DCDemux.scala 22:14 25:26 27:18]
  wire  _GEN_3 = 3'h1 == io_sel ? io_p_1_ready : _GEN_1; // @[DCDemux.scala 25:26 27:18]
  wire  _GEN_5 = 3'h2 == io_sel ? io_p_2_ready : _GEN_3; // @[DCDemux.scala 25:26 27:18]
  wire  _GEN_7 = 3'h3 == io_sel ? io_p_3_ready : _GEN_5; // @[DCDemux.scala 25:26 27:18]
  assign io_c_ready = 3'h4 == io_sel ? io_p_4_ready : _GEN_7; // @[DCDemux.scala 25:26 27:18]
  assign io_p_0_valid = 3'h0 == io_sel & io_c_valid; // @[DCDemux.scala 25:26 26:21 29:21]
  assign io_p_0_bits = io_c_bits; // @[DCDemux.scala 24:18]
  assign io_p_1_valid = 3'h1 == io_sel & io_c_valid; // @[DCDemux.scala 25:26 26:21 29:21]
  assign io_p_1_bits = io_c_bits; // @[DCDemux.scala 24:18]
  assign io_p_2_valid = 3'h2 == io_sel & io_c_valid; // @[DCDemux.scala 25:26 26:21 29:21]
  assign io_p_2_bits = io_c_bits; // @[DCDemux.scala 24:18]
  assign io_p_3_valid = 3'h3 == io_sel & io_c_valid; // @[DCDemux.scala 25:26 26:21 29:21]
  assign io_p_3_bits = io_c_bits; // @[DCDemux.scala 24:18]
  assign io_p_4_valid = 3'h4 == io_sel & io_c_valid; // @[DCDemux.scala 25:26 26:21 29:21]
  assign io_p_4_bits = io_c_bits; // @[DCDemux.scala 24:18]
endmodule
module DCArbiter_UInt8(
  input        clock,
  input        reset,
  output       io_c_0_ready,
  input        io_c_0_valid,
  input  [7:0] io_c_0_bits,
  output       io_c_1_ready,
  input        io_c_1_valid,
  input  [7:0] io_c_1_bits,
  output       io_c_2_ready,
  input        io_c_2_valid,
  input  [7:0] io_c_2_bits,
  input        io_p_ready,
  output       io_p_valid,
  output [7:0] io_p_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] justGranted; // @[DCArbiter.scala 25:28]
  wire [2:0] ioCValid = {io_c_2_valid,io_c_1_valid,io_c_0_valid}; // @[Cat.scala 33:92]
  wire [2:0] _toBeGranted_mskReq_T_1 = justGranted - 3'h1; // @[DCArbiter.scala 41:38]
  wire [2:0] _toBeGranted_mskReq_T_2 = _toBeGranted_mskReq_T_1 | justGranted; // @[DCArbiter.scala 41:45]
  wire [2:0] _toBeGranted_mskReq_T_3 = ~_toBeGranted_mskReq_T_2; // @[DCArbiter.scala 41:25]
  wire [2:0] toBeGranted_mskReq = ioCValid & _toBeGranted_mskReq_T_3; // @[DCArbiter.scala 41:23]
  wire  _toBeGranted_T = toBeGranted_mskReq != 3'h0; // @[DCArbiter.scala 46:19]
  wire [2:0] _toBeGranted_tmpGrant_T = ~toBeGranted_mskReq; // @[DCArbiter.scala 42:27]
  wire [2:0] _toBeGranted_tmpGrant_T_2 = _toBeGranted_tmpGrant_T + 3'h1; // @[DCArbiter.scala 42:35]
  wire [2:0] toBeGranted_tmpGrant = toBeGranted_mskReq & _toBeGranted_tmpGrant_T_2; // @[DCArbiter.scala 42:24]
  wire [2:0] _toBeGranted_tmpGrant2_T = ~ioCValid; // @[DCArbiter.scala 43:29]
  wire [2:0] _toBeGranted_tmpGrant2_T_2 = _toBeGranted_tmpGrant2_T + 3'h1; // @[DCArbiter.scala 43:38]
  wire [2:0] toBeGranted_tmpGrant2 = ioCValid & _toBeGranted_tmpGrant2_T_2; // @[DCArbiter.scala 43:26]
  wire [2:0] _GEN_0 = toBeGranted_mskReq != 3'h0 ? toBeGranted_tmpGrant : toBeGranted_tmpGrant2; // @[DCArbiter.scala 46:28 47:12 49:12]
  wire [2:0] _toBeGranted_rv_T_2 = {toBeGranted_tmpGrant[0],toBeGranted_tmpGrant[2:1]}; // @[Cat.scala 33:92]
  wire [2:0] _toBeGranted_rv_T_5 = {toBeGranted_tmpGrant2[0],toBeGranted_tmpGrant2[2:1]}; // @[Cat.scala 33:92]
  wire [2:0] _GEN_1 = _toBeGranted_T ? _toBeGranted_rv_T_2 : _toBeGranted_rv_T_5; // @[DCArbiter.scala 52:28 53:12 55:12]
  wire [2:0] _GEN_2 = ioCValid != 3'h0 ? _GEN_1 : justGranted; // @[DCArbiter.scala 51:33 58:10]
  wire [2:0] toBeGranted_rv = io_p_ready ? _GEN_0 : _GEN_2; // @[DCArbiter.scala 45:22]
  wire [7:0] _GEN_6 = toBeGranted_rv[1] ? io_c_1_bits : io_c_0_bits; // @[DCArbiter.scala 100:17 99:26]
  assign io_c_0_ready = toBeGranted_rv[0] & io_p_ready; // @[DCArbiter.scala 31:37]
  assign io_c_1_ready = toBeGranted_rv[1] & io_p_ready; // @[DCArbiter.scala 31:37]
  assign io_c_2_ready = toBeGranted_rv[2] & io_p_ready; // @[DCArbiter.scala 31:37]
  assign io_p_valid = |ioCValid; // @[DCArbiter.scala 65:26]
  assign io_p_bits = toBeGranted_rv[2] ? io_c_2_bits : _GEN_6; // @[DCArbiter.scala 100:17 99:26]
  always @(posedge clock) begin
    if (reset) begin // @[DCArbiter.scala 25:28]
      justGranted <= 3'h1; // @[DCArbiter.scala 25:28]
    end else if (toBeGranted_rv != 3'h0) begin // @[DCArbiter.scala 93:29]
      if (io_p_ready) begin // @[DCArbiter.scala 45:22]
        if (toBeGranted_mskReq != 3'h0) begin // @[DCArbiter.scala 46:28]
          justGranted <= toBeGranted_tmpGrant; // @[DCArbiter.scala 47:12]
        end else begin
          justGranted <= toBeGranted_tmpGrant2; // @[DCArbiter.scala 49:12]
        end
      end else if (ioCValid != 3'h0) begin // @[DCArbiter.scala 51:33]
        justGranted <= _GEN_1;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  justGranted = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCCrossbar_UInt8_M3N5_golden(
  input        clock,
  input        reset,
  input  [2:0] io_sel_0,
  input  [2:0] io_sel_1,
  input  [2:0] io_sel_2,
  output       io_c_0_ready,
  input        io_c_0_valid,
  input  [7:0] io_c_0_bits,
  output       io_c_1_ready,
  input        io_c_1_valid,
  input  [7:0] io_c_1_bits,
  output       io_c_2_ready,
  input        io_c_2_valid,
  input  [7:0] io_c_2_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);
  wire [2:0] demuxList_0_io_sel; // @[golden.scala 25:59]
  wire  demuxList_0_io_c_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_c_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_c_bits; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_0_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_0_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_p_0_bits; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_1_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_1_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_p_1_bits; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_2_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_2_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_p_2_bits; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_3_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_3_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_p_3_bits; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_4_ready; // @[golden.scala 25:59]
  wire  demuxList_0_io_p_4_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_0_io_p_4_bits; // @[golden.scala 25:59]
  wire [2:0] demuxList_1_io_sel; // @[golden.scala 25:59]
  wire  demuxList_1_io_c_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_c_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_c_bits; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_0_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_0_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_p_0_bits; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_1_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_1_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_p_1_bits; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_2_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_2_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_p_2_bits; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_3_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_3_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_p_3_bits; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_4_ready; // @[golden.scala 25:59]
  wire  demuxList_1_io_p_4_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_1_io_p_4_bits; // @[golden.scala 25:59]
  wire [2:0] demuxList_2_io_sel; // @[golden.scala 25:59]
  wire  demuxList_2_io_c_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_c_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_c_bits; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_0_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_0_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_p_0_bits; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_1_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_1_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_p_1_bits; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_2_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_2_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_p_2_bits; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_3_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_3_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_p_3_bits; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_4_ready; // @[golden.scala 25:59]
  wire  demuxList_2_io_p_4_valid; // @[golden.scala 25:59]
  wire [7:0] demuxList_2_io_p_4_bits; // @[golden.scala 25:59]
  wire  arbList_0_clock; // @[golden.scala 26:58]
  wire  arbList_0_reset; // @[golden.scala 26:58]
  wire  arbList_0_io_c_0_ready; // @[golden.scala 26:58]
  wire  arbList_0_io_c_0_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_0_io_c_0_bits; // @[golden.scala 26:58]
  wire  arbList_0_io_c_1_ready; // @[golden.scala 26:58]
  wire  arbList_0_io_c_1_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_0_io_c_1_bits; // @[golden.scala 26:58]
  wire  arbList_0_io_c_2_ready; // @[golden.scala 26:58]
  wire  arbList_0_io_c_2_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_0_io_c_2_bits; // @[golden.scala 26:58]
  wire  arbList_0_io_p_ready; // @[golden.scala 26:58]
  wire  arbList_0_io_p_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_0_io_p_bits; // @[golden.scala 26:58]
  wire  arbList_1_clock; // @[golden.scala 26:58]
  wire  arbList_1_reset; // @[golden.scala 26:58]
  wire  arbList_1_io_c_0_ready; // @[golden.scala 26:58]
  wire  arbList_1_io_c_0_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_1_io_c_0_bits; // @[golden.scala 26:58]
  wire  arbList_1_io_c_1_ready; // @[golden.scala 26:58]
  wire  arbList_1_io_c_1_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_1_io_c_1_bits; // @[golden.scala 26:58]
  wire  arbList_1_io_c_2_ready; // @[golden.scala 26:58]
  wire  arbList_1_io_c_2_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_1_io_c_2_bits; // @[golden.scala 26:58]
  wire  arbList_1_io_p_ready; // @[golden.scala 26:58]
  wire  arbList_1_io_p_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_1_io_p_bits; // @[golden.scala 26:58]
  wire  arbList_2_clock; // @[golden.scala 26:58]
  wire  arbList_2_reset; // @[golden.scala 26:58]
  wire  arbList_2_io_c_0_ready; // @[golden.scala 26:58]
  wire  arbList_2_io_c_0_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_2_io_c_0_bits; // @[golden.scala 26:58]
  wire  arbList_2_io_c_1_ready; // @[golden.scala 26:58]
  wire  arbList_2_io_c_1_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_2_io_c_1_bits; // @[golden.scala 26:58]
  wire  arbList_2_io_c_2_ready; // @[golden.scala 26:58]
  wire  arbList_2_io_c_2_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_2_io_c_2_bits; // @[golden.scala 26:58]
  wire  arbList_2_io_p_ready; // @[golden.scala 26:58]
  wire  arbList_2_io_p_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_2_io_p_bits; // @[golden.scala 26:58]
  wire  arbList_3_clock; // @[golden.scala 26:58]
  wire  arbList_3_reset; // @[golden.scala 26:58]
  wire  arbList_3_io_c_0_ready; // @[golden.scala 26:58]
  wire  arbList_3_io_c_0_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_3_io_c_0_bits; // @[golden.scala 26:58]
  wire  arbList_3_io_c_1_ready; // @[golden.scala 26:58]
  wire  arbList_3_io_c_1_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_3_io_c_1_bits; // @[golden.scala 26:58]
  wire  arbList_3_io_c_2_ready; // @[golden.scala 26:58]
  wire  arbList_3_io_c_2_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_3_io_c_2_bits; // @[golden.scala 26:58]
  wire  arbList_3_io_p_ready; // @[golden.scala 26:58]
  wire  arbList_3_io_p_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_3_io_p_bits; // @[golden.scala 26:58]
  wire  arbList_4_clock; // @[golden.scala 26:58]
  wire  arbList_4_reset; // @[golden.scala 26:58]
  wire  arbList_4_io_c_0_ready; // @[golden.scala 26:58]
  wire  arbList_4_io_c_0_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_4_io_c_0_bits; // @[golden.scala 26:58]
  wire  arbList_4_io_c_1_ready; // @[golden.scala 26:58]
  wire  arbList_4_io_c_1_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_4_io_c_1_bits; // @[golden.scala 26:58]
  wire  arbList_4_io_c_2_ready; // @[golden.scala 26:58]
  wire  arbList_4_io_c_2_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_4_io_c_2_bits; // @[golden.scala 26:58]
  wire  arbList_4_io_p_ready; // @[golden.scala 26:58]
  wire  arbList_4_io_p_valid; // @[golden.scala 26:58]
  wire [7:0] arbList_4_io_p_bits; // @[golden.scala 26:58]
  DCDemux_UInt8 demuxList_0 ( // @[golden.scala 25:59]
    .io_sel(demuxList_0_io_sel),
    .io_c_ready(demuxList_0_io_c_ready),
    .io_c_valid(demuxList_0_io_c_valid),
    .io_c_bits(demuxList_0_io_c_bits),
    .io_p_0_ready(demuxList_0_io_p_0_ready),
    .io_p_0_valid(demuxList_0_io_p_0_valid),
    .io_p_0_bits(demuxList_0_io_p_0_bits),
    .io_p_1_ready(demuxList_0_io_p_1_ready),
    .io_p_1_valid(demuxList_0_io_p_1_valid),
    .io_p_1_bits(demuxList_0_io_p_1_bits),
    .io_p_2_ready(demuxList_0_io_p_2_ready),
    .io_p_2_valid(demuxList_0_io_p_2_valid),
    .io_p_2_bits(demuxList_0_io_p_2_bits),
    .io_p_3_ready(demuxList_0_io_p_3_ready),
    .io_p_3_valid(demuxList_0_io_p_3_valid),
    .io_p_3_bits(demuxList_0_io_p_3_bits),
    .io_p_4_ready(demuxList_0_io_p_4_ready),
    .io_p_4_valid(demuxList_0_io_p_4_valid),
    .io_p_4_bits(demuxList_0_io_p_4_bits)
  );
  DCDemux_UInt8 demuxList_1 ( // @[golden.scala 25:59]
    .io_sel(demuxList_1_io_sel),
    .io_c_ready(demuxList_1_io_c_ready),
    .io_c_valid(demuxList_1_io_c_valid),
    .io_c_bits(demuxList_1_io_c_bits),
    .io_p_0_ready(demuxList_1_io_p_0_ready),
    .io_p_0_valid(demuxList_1_io_p_0_valid),
    .io_p_0_bits(demuxList_1_io_p_0_bits),
    .io_p_1_ready(demuxList_1_io_p_1_ready),
    .io_p_1_valid(demuxList_1_io_p_1_valid),
    .io_p_1_bits(demuxList_1_io_p_1_bits),
    .io_p_2_ready(demuxList_1_io_p_2_ready),
    .io_p_2_valid(demuxList_1_io_p_2_valid),
    .io_p_2_bits(demuxList_1_io_p_2_bits),
    .io_p_3_ready(demuxList_1_io_p_3_ready),
    .io_p_3_valid(demuxList_1_io_p_3_valid),
    .io_p_3_bits(demuxList_1_io_p_3_bits),
    .io_p_4_ready(demuxList_1_io_p_4_ready),
    .io_p_4_valid(demuxList_1_io_p_4_valid),
    .io_p_4_bits(demuxList_1_io_p_4_bits)
  );
  DCDemux_UInt8 demuxList_2 ( // @[golden.scala 25:59]
    .io_sel(demuxList_2_io_sel),
    .io_c_ready(demuxList_2_io_c_ready),
    .io_c_valid(demuxList_2_io_c_valid),
    .io_c_bits(demuxList_2_io_c_bits),
    .io_p_0_ready(demuxList_2_io_p_0_ready),
    .io_p_0_valid(demuxList_2_io_p_0_valid),
    .io_p_0_bits(demuxList_2_io_p_0_bits),
    .io_p_1_ready(demuxList_2_io_p_1_ready),
    .io_p_1_valid(demuxList_2_io_p_1_valid),
    .io_p_1_bits(demuxList_2_io_p_1_bits),
    .io_p_2_ready(demuxList_2_io_p_2_ready),
    .io_p_2_valid(demuxList_2_io_p_2_valid),
    .io_p_2_bits(demuxList_2_io_p_2_bits),
    .io_p_3_ready(demuxList_2_io_p_3_ready),
    .io_p_3_valid(demuxList_2_io_p_3_valid),
    .io_p_3_bits(demuxList_2_io_p_3_bits),
    .io_p_4_ready(demuxList_2_io_p_4_ready),
    .io_p_4_valid(demuxList_2_io_p_4_valid),
    .io_p_4_bits(demuxList_2_io_p_4_bits)
  );
  DCArbiter_UInt8 arbList_0 ( // @[golden.scala 26:58]
    .clock(arbList_0_clock),
    .reset(arbList_0_reset),
    .io_c_0_ready(arbList_0_io_c_0_ready),
    .io_c_0_valid(arbList_0_io_c_0_valid),
    .io_c_0_bits(arbList_0_io_c_0_bits),
    .io_c_1_ready(arbList_0_io_c_1_ready),
    .io_c_1_valid(arbList_0_io_c_1_valid),
    .io_c_1_bits(arbList_0_io_c_1_bits),
    .io_c_2_ready(arbList_0_io_c_2_ready),
    .io_c_2_valid(arbList_0_io_c_2_valid),
    .io_c_2_bits(arbList_0_io_c_2_bits),
    .io_p_ready(arbList_0_io_p_ready),
    .io_p_valid(arbList_0_io_p_valid),
    .io_p_bits(arbList_0_io_p_bits)
  );
  DCArbiter_UInt8 arbList_1 ( // @[golden.scala 26:58]
    .clock(arbList_1_clock),
    .reset(arbList_1_reset),
    .io_c_0_ready(arbList_1_io_c_0_ready),
    .io_c_0_valid(arbList_1_io_c_0_valid),
    .io_c_0_bits(arbList_1_io_c_0_bits),
    .io_c_1_ready(arbList_1_io_c_1_ready),
    .io_c_1_valid(arbList_1_io_c_1_valid),
    .io_c_1_bits(arbList_1_io_c_1_bits),
    .io_c_2_ready(arbList_1_io_c_2_ready),
    .io_c_2_valid(arbList_1_io_c_2_valid),
    .io_c_2_bits(arbList_1_io_c_2_bits),
    .io_p_ready(arbList_1_io_p_ready),
    .io_p_valid(arbList_1_io_p_valid),
    .io_p_bits(arbList_1_io_p_bits)
  );
  DCArbiter_UInt8 arbList_2 ( // @[golden.scala 26:58]
    .clock(arbList_2_clock),
    .reset(arbList_2_reset),
    .io_c_0_ready(arbList_2_io_c_0_ready),
    .io_c_0_valid(arbList_2_io_c_0_valid),
    .io_c_0_bits(arbList_2_io_c_0_bits),
    .io_c_1_ready(arbList_2_io_c_1_ready),
    .io_c_1_valid(arbList_2_io_c_1_valid),
    .io_c_1_bits(arbList_2_io_c_1_bits),
    .io_c_2_ready(arbList_2_io_c_2_ready),
    .io_c_2_valid(arbList_2_io_c_2_valid),
    .io_c_2_bits(arbList_2_io_c_2_bits),
    .io_p_ready(arbList_2_io_p_ready),
    .io_p_valid(arbList_2_io_p_valid),
    .io_p_bits(arbList_2_io_p_bits)
  );
  DCArbiter_UInt8 arbList_3 ( // @[golden.scala 26:58]
    .clock(arbList_3_clock),
    .reset(arbList_3_reset),
    .io_c_0_ready(arbList_3_io_c_0_ready),
    .io_c_0_valid(arbList_3_io_c_0_valid),
    .io_c_0_bits(arbList_3_io_c_0_bits),
    .io_c_1_ready(arbList_3_io_c_1_ready),
    .io_c_1_valid(arbList_3_io_c_1_valid),
    .io_c_1_bits(arbList_3_io_c_1_bits),
    .io_c_2_ready(arbList_3_io_c_2_ready),
    .io_c_2_valid(arbList_3_io_c_2_valid),
    .io_c_2_bits(arbList_3_io_c_2_bits),
    .io_p_ready(arbList_3_io_p_ready),
    .io_p_valid(arbList_3_io_p_valid),
    .io_p_bits(arbList_3_io_p_bits)
  );
  DCArbiter_UInt8 arbList_4 ( // @[golden.scala 26:58]
    .clock(arbList_4_clock),
    .reset(arbList_4_reset),
    .io_c_0_ready(arbList_4_io_c_0_ready),
    .io_c_0_valid(arbList_4_io_c_0_valid),
    .io_c_0_bits(arbList_4_io_c_0_bits),
    .io_c_1_ready(arbList_4_io_c_1_ready),
    .io_c_1_valid(arbList_4_io_c_1_valid),
    .io_c_1_bits(arbList_4_io_c_1_bits),
    .io_c_2_ready(arbList_4_io_c_2_ready),
    .io_c_2_valid(arbList_4_io_c_2_valid),
    .io_c_2_bits(arbList_4_io_c_2_bits),
    .io_p_ready(arbList_4_io_p_ready),
    .io_p_valid(arbList_4_io_p_valid),
    .io_p_bits(arbList_4_io_p_bits)
  );
  assign io_c_0_ready = demuxList_0_io_c_ready; // @[golden.scala 28:25]
  assign io_c_1_ready = demuxList_1_io_c_ready; // @[golden.scala 28:25]
  assign io_c_2_ready = demuxList_2_io_c_ready; // @[golden.scala 28:25]
  assign io_p_0_valid = arbList_0_io_p_valid; // @[golden.scala 36:23]
  assign io_p_0_bits = arbList_0_io_p_bits; // @[golden.scala 36:23]
  assign io_p_1_valid = arbList_1_io_p_valid; // @[golden.scala 36:23]
  assign io_p_1_bits = arbList_1_io_p_bits; // @[golden.scala 36:23]
  assign io_p_2_valid = arbList_2_io_p_valid; // @[golden.scala 36:23]
  assign io_p_2_bits = arbList_2_io_p_bits; // @[golden.scala 36:23]
  assign io_p_3_valid = arbList_3_io_p_valid; // @[golden.scala 36:23]
  assign io_p_3_bits = arbList_3_io_p_bits; // @[golden.scala 36:23]
  assign io_p_4_valid = arbList_4_io_p_valid; // @[golden.scala 36:23]
  assign io_p_4_bits = arbList_4_io_p_bits; // @[golden.scala 36:23]
  assign demuxList_0_io_sel = io_sel_0; // @[golden.scala 29:27]
  assign demuxList_0_io_c_valid = io_c_0_valid; // @[golden.scala 28:25]
  assign demuxList_0_io_c_bits = io_c_0_bits; // @[golden.scala 28:25]
  assign demuxList_0_io_p_0_ready = arbList_0_io_c_0_ready; // @[golden.scala 32:30]
  assign demuxList_0_io_p_1_ready = arbList_1_io_c_0_ready; // @[golden.scala 32:30]
  assign demuxList_0_io_p_2_ready = arbList_2_io_c_0_ready; // @[golden.scala 32:30]
  assign demuxList_0_io_p_3_ready = arbList_3_io_c_0_ready; // @[golden.scala 32:30]
  assign demuxList_0_io_p_4_ready = arbList_4_io_c_0_ready; // @[golden.scala 32:30]
  assign demuxList_1_io_sel = io_sel_1; // @[golden.scala 29:27]
  assign demuxList_1_io_c_valid = io_c_1_valid; // @[golden.scala 28:25]
  assign demuxList_1_io_c_bits = io_c_1_bits; // @[golden.scala 28:25]
  assign demuxList_1_io_p_0_ready = arbList_0_io_c_1_ready; // @[golden.scala 32:30]
  assign demuxList_1_io_p_1_ready = arbList_1_io_c_1_ready; // @[golden.scala 32:30]
  assign demuxList_1_io_p_2_ready = arbList_2_io_c_1_ready; // @[golden.scala 32:30]
  assign demuxList_1_io_p_3_ready = arbList_3_io_c_1_ready; // @[golden.scala 32:30]
  assign demuxList_1_io_p_4_ready = arbList_4_io_c_1_ready; // @[golden.scala 32:30]
  assign demuxList_2_io_sel = io_sel_2; // @[golden.scala 29:27]
  assign demuxList_2_io_c_valid = io_c_2_valid; // @[golden.scala 28:25]
  assign demuxList_2_io_c_bits = io_c_2_bits; // @[golden.scala 28:25]
  assign demuxList_2_io_p_0_ready = arbList_0_io_c_2_ready; // @[golden.scala 32:30]
  assign demuxList_2_io_p_1_ready = arbList_1_io_c_2_ready; // @[golden.scala 32:30]
  assign demuxList_2_io_p_2_ready = arbList_2_io_c_2_ready; // @[golden.scala 32:30]
  assign demuxList_2_io_p_3_ready = arbList_3_io_c_2_ready; // @[golden.scala 32:30]
  assign demuxList_2_io_p_4_ready = arbList_4_io_c_2_ready; // @[golden.scala 32:30]
  assign arbList_0_clock = clock;
  assign arbList_0_reset = reset;
  assign arbList_0_io_c_0_valid = demuxList_0_io_p_0_valid; // @[golden.scala 32:30]
  assign arbList_0_io_c_0_bits = demuxList_0_io_p_0_bits; // @[golden.scala 32:30]
  assign arbList_0_io_c_1_valid = demuxList_1_io_p_0_valid; // @[golden.scala 32:30]
  assign arbList_0_io_c_1_bits = demuxList_1_io_p_0_bits; // @[golden.scala 32:30]
  assign arbList_0_io_c_2_valid = demuxList_2_io_p_0_valid; // @[golden.scala 32:30]
  assign arbList_0_io_c_2_bits = demuxList_2_io_p_0_bits; // @[golden.scala 32:30]
  assign arbList_0_io_p_ready = io_p_0_ready; // @[golden.scala 36:23]
  assign arbList_1_clock = clock;
  assign arbList_1_reset = reset;
  assign arbList_1_io_c_0_valid = demuxList_0_io_p_1_valid; // @[golden.scala 32:30]
  assign arbList_1_io_c_0_bits = demuxList_0_io_p_1_bits; // @[golden.scala 32:30]
  assign arbList_1_io_c_1_valid = demuxList_1_io_p_1_valid; // @[golden.scala 32:30]
  assign arbList_1_io_c_1_bits = demuxList_1_io_p_1_bits; // @[golden.scala 32:30]
  assign arbList_1_io_c_2_valid = demuxList_2_io_p_1_valid; // @[golden.scala 32:30]
  assign arbList_1_io_c_2_bits = demuxList_2_io_p_1_bits; // @[golden.scala 32:30]
  assign arbList_1_io_p_ready = io_p_1_ready; // @[golden.scala 36:23]
  assign arbList_2_clock = clock;
  assign arbList_2_reset = reset;
  assign arbList_2_io_c_0_valid = demuxList_0_io_p_2_valid; // @[golden.scala 32:30]
  assign arbList_2_io_c_0_bits = demuxList_0_io_p_2_bits; // @[golden.scala 32:30]
  assign arbList_2_io_c_1_valid = demuxList_1_io_p_2_valid; // @[golden.scala 32:30]
  assign arbList_2_io_c_1_bits = demuxList_1_io_p_2_bits; // @[golden.scala 32:30]
  assign arbList_2_io_c_2_valid = demuxList_2_io_p_2_valid; // @[golden.scala 32:30]
  assign arbList_2_io_c_2_bits = demuxList_2_io_p_2_bits; // @[golden.scala 32:30]
  assign arbList_2_io_p_ready = io_p_2_ready; // @[golden.scala 36:23]
  assign arbList_3_clock = clock;
  assign arbList_3_reset = reset;
  assign arbList_3_io_c_0_valid = demuxList_0_io_p_3_valid; // @[golden.scala 32:30]
  assign arbList_3_io_c_0_bits = demuxList_0_io_p_3_bits; // @[golden.scala 32:30]
  assign arbList_3_io_c_1_valid = demuxList_1_io_p_3_valid; // @[golden.scala 32:30]
  assign arbList_3_io_c_1_bits = demuxList_1_io_p_3_bits; // @[golden.scala 32:30]
  assign arbList_3_io_c_2_valid = demuxList_2_io_p_3_valid; // @[golden.scala 32:30]
  assign arbList_3_io_c_2_bits = demuxList_2_io_p_3_bits; // @[golden.scala 32:30]
  assign arbList_3_io_p_ready = io_p_3_ready; // @[golden.scala 36:23]
  assign arbList_4_clock = clock;
  assign arbList_4_reset = reset;
  assign arbList_4_io_c_0_valid = demuxList_0_io_p_4_valid; // @[golden.scala 32:30]
  assign arbList_4_io_c_0_bits = demuxList_0_io_p_4_bits; // @[golden.scala 32:30]
  assign arbList_4_io_c_1_valid = demuxList_1_io_p_4_valid; // @[golden.scala 32:30]
  assign arbList_4_io_c_1_bits = demuxList_1_io_p_4_bits; // @[golden.scala 32:30]
  assign arbList_4_io_c_2_valid = demuxList_2_io_p_4_valid; // @[golden.scala 32:30]
  assign arbList_4_io_c_2_bits = demuxList_2_io_p_4_bits; // @[golden.scala 32:30]
  assign arbList_4_io_p_ready = io_p_4_ready; // @[golden.scala 36:23]
endmodule
