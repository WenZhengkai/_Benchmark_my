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
  reg [2:0] state; // @[dut.scala 16:22]
  reg [2:0] prevSensors; // @[dut.scala 19:28]
  wire  s1 = io_s[0]; // @[dut.scala 28:16]
  wire  s2 = io_s[1]; // @[dut.scala 29:16]
  wire  s3 = io_s[2]; // @[dut.scala 30:16]
  wire  _T = s1 & s2; // @[dut.scala 34:11]
  wire  _T_3 = ~s3; // @[dut.scala 36:26]
  wire  _T_8 = s1 & ~s2 & _T_3; // @[dut.scala 38:24]
  wire [1:0] _GEN_1 = _T & ~s3 ? 2'h2 : {{1'd0}, _T_8}; // @[dut.scala 36:31 37:16]
  wire [1:0] _GEN_2 = s1 & s2 & s3 ? 2'h3 : _GEN_1; // @[dut.scala 34:24 35:16]
  wire [2:0] waterLevel = {{1'd0}, _GEN_2}; // @[dut.scala 33:24]
  wire  isRising = waterLevel > prevSensors; // @[dut.scala 45:29]
  wire [2:0] _GEN_3 = 3'h3 == waterLevel ? 3'h4 : state; // @[dut.scala 16:22 61:24 65:23]
  wire [2:0] _GEN_4 = 3'h2 == waterLevel ? 3'h3 : _GEN_3; // @[dut.scala 61:24 64:23]
  wire  _T_13 = 3'h1 == state; // @[dut.scala 69:19]
  wire  _GEN_10 = 3'h2 == state | 3'h3 == state; // @[dut.scala 69:19 78:16]
  wire  _GEN_13 = 3'h1 == state | _GEN_10; // @[dut.scala 69:19 72:16]
  wire  _GEN_14 = 3'h1 == state | 3'h2 == state; // @[dut.scala 69:19 73:16]
  assign io_fr3 = io_reset | _T_13; // @[dut.scala 48:18 54:12]
  assign io_fr2 = io_reset | _GEN_14; // @[dut.scala 48:18 53:12]
  assign io_fr1 = io_reset | _GEN_13; // @[dut.scala 48:18 52:12]
  assign io_dfr = io_reset | isRising; // @[dut.scala 48:18 55:12 97:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:22]
      state <= 3'h1; // @[dut.scala 16:22]
    end else if (io_reset) begin // @[dut.scala 48:18]
      state <= 3'h1; // @[dut.scala 50:11]
    end else if (3'h0 == waterLevel) begin // @[dut.scala 61:24]
      state <= 3'h1; // @[dut.scala 62:23]
    end else if (3'h1 == waterLevel) begin // @[dut.scala 61:24]
      state <= 3'h2; // @[dut.scala 63:23]
    end else begin
      state <= _GEN_4;
    end
    if (reset) begin // @[dut.scala 19:28]
      prevSensors <= 3'h0; // @[dut.scala 19:28]
    end else if (io_reset) begin // @[dut.scala 48:18]
      prevSensors <= 3'h0; // @[dut.scala 51:17]
    end else begin
      prevSensors <= io_s; // @[dut.scala 58:17]
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
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  prevSensors = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
