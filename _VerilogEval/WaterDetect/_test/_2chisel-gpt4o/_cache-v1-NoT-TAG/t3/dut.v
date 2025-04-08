module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] currentStateReg; // @[dut.scala 31:32]
  reg [1:0] previousStateReg; // @[dut.scala 32:33]
  wire  _io_fr3_T = currentStateReg == 2'h0; // @[dut.scala 44:29]
  wire  _io_fr2_T = currentStateReg == 2'h1; // @[dut.scala 45:30]
  wire  isLevelRising = currentStateReg < previousStateReg; // @[dut.scala 49:39]
  assign io_fr3 = currentStateReg == 2'h0; // @[dut.scala 44:29]
  assign io_fr2 = currentStateReg == 2'h1 | _io_fr3_T; // @[dut.scala 45:58]
  assign io_fr1 = currentStateReg == 2'h2 | _io_fr2_T | _io_fr3_T; // @[dut.scala 46:106]
  assign io_dfr = _io_fr3_T | isLevelRising; // @[dut.scala 50:54]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 31:32]
      currentStateReg <= 2'h0; // @[dut.scala 31:32]
    end else if (reset) begin // @[dut.scala 35:22]
      currentStateReg <= 2'h0; // @[dut.scala 36:21]
    end else if (io_s[2]) begin // @[dut.scala 22:17]
      currentStateReg <= 2'h3; // @[dut.scala 23:18]
    end else if (io_s[1]) begin // @[dut.scala 24:23]
      currentStateReg <= 2'h2; // @[dut.scala 25:18]
    end else begin
      currentStateReg <= {{1'd0}, io_s[0]};
    end
    if (reset) begin // @[dut.scala 32:33]
      previousStateReg <= 2'h0; // @[dut.scala 32:33]
    end else if (reset) begin // @[dut.scala 35:22]
      previousStateReg <= 2'h0; // @[dut.scala 37:22]
    end else begin
      previousStateReg <= currentStateReg; // @[dut.scala 39:22]
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
  currentStateReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  previousStateReg = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
