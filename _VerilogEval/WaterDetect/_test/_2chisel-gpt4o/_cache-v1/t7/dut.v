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
  reg [1:0] state; // @[dut.scala 20:22]
  reg [1:0] prev_state; // @[dut.scala 21:27]
  wire  _T_1 = io_s == 3'h7; // @[dut.scala 37:17]
  wire  _T_2 = io_s == 3'h3; // @[dut.scala 39:23]
  wire [1:0] _GEN_0 = io_s == 3'h3 ? state : prev_state; // @[dut.scala 39:37 40:20 21:27]
  wire [1:0] _GEN_1 = io_s == 3'h3 ? 2'h2 : state; // @[dut.scala 39:37 41:15 20:22]
  wire  _T_5 = io_s == 3'h1; // @[dut.scala 52:23]
  wire [1:0] _GEN_4 = _T_1 ? state : prev_state; // @[dut.scala 55:37 56:20 21:27]
  wire [1:0] _GEN_5 = _T_1 ? 2'h3 : state; // @[dut.scala 55:37 57:15 20:22]
  wire [1:0] _GEN_6 = io_s == 3'h1 ? state : _GEN_4; // @[dut.scala 52:37 53:20]
  wire [1:0] _GEN_7 = io_s == 3'h1 ? 2'h1 : _GEN_5; // @[dut.scala 52:37 54:15]
  wire [1:0] _GEN_8 = _T_2 ? 2'h2 : _GEN_7; // @[dut.scala 50:31 51:15]
  wire [1:0] _GEN_9 = _T_2 ? prev_state : _GEN_6; // @[dut.scala 21:27 50:31]
  wire  _T_10 = io_s == 3'h0; // @[dut.scala 71:23]
  wire [1:0] _GEN_10 = io_s == 3'h0 ? state : prev_state; // @[dut.scala 71:37 72:20 21:27]
  wire [1:0] _GEN_11 = io_s == 3'h0 ? 2'h0 : state; // @[dut.scala 71:37 73:15 20:22]
  wire [1:0] _GEN_12 = _T_2 ? state : _GEN_10; // @[dut.scala 68:37 69:20]
  wire [1:0] _GEN_13 = _T_2 ? 2'h2 : _GEN_11; // @[dut.scala 68:37 70:15]
  wire [1:0] _GEN_14 = _T_5 ? 2'h1 : _GEN_13; // @[dut.scala 66:31 67:15]
  wire [1:0] _GEN_15 = _T_5 ? prev_state : _GEN_12; // @[dut.scala 21:27 66:31]
  wire [1:0] _GEN_16 = _T_5 ? state : prev_state; // @[dut.scala 84:37 85:20 21:27]
  wire [1:0] _GEN_17 = _T_5 ? 2'h1 : state; // @[dut.scala 84:37 86:15 20:22]
  wire [1:0] _GEN_18 = _T_10 ? 2'h0 : _GEN_17; // @[dut.scala 82:31 83:15]
  wire [1:0] _GEN_19 = _T_10 ? prev_state : _GEN_16; // @[dut.scala 21:27 82:31]
  wire [1:0] _GEN_21 = 2'h0 == state ? _GEN_18 : state; // @[dut.scala 30:17 20:22]
  wire [1:0] _GEN_22 = 2'h0 == state ? _GEN_19 : prev_state; // @[dut.scala 30:17 21:27]
  wire  _GEN_23 = 2'h1 == state ? 1'h0 : 2'h0 == state; // @[dut.scala 30:17 62:14]
  wire  _GEN_24 = 2'h1 == state | 2'h0 == state; // @[dut.scala 30:17 63:14]
  wire  _GEN_25 = 2'h1 == state ? prev_state == 2'h0 : 2'h0 == state; // @[dut.scala 30:17 65:14]
  wire [1:0] _GEN_26 = 2'h1 == state ? _GEN_14 : _GEN_21; // @[dut.scala 30:17]
  wire [1:0] _GEN_27 = 2'h1 == state ? _GEN_15 : _GEN_22; // @[dut.scala 30:17]
  wire  _GEN_28 = 2'h2 == state ? 1'h0 : _GEN_23; // @[dut.scala 30:17 46:14]
  wire  _GEN_29 = 2'h2 == state ? 1'h0 : _GEN_24; // @[dut.scala 30:17 47:14]
  wire  _GEN_30 = 2'h2 == state | _GEN_24; // @[dut.scala 30:17 48:14]
  wire  _GEN_31 = 2'h2 == state ? prev_state == 2'h1 : _GEN_25; // @[dut.scala 30:17 49:14]
  wire  _GEN_34 = 2'h3 == state ? 1'h0 : _GEN_28; // @[dut.scala 30:17 33:14]
  wire  _GEN_35 = 2'h3 == state ? 1'h0 : _GEN_29; // @[dut.scala 30:17 34:14]
  wire  _GEN_36 = 2'h3 == state ? 1'h0 : _GEN_30; // @[dut.scala 30:17 35:14]
  wire  _GEN_37 = 2'h3 == state ? 1'h0 : _GEN_31; // @[dut.scala 30:17 36:14]
  assign io_fr3 = reset | _GEN_34; // @[dut.scala 92:24 95:12]
  assign io_fr2 = reset | _GEN_35; // @[dut.scala 92:24 96:12]
  assign io_fr1 = reset | _GEN_36; // @[dut.scala 92:24 97:12]
  assign io_dfr = reset | _GEN_37; // @[dut.scala 92:24 98:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 20:22]
      state <= 2'h0; // @[dut.scala 20:22]
    end else if (reset) begin // @[dut.scala 92:24]
      state <= 2'h0; // @[dut.scala 93:11]
    end else if (2'h3 == state) begin // @[dut.scala 30:17]
      if (io_s == 3'h7) begin // @[dut.scala 37:31]
        state <= 2'h3; // @[dut.scala 38:15]
      end else begin
        state <= _GEN_1;
      end
    end else if (2'h2 == state) begin // @[dut.scala 30:17]
      state <= _GEN_8;
    end else begin
      state <= _GEN_26;
    end
    if (reset) begin // @[dut.scala 21:27]
      prev_state <= 2'h0; // @[dut.scala 21:27]
    end else if (reset) begin // @[dut.scala 92:24]
      prev_state <= 2'h0; // @[dut.scala 94:16]
    end else if (2'h3 == state) begin // @[dut.scala 30:17]
      if (!(io_s == 3'h7)) begin // @[dut.scala 37:31]
        prev_state <= _GEN_0;
      end
    end else if (2'h2 == state) begin // @[dut.scala 30:17]
      prev_state <= _GEN_9;
    end else begin
      prev_state <= _GEN_27;
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
  prev_state = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
