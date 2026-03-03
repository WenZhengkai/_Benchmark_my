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
  wire [1:0] _GEN_1 = io_s[1] ? 2'h2 : {{1'd0}, io_s[0]}; // @[dut.scala 19:23 20:11]
  wire [1:0] level = io_s[2] ? 2'h3 : _GEN_1; // @[dut.scala 17:17 18:11]
  reg [1:0] lastLevel; // @[dut.scala 28:22]
  reg [1:0] prevLevel; // @[dut.scala 29:22]
  wire [1:0] _GEN_3 = level != lastLevel ? lastLevel : prevLevel; // @[dut.scala 35:31 36:17 29:22]
  wire  fr1Nom = level <= 2'h2; // @[dut.scala 45:22]
  wire  fr2Nom = level <= 2'h1; // @[dut.scala 46:22]
  wire  fr3Nom = level == 2'h0; // @[dut.scala 47:22]
  wire  dfrMid = _GEN_3 < level; // @[dut.scala 53:30]
  wire  _dfrNom_T_2 = level == 2'h3 ? 1'h0 : dfrMid; // @[dut.scala 54:46]
  wire  dfrNom = fr3Nom | _dfrNom_T_2; // @[dut.scala 54:19]
  assign io_fr3 = reset | fr3Nom; // @[dut.scala 59:16]
  assign io_fr2 = reset | fr2Nom; // @[dut.scala 58:16]
  assign io_fr1 = reset | fr1Nom; // @[dut.scala 57:16]
  assign io_dfr = reset | dfrNom; // @[dut.scala 60:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 31:22]
      lastLevel <= 2'h0; // @[dut.scala 32:15]
    end else if (level != lastLevel) begin // @[dut.scala 35:31]
      if (io_s[2]) begin // @[dut.scala 17:17]
        lastLevel <= 2'h3; // @[dut.scala 18:11]
      end else if (io_s[1]) begin // @[dut.scala 19:23]
        lastLevel <= 2'h2; // @[dut.scala 20:11]
      end else begin
        lastLevel <= {{1'd0}, io_s[0]};
      end
    end
    if (reset) begin // @[dut.scala 31:22]
      prevLevel <= 2'h0; // @[dut.scala 33:15]
    end else if (level != lastLevel) begin // @[dut.scala 35:31]
      prevLevel <= lastLevel; // @[dut.scala 36:17]
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
  lastLevel = _RAND_0[1:0];
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
