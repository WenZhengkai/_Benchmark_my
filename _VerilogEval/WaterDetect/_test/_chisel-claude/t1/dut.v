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
  reg [1:0] currentState; // @[dut.scala 21:29]
  reg [1:0] previousState; // @[dut.scala 24:30]
  wire [1:0] _GEN_1 = io_s[1] & io_s[0] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 30:38 31:16]
  wire [1:0] waterLevel = io_s[2] & io_s[1] & io_s[0] ? 2'h3 : _GEN_1; // @[dut.scala 28:45 29:16]
  wire  isRising = currentState > previousState; // @[dut.scala 48:31]
  wire  _io_fr3_T = currentState == 2'h0; // @[dut.scala 59:28]
  wire  _io_fr2_T_2 = _io_fr3_T | currentState == 2'h1; // @[dut.scala 60:41]
  assign io_fr3 = io_reset | currentState == 2'h0; // @[dut.scala 51:18 53:12 59:12]
  assign io_fr2 = io_reset | (_io_fr3_T | currentState == 2'h1); // @[dut.scala 51:18 54:12 60:12]
  assign io_fr1 = io_reset | (_io_fr2_T_2 | currentState == 2'h2); // @[dut.scala 51:18 55:12 61:12]
  assign io_dfr = io_reset | isRising; // @[dut.scala 51:18 56:12 64:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:29]
      currentState <= 2'h0; // @[dut.scala 21:29]
    end else if (io_reset) begin // @[dut.scala 39:18]
      currentState <= 2'h0; // @[dut.scala 40:18]
    end else if (waterLevel != currentState) begin // @[dut.scala 42:43]
      if (io_s[2] & io_s[1] & io_s[0]) begin // @[dut.scala 28:45]
        currentState <= 2'h3; // @[dut.scala 29:16]
      end else begin
        currentState <= _GEN_1;
      end
    end
    if (reset) begin // @[dut.scala 24:30]
      previousState <= 2'h0; // @[dut.scala 24:30]
    end else if (io_reset) begin // @[dut.scala 39:18]
      previousState <= 2'h0; // @[dut.scala 41:19]
    end else if (waterLevel != currentState) begin // @[dut.scala 42:43]
      previousState <= currentState; // @[dut.scala 43:19]
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
  currentState = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  previousState = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
