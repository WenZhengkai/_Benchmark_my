module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg  pipe_en_0; // @[dut.scala 15:26]
  reg  pipe_en_1; // @[dut.scala 15:26]
  reg  pipe_en_2; // @[dut.scala 15:26]
  reg  pipe_en_3; // @[dut.scala 15:26]
  reg [16:0] partialSum_0; // @[dut.scala 16:27]
  reg [16:0] partialSum_1; // @[dut.scala 16:27]
  reg [16:0] partialSum_2; // @[dut.scala 16:27]
  reg [16:0] partialSum_3; // @[dut.scala 16:27]
  reg  carry_0; // @[dut.scala 17:26]
  reg  carry_1; // @[dut.scala 17:26]
  reg  carry_2; // @[dut.scala 17:26]
  reg  carry_3; // @[dut.scala 17:26]
  wire [15:0] adda_segments_0 = io_adda[15:0]; // @[dut.scala 20:59]
  wire [15:0] adda_segments_1 = io_adda[31:16]; // @[dut.scala 20:59]
  wire [15:0] adda_segments_2 = io_adda[47:32]; // @[dut.scala 20:59]
  wire [15:0] adda_segments_3 = io_adda[63:48]; // @[dut.scala 20:59]
  wire [15:0] addb_segments_0 = io_addb[15:0]; // @[dut.scala 21:59]
  wire [15:0] addb_segments_1 = io_addb[31:16]; // @[dut.scala 21:59]
  wire [15:0] addb_segments_2 = io_addb[47:32]; // @[dut.scala 21:59]
  wire [15:0] addb_segments_3 = io_addb[63:48]; // @[dut.scala 21:59]
  wire [16:0] res0 = adda_segments_0 + addb_segments_0; // @[dut.scala 25:33]
  wire [16:0] _res_T = adda_segments_1 + addb_segments_1; // @[dut.scala 34:34]
  wire [16:0] _GEN_12 = {{16'd0}, carry_0}; // @[dut.scala 34:54]
  wire [17:0] res = _res_T + _GEN_12; // @[dut.scala 34:54]
  wire [17:0] _GEN_3 = pipe_en_0 ? res : {{1'd0}, partialSum_1}; // @[dut.scala 33:24 35:21 16:27]
  wire [16:0] _res_T_1 = adda_segments_2 + addb_segments_2; // @[dut.scala 34:34]
  wire [16:0] _GEN_13 = {{16'd0}, carry_1}; // @[dut.scala 34:54]
  wire [17:0] res_1 = _res_T_1 + _GEN_13; // @[dut.scala 34:54]
  wire [17:0] _GEN_6 = pipe_en_1 ? res_1 : {{1'd0}, partialSum_2}; // @[dut.scala 33:24 35:21 16:27]
  wire [16:0] _res_T_2 = adda_segments_3 + addb_segments_3; // @[dut.scala 34:34]
  wire [16:0] _GEN_14 = {{16'd0}, carry_2}; // @[dut.scala 34:54]
  wire [17:0] res_2 = _res_T_2 + _GEN_14; // @[dut.scala 34:54]
  wire [17:0] _GEN_9 = pipe_en_2 ? res_2 : {{1'd0}, partialSum_3}; // @[dut.scala 33:24 35:21 16:27]
  wire [31:0] result_lo = {partialSum_1[15:0],partialSum_0[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] result_hi = {carry_3,partialSum_3[15:0],partialSum_2[15:0]}; // @[Cat.scala 33:92]
  wire [17:0] _GEN_15 = reset ? 18'h0 : _GEN_3; // @[dut.scala 16:{27,27}]
  wire [17:0] _GEN_16 = reset ? 18'h0 : _GEN_6; // @[dut.scala 16:{27,27}]
  wire [17:0] _GEN_17 = reset ? 18'h0 : _GEN_9; // @[dut.scala 16:{27,27}]
  assign io_result = {result_hi,result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = pipe_en_3; // @[dut.scala 49:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      pipe_en_0 <= 1'h0; // @[dut.scala 15:26]
    end else if (io_i_en) begin // @[dut.scala 24:17]
      pipe_en_0 <= io_i_en; // @[dut.scala 28:16]
    end
    if (reset) begin // @[dut.scala 15:26]
      pipe_en_1 <= 1'h0; // @[dut.scala 15:26]
    end else begin
      pipe_en_1 <= pipe_en_0;
    end
    if (reset) begin // @[dut.scala 15:26]
      pipe_en_2 <= 1'h0; // @[dut.scala 15:26]
    end else begin
      pipe_en_2 <= pipe_en_1;
    end
    if (reset) begin // @[dut.scala 15:26]
      pipe_en_3 <= 1'h0; // @[dut.scala 15:26]
    end else begin
      pipe_en_3 <= pipe_en_2;
    end
    if (reset) begin // @[dut.scala 16:27]
      partialSum_0 <= 17'h0; // @[dut.scala 16:27]
    end else if (io_i_en) begin // @[dut.scala 24:17]
      partialSum_0 <= res0; // @[dut.scala 26:19]
    end
    partialSum_1 <= _GEN_15[16:0]; // @[dut.scala 16:{27,27}]
    partialSum_2 <= _GEN_16[16:0]; // @[dut.scala 16:{27,27}]
    partialSum_3 <= _GEN_17[16:0]; // @[dut.scala 16:{27,27}]
    if (reset) begin // @[dut.scala 17:26]
      carry_0 <= 1'h0; // @[dut.scala 17:26]
    end else if (io_i_en) begin // @[dut.scala 24:17]
      carry_0 <= res0[16]; // @[dut.scala 27:14]
    end
    if (reset) begin // @[dut.scala 17:26]
      carry_1 <= 1'h0; // @[dut.scala 17:26]
    end else if (pipe_en_0) begin // @[dut.scala 33:24]
      carry_1 <= res[16]; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 17:26]
      carry_2 <= 1'h0; // @[dut.scala 17:26]
    end else if (pipe_en_1) begin // @[dut.scala 33:24]
      carry_2 <= res_1[16]; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 17:26]
      carry_3 <= 1'h0; // @[dut.scala 17:26]
    end else if (pipe_en_2) begin // @[dut.scala 33:24]
      carry_3 <= res_2[16]; // @[dut.scala 36:16]
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
  pipe_en_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  pipe_en_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  pipe_en_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  pipe_en_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  partialSum_0 = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  partialSum_1 = _RAND_5[16:0];
  _RAND_6 = {1{`RANDOM}};
  partialSum_2 = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  partialSum_3 = _RAND_7[16:0];
  _RAND_8 = {1{`RANDOM}};
  carry_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  carry_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  carry_2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  carry_3 = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
