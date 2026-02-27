module WaterReservoirController(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr,
  input        io_reset
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] state; // @[dut.scala 18:22]
  reg [1:0] prevState; // @[dut.scala 19:26]
  wire [1:0] _currentState_T_1 = 3'h7 == io_s ? 2'h0 : 2'h3; // @[Mux.scala 81:58]
  wire [1:0] _currentState_T_3 = 3'h3 == io_s ? 2'h1 : _currentState_T_1; // @[Mux.scala 81:58]
  wire [1:0] _currentState_T_5 = 3'h1 == io_s ? 2'h2 : _currentState_T_3; // @[Mux.scala 81:58]
  wire [1:0] currentState = 3'h0 == io_s ? 2'h3 : _currentState_T_5; // @[Mux.scala 81:58]
  wire  _GEN_5 = 2'h2 == state | 2'h3 == state; // @[dut.scala 54:18 67:14]
  wire  _GEN_6 = 2'h2 == state ? 1'h0 : 2'h3 == state; // @[dut.scala 54:18 69:14]
  wire  _GEN_7 = 2'h1 == state | _GEN_5; // @[dut.scala 54:18 62:14]
  wire  _GEN_8 = 2'h1 == state ? 1'h0 : _GEN_5; // @[dut.scala 54:18 63:14]
  wire  _GEN_9 = 2'h1 == state ? 1'h0 : _GEN_6; // @[dut.scala 54:18 64:14]
  assign io_fr3 = 2'h0 == state ? 1'h0 : _GEN_9; // @[dut.scala 54:18 59:14]
  assign io_fr2 = 2'h0 == state ? 1'h0 : _GEN_8; // @[dut.scala 54:18 58:14]
  assign io_fr1 = 2'h0 == state ? 1'h0 : _GEN_7; // @[dut.scala 54:18 57:14]
  assign io_dfr = prevState > state; // @[dut.scala 80:23]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h3; // @[dut.scala 18:22]
    end else if (io_reset) begin // @[dut.scala 31:19]
      state <= 2'h3; // @[dut.scala 32:11]
    end else if (state != currentState) begin // @[dut.scala 35:35]
      if (3'h0 == io_s) begin // @[Mux.scala 81:58]
        state <= 2'h3;
      end else begin
        state <= _currentState_T_5;
      end
    end
    if (reset) begin // @[dut.scala 19:26]
      prevState <= 2'h3; // @[dut.scala 19:26]
    end else if (io_reset) begin // @[dut.scala 31:19]
      prevState <= 2'h3; // @[dut.scala 33:15]
    end else if (state != currentState) begin // @[dut.scala 35:35]
      prevState <= state; // @[dut.scala 36:17]
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
  state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  prevState = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dut(
  input        clock,
  input        reset,
  input  [2:0] io_s,
  output       io_fr3,
  output       io_fr2,
  output       io_fr1,
  output       io_dfr
);
  wire  controller_clock; // @[dut.scala 99:26]
  wire  controller_reset; // @[dut.scala 99:26]
  wire [2:0] controller_io_s; // @[dut.scala 99:26]
  wire  controller_io_fr3; // @[dut.scala 99:26]
  wire  controller_io_fr2; // @[dut.scala 99:26]
  wire  controller_io_fr1; // @[dut.scala 99:26]
  wire  controller_io_dfr; // @[dut.scala 99:26]
  wire  controller_io_reset; // @[dut.scala 99:26]
  WaterReservoirController controller ( // @[dut.scala 99:26]
    .clock(controller_clock),
    .reset(controller_reset),
    .io_s(controller_io_s),
    .io_fr3(controller_io_fr3),
    .io_fr2(controller_io_fr2),
    .io_fr1(controller_io_fr1),
    .io_dfr(controller_io_dfr),
    .io_reset(controller_io_reset)
  );
  assign io_fr3 = controller_io_fr3; // @[dut.scala 106:10]
  assign io_fr2 = controller_io_fr2; // @[dut.scala 105:10]
  assign io_fr1 = controller_io_fr1; // @[dut.scala 104:10]
  assign io_dfr = controller_io_dfr; // @[dut.scala 107:10]
  assign controller_clock = clock;
  assign controller_reset = reset;
  assign controller_io_s = io_s; // @[dut.scala 101:19]
  assign controller_io_reset = reset; // @[dut.scala 102:32]
endmodule
