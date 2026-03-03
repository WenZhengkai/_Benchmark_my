module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_rst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [1:0] _levelNow_T_5 = 3'h3 == io_s ? 2'h2 : {{1'd0}, 3'h1 == io_s}; // @[Mux.scala 81:58]
  wire [1:0] levelNow = 3'h7 == io_s ? 2'h3 : _levelNow_T_5; // @[Mux.scala 81:58]
  reg [1:0] levelPrev; // @[dut.scala 48:26]
  wire  rising = levelNow > levelPrev; // @[dut.scala 59:25]
  wire  fr3Nom = 2'h0 == levelNow; // @[dut.scala 66:20]
  wire  _GEN_5 = 2'h1 == levelNow | 2'h2 == levelNow; // @[dut.scala 66:20 71:14]
  wire  fr1Nom = fr3Nom | _GEN_5; // @[dut.scala 66:20 68:14]
  wire  fr2Nom = fr3Nom | 2'h1 == levelNow; // @[dut.scala 66:20 68:32]
  wire  dfrNom = rising & levelNow != 2'h3; // @[dut.scala 82:23]
  assign io_fr3 = io_rst | fr3Nom; // @[dut.scala 90:17 93:12 98:12]
  assign io_fr2 = io_rst | fr2Nom; // @[dut.scala 90:17 92:12 97:12]
  assign io_fr1 = io_rst | fr1Nom; // @[dut.scala 90:17 91:12 96:12]
  assign io_dfr = io_rst | dfrNom; // @[dut.scala 90:17 94:12 99:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 48:26]
      levelPrev <= 2'h0; // @[dut.scala 48:26]
    end else if (io_rst) begin // @[dut.scala 51:17]
      levelPrev <= 2'h0; // @[dut.scala 52:15]
    end else if (levelNow != levelPrev) begin // @[dut.scala 53:40]
      if (3'h7 == io_s) begin // @[Mux.scala 81:58]
        levelPrev <= 2'h3;
      end else begin
        levelPrev <= _levelNow_T_5;
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
  levelPrev = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
