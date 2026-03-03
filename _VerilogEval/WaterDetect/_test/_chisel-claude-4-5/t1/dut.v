module dut(
  input        clock,
  input        reset,
  input  [3:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  s1 = io_s[1]; // @[dut.scala 14:16]
  wire  s2 = io_s[2]; // @[dut.scala 15:16]
  wire  s3 = io_s[3]; // @[dut.scala 16:16]
  wire [2:0] sensors = {s3,s2,s1}; // @[Cat.scala 33:92]
  reg [2:0] prevSensors; // @[dut.scala 22:28]
  wire  _T_2 = sensors == 3'h1; // @[dut.scala 30:22]
  wire [1:0] _GEN_1 = sensors == 3'h3 ? 2'h2 : {{1'd0}, _T_2}; // @[dut.scala 28:36 29:18]
  wire [1:0] _GEN_2 = sensors == 3'h7 ? 2'h3 : _GEN_1; // @[dut.scala 26:30 27:18]
  wire  _T_5 = prevSensors == 3'h1; // @[dut.scala 42:26]
  wire [1:0] _GEN_4 = prevSensors == 3'h3 ? 2'h2 : {{1'd0}, _T_5}; // @[dut.scala 40:40 41:15]
  wire [1:0] _GEN_5 = prevSensors == 3'h7 ? 2'h3 : _GEN_4; // @[dut.scala 38:34 39:15]
  wire [2:0] prevLevel = {{1'd0}, _GEN_5}; // @[dut.scala 37:30]
  wire [2:0] currentLevel = {{1'd0}, _GEN_2}; // @[dut.scala 25:33]
  wire  levelRising = prevLevel < currentLevel; // @[dut.scala 49:31]
  wire  nominalFr3 = 3'h0 == currentLevel; // @[dut.scala 56:24]
  wire  _GEN_9 = 3'h1 == currentLevel | 3'h2 == currentLevel; // @[dut.scala 56:24 63:18]
  wire  nominalFr1 = nominalFr3 | _GEN_9; // @[dut.scala 56:24 58:18]
  wire  nominalFr2 = nominalFr3 | 3'h1 == currentLevel; // @[dut.scala 56:24 59:18]
  wire  supplementalFlow = levelRising & sensors != prevSensors; // @[dut.scala 80:38]
  assign io_fr3 = reset | nominalFr3; // @[dut.scala 85:10 96:22 99:12]
  assign io_fr2 = reset | nominalFr2; // @[dut.scala 84:10 96:22 98:12]
  assign io_fr1 = reset | nominalFr1; // @[dut.scala 83:10 96:22 97:12]
  assign io_dfr = reset | supplementalFlow; // @[dut.scala 100:12 86:10 96:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:28]
      prevSensors <= 3'h0; // @[dut.scala 22:28]
    end else if (reset) begin // @[dut.scala 89:22]
      prevSensors <= 3'h0; // @[dut.scala 90:17]
    end else begin
      prevSensors <= sensors; // @[dut.scala 92:17]
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
  prevSensors = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
