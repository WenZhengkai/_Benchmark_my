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
  wire [1:0] _levelNow_T_4 = io_s[1] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 15:36]
  wire [1:0] levelNow = io_s[2] ? 2'h3 : _levelNow_T_4; // @[dut.scala 15:18]
  reg [1:0] currentLevel; // @[dut.scala 19:29]
  reg [1:0] prevLevel; // @[dut.scala 20:29]
  wire  _io_fr3_T = currentLevel == 2'h0; // @[dut.scala 30:27]
  wire  _io_dfr_T_3 = currentLevel == 2'h3 ? 1'h0 : prevLevel < currentLevel; // @[dut.scala 39:8]
  assign io_fr3 = currentLevel == 2'h0; // @[dut.scala 30:27]
  assign io_fr2 = currentLevel <= 2'h1; // @[dut.scala 29:27]
  assign io_fr1 = currentLevel <= 2'h2; // @[dut.scala 28:27]
  assign io_dfr = _io_fr3_T | _io_dfr_T_3; // @[dut.scala 36:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:29]
      currentLevel <= 2'h0; // @[dut.scala 19:29]
    end else if (levelNow != currentLevel) begin // @[dut.scala 22:35]
      if (io_s[2]) begin // @[dut.scala 15:18]
        currentLevel <= 2'h3;
      end else if (io_s[1]) begin // @[dut.scala 15:36]
        currentLevel <= 2'h2;
      end else begin
        currentLevel <= {{1'd0}, io_s[0]};
      end
    end
    if (reset) begin // @[dut.scala 20:29]
      prevLevel <= 2'h0; // @[dut.scala 20:29]
    end else if (levelNow != currentLevel) begin // @[dut.scala 22:35]
      prevLevel <= currentLevel; // @[dut.scala 23:18]
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
  currentLevel = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  prevLevel = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
