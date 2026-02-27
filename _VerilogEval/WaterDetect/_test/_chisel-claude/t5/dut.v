module WaterReservoirController(
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
  reg [1:0] state; // @[dut.scala 18:22]
  reg [1:0] prevState; // @[dut.scala 21:26]
  wire [1:0] _GEN_0 = io_s == 3'h1 ? 2'h2 : 2'h3; // @[dut.scala 30:33 31:24 33:24]
  wire [1:0] _GEN_1 = io_s == 3'h3 ? 2'h1 : _GEN_0; // @[dut.scala 28:33 29:24]
  wire [1:0] currentSensorState = io_s == 3'h7 ? 2'h0 : _GEN_1; // @[dut.scala 26:27 27:24]
  wire  _io_fr1_T_1 = state == 2'h2; // @[dut.scala 48:48]
  wire  _io_fr1_T_3 = state == 2'h3; // @[dut.scala 48:76]
  assign io_fr3 = state == 2'h3; // @[dut.scala 50:20]
  assign io_fr2 = _io_fr1_T_1 | _io_fr1_T_3; // @[dut.scala 49:38]
  assign io_fr1 = state == 2'h1 | state == 2'h2 | state == 2'h3; // @[dut.scala 48:66]
  assign io_dfr = state > prevState | _io_fr1_T_3; // @[dut.scala 54:33]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 18:22]
      state <= 2'h3; // @[dut.scala 18:22]
    end else if (io_reset) begin // @[dut.scala 37:18]
      state <= 2'h3; // @[dut.scala 38:11]
    end else if (state != currentSensorState) begin // @[dut.scala 41:40]
      if (io_s == 3'h7) begin // @[dut.scala 26:27]
        state <= 2'h0; // @[dut.scala 27:24]
      end else begin
        state <= _GEN_1;
      end
    end
    if (reset) begin // @[dut.scala 21:26]
      prevState <= 2'h3; // @[dut.scala 21:26]
    end else if (io_reset) begin // @[dut.scala 37:18]
      prevState <= 2'h3; // @[dut.scala 39:15]
    end else if (state != currentSensorState) begin // @[dut.scala 41:40]
      prevState <= state; // @[dut.scala 42:17]
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
  wire  controller_clock; // @[dut.scala 67:26]
  wire  controller_reset; // @[dut.scala 67:26]
  wire [2:0] controller_io_s; // @[dut.scala 67:26]
  wire  controller_io_reset; // @[dut.scala 67:26]
  wire  controller_io_fr3; // @[dut.scala 67:26]
  wire  controller_io_fr2; // @[dut.scala 67:26]
  wire  controller_io_fr1; // @[dut.scala 67:26]
  wire  controller_io_dfr; // @[dut.scala 67:26]
  WaterReservoirController controller ( // @[dut.scala 67:26]
    .clock(controller_clock),
    .reset(controller_reset),
    .io_s(controller_io_s),
    .io_reset(controller_io_reset),
    .io_fr3(controller_io_fr3),
    .io_fr2(controller_io_fr2),
    .io_fr1(controller_io_fr1),
    .io_dfr(controller_io_dfr)
  );
  assign io_fr3 = controller_io_fr3; // @[dut.scala 76:10]
  assign io_fr2 = controller_io_fr2; // @[dut.scala 75:10]
  assign io_fr1 = controller_io_fr1; // @[dut.scala 74:10]
  assign io_dfr = controller_io_dfr; // @[dut.scala 77:10]
  assign controller_clock = clock;
  assign controller_reset = reset;
  assign controller_io_s = io_s; // @[dut.scala 70:19]
  assign controller_io_reset = reset; // @[dut.scala 71:23]
endmodule
