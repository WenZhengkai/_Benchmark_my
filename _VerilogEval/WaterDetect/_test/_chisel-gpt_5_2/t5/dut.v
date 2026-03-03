module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  input        io_reset,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _levelNow_T_1 = 3'h7 == io_s ? 2'h0 : 2'h3; // @[Mux.scala 81:58]
  wire [1:0] _levelNow_T_3 = 3'h3 == io_s ? 2'h1 : _levelNow_T_1; // @[Mux.scala 81:58]
  wire [1:0] _levelNow_T_5 = 3'h1 == io_s ? 2'h2 : _levelNow_T_3; // @[Mux.scala 81:58]
  wire [1:0] levelNow = 3'h0 == io_s ? 2'h3 : _levelNow_T_5; // @[Mux.scala 81:58]
  reg [1:0] prevLevel; // @[dut.scala 50:26]
  wire  sensorChanged = levelNow != prevLevel; // @[dut.scala 53:29]
  wire  rising = sensorChanged & levelNow < prevLevel; // @[dut.scala 56:30]
  wire  _GEN_3 = 2'h2 == levelNow | 2'h3 == levelNow; // @[dut.scala 70:20 78:13]
  wire  _GEN_4 = 2'h2 == levelNow ? 1'h0 : 2'h3 == levelNow; // @[dut.scala 70:20 78:49]
  wire  _GEN_5 = 2'h1 == levelNow | _GEN_3; // @[dut.scala 70:20 75:13]
  wire  _GEN_6 = 2'h1 == levelNow ? 1'h0 : _GEN_3; // @[dut.scala 70:20 75:31]
  wire  _GEN_7 = 2'h1 == levelNow ? 1'h0 : _GEN_4; // @[dut.scala 70:20 75:49]
  wire  n_fr1 = 2'h0 == levelNow ? 1'h0 : _GEN_5; // @[dut.scala 70:20 72:13]
  wire  n_fr2 = 2'h0 == levelNow ? 1'h0 : _GEN_6; // @[dut.scala 70:20 72:31]
  wire  n_fr3 = 2'h0 == levelNow ? 1'h0 : _GEN_7; // @[dut.scala 70:20 72:49]
  reg  dfrReg; // @[dut.scala 87:23]
  wire  _GEN_11 = sensorChanged ? rising : dfrReg; // @[dut.scala 90:31 91:12 87:23]
  wire  _GEN_12 = io_reset | _GEN_11; // @[dut.scala 88:19 89:12]
  assign io_fr3 = io_reset | n_fr3; // @[dut.scala 97:16]
  assign io_fr2 = io_reset | n_fr2; // @[dut.scala 96:16]
  assign io_fr1 = io_reset | n_fr1; // @[dut.scala 95:16]
  assign io_dfr = dfrReg; // @[dut.scala 98:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 50:26]
      prevLevel <= 2'h3; // @[dut.scala 50:26]
    end else if (io_reset) begin // @[dut.scala 59:19]
      prevLevel <= 2'h3; // @[dut.scala 60:15]
    end else if (sensorChanged) begin // @[dut.scala 61:31]
      if (3'h0 == io_s) begin // @[Mux.scala 81:58]
        prevLevel <= 2'h3;
      end else begin
        prevLevel <= _levelNow_T_5;
      end
    end
    dfrReg <= reset | _GEN_12; // @[dut.scala 87:{23,23}]
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
  prevLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  dfrReg = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
