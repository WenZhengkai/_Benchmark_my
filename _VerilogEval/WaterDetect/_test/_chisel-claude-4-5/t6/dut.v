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
  wire  _levelAboveS3_T = s1 & s2; // @[dut.scala 19:25]
  wire  levelAboveS3 = s1 & s2 & s3; // @[dut.scala 19:31]
  wire  _levelBetweenS3S2_T_1 = ~s3; // @[dut.scala 20:38]
  wire  levelBetweenS3S2 = _levelAboveS3_T & ~s3; // @[dut.scala 20:35]
  wire  _levelBetweenS2S1_T = ~s2; // @[dut.scala 21:32]
  wire  levelBetweenS2S1 = s1 & ~s2 & _levelBetweenS3S2_T_1; // @[dut.scala 21:36]
  wire  levelBelowS1 = ~s1 & _levelBetweenS2S1_T & _levelBetweenS3S2_T_1; // @[dut.scala 22:33]
  reg [1:0] prevLevel; // @[dut.scala 26:26]
  wire [1:0] _currLevel_T_2 = levelBetweenS3S2 ? 2'h2 : {{1'd0}, levelBetweenS2S1}; // @[Mux.scala 101:16]
  wire [1:0] currLevel = levelAboveS3 ? 2'h3 : _currLevel_T_2; // @[Mux.scala 101:16]
  wire  waterRising = prevLevel < currLevel; // @[dut.scala 43:31]
  wire  nominalFr1 = levelAboveS3 ? 1'h0 : levelBetweenS3S2 | (levelBetweenS2S1 | levelBelowS1); // @[Mux.scala 101:16]
  wire  _nominalFr2_T_2 = levelBetweenS3S2 ? 1'h0 : levelBetweenS2S1 | levelBelowS1; // @[Mux.scala 101:16]
  wire  nominalFr2 = levelAboveS3 ? 1'h0 : _nominalFr2_T_2; // @[Mux.scala 101:16]
  wire  _nominalFr3_T_1 = levelBetweenS2S1 ? 1'h0 : levelBelowS1; // @[Mux.scala 101:16]
  wire  _nominalFr3_T_2 = levelBetweenS3S2 ? 1'h0 : _nominalFr3_T_1; // @[Mux.scala 101:16]
  wire  nominalFr3 = levelAboveS3 ? 1'h0 : _nominalFr3_T_2; // @[Mux.scala 101:16]
  wire  supplementalFlow = waterRising & ~levelAboveS3; // @[dut.scala 73:38]
  assign io_fr3 = reset | nominalFr3; // @[dut.scala 78:10 83:22 87:12]
  assign io_fr2 = reset | nominalFr2; // @[dut.scala 77:10 83:22 86:12]
  assign io_fr1 = reset | nominalFr1; // @[dut.scala 76:10 83:22 85:12]
  assign io_dfr = reset | supplementalFlow; // @[dut.scala 79:10 83:22 88:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 26:26]
      prevLevel <= 2'h0; // @[dut.scala 26:26]
    end else if (reset) begin // @[dut.scala 83:22]
      prevLevel <= 2'h0; // @[dut.scala 84:15]
    end else if (currLevel != prevLevel) begin // @[dut.scala 38:33]
      if (levelAboveS3) begin // @[Mux.scala 101:16]
        prevLevel <= 2'h3;
      end else begin
        prevLevel <= _currLevel_T_2;
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
  prevLevel = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
