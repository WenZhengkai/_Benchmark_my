module dut(
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
  reg [1:0] state; // @[dut.scala 15:22]
  reg [1:0] prevState; // @[dut.scala 18:26]
  wire  _state_T = io_s == 3'h0; // @[dut.scala 27:13]
  wire  _state_T_1 = io_s == 3'h1; // @[dut.scala 28:13]
  wire  _state_T_2 = io_s == 3'h3; // @[dut.scala 29:13]
  wire  _state_T_3 = io_s == 3'h7; // @[dut.scala 30:13]
  wire [1:0] _state_T_4 = _state_T_3 ? 2'h3 : state; // @[Mux.scala 101:16]
  wire [1:0] _state_T_5 = _state_T_2 ? 2'h2 : _state_T_4; // @[Mux.scala 101:16]
  wire  _io_fr1_T = state == 2'h0; // @[dut.scala 35:23]
  wire  _io_fr1_T_1 = state == 2'h1; // @[dut.scala 35:50]
  assign io_fr3 = state == 2'h0; // @[dut.scala 37:23]
  assign io_fr2 = _io_fr1_T | _io_fr1_T_1; // @[dut.scala 36:16]
  assign io_fr1 = state == 2'h0 | (state == 2'h1 | state == 2'h2); // @[dut.scala 35:16]
  assign io_dfr = state > prevState; // @[dut.scala 40:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      state <= 2'h0; // @[dut.scala 15:22]
    end else if (io_reset) begin // @[dut.scala 21:18]
      state <= 2'h0; // @[dut.scala 22:11]
    end else if (_state_T) begin // @[Mux.scala 101:16]
      state <= 2'h0;
    end else if (_state_T_1) begin // @[Mux.scala 101:16]
      state <= 2'h1;
    end else begin
      state <= _state_T_5;
    end
    if (reset) begin // @[dut.scala 18:26]
      prevState <= 2'h0; // @[dut.scala 18:26]
    end else if (io_reset) begin // @[dut.scala 21:18]
      prevState <= 2'h0; // @[dut.scala 23:15]
    end else begin
      prevState <= state; // @[dut.scala 25:15]
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
