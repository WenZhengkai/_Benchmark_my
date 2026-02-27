module dut(
  input        clock,
  input        reset,
  input  [2:0] io_r,
  output [2:0] io_g
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg  state; // @[dut.scala 15:22]
  wire [1:0] _GEN_0 = {{1'd0}, state}; // @[dut.scala 19:12]
  wire  _io_g_T = _GEN_0 == 2'h2; // @[dut.scala 19:12]
  wire [2:0] _GEN_1 = {{2'd0}, state}; // @[dut.scala 20:12]
  wire  _io_g_T_1 = _GEN_1 == 3'h4; // @[dut.scala 20:12]
  wire [3:0] _GEN_2 = {{3'd0}, state}; // @[dut.scala 21:12]
  wire  _io_g_T_2 = _GEN_2 == 4'h8; // @[dut.scala 21:12]
  wire [2:0] _io_g_T_3 = _io_g_T_2 ? 3'h4 : 3'h0; // @[Mux.scala 101:16]
  wire [2:0] _io_g_T_4 = _io_g_T_1 ? 3'h2 : _io_g_T_3; // @[Mux.scala 101:16]
  wire  _state_T_5 = ~io_r[0] & io_r[1]; // @[dut.scala 28:17]
  wire  _state_T_6 = io_r == 3'h4; // @[dut.scala 29:13]
  wire [3:0] _state_T_7 = _state_T_6 ? 4'h8 : 4'h1; // @[Mux.scala 101:16]
  wire [3:0] _state_T_8 = _state_T_5 ? 4'h4 : _state_T_7; // @[Mux.scala 101:16]
  wire [3:0] _state_T_9 = io_r[0] ? 4'h2 : _state_T_8; // @[Mux.scala 101:16]
  wire [1:0] _state_T_12 = io_r[0] ? 2'h2 : 2'h1; // @[dut.scala 31:26]
  wire [2:0] _state_T_15 = io_r[1] ? 3'h4 : 3'h1; // @[dut.scala 32:26]
  wire [3:0] _state_T_18 = io_r[2] ? 4'h8 : 4'h1; // @[dut.scala 33:26]
  wire [3:0] _state_T_19 = _io_g_T_2 ? _state_T_18 : {{3'd0}, state}; // @[Mux.scala 101:16]
  wire [3:0] _state_T_20 = _io_g_T_1 ? {{1'd0}, _state_T_15} : _state_T_19; // @[Mux.scala 101:16]
  wire [3:0] _state_T_21 = _io_g_T ? {{2'd0}, _state_T_12} : _state_T_20; // @[Mux.scala 101:16]
  wire [3:0] _state_T_22 = state ? _state_T_9 : _state_T_21; // @[Mux.scala 101:16]
  wire [3:0] _GEN_6 = reset ? 4'h1 : _state_T_22; // @[dut.scala 15:{22,22} 25:9]
  assign io_g = _io_g_T ? 3'h1 : _io_g_T_4; // @[Mux.scala 101:16]
  always @(posedge clock) begin
    state <= _GEN_6[0]; // @[dut.scala 15:{22,22} 25:9]
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
  state = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
