module dut(
  input         clock,
  input         reset,
  input  [31:0] io_a,
  input  [31:0] io_b,
  output [31:0] io_z
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  a_sign = io_a[31]; // @[dut.scala 13:20]
  wire  b_sign = io_b[31]; // @[dut.scala 14:20]
  reg  z_sign; // @[dut.scala 15:23]
  wire [7:0] a_exponent = io_a[30:23]; // @[dut.scala 17:24]
  wire [7:0] b_exponent = io_b[30:23]; // @[dut.scala 18:24]
  reg [7:0] z_exponent; // @[dut.scala 19:27]
  wire [23:0] _product_T = {1'h1,io_a[22:0]}; // @[dut.scala 23:29]
  wire [23:0] _product_T_1 = {1'h1,io_b[22:0]}; // @[dut.scala 23:49]
  wire [47:0] product = $signed(_product_T) * $signed(_product_T_1); // @[dut.scala 23:57]
  reg [2:0] counter; // @[dut.scala 26:24]
  reg  guard_bit; // @[dut.scala 29:26]
  reg  round_bit; // @[dut.scala 30:26]
  reg  sticky_bit; // @[dut.scala 31:27]
  wire  _a_is_zero_T_2 = io_a[22:0] == 23'h0; // @[dut.scala 34:53]
  wire  a_is_zero = a_exponent == 8'h0 & io_a[22:0] == 23'h0; // @[dut.scala 34:38]
  wire  _b_is_zero_T_2 = io_b[22:0] == 23'h0; // @[dut.scala 35:53]
  wire  b_is_zero = b_exponent == 8'h0 & io_b[22:0] == 23'h0; // @[dut.scala 35:38]
  wire  _a_is_inf_T = a_exponent == 8'hff; // @[dut.scala 36:30]
  wire  a_is_inf = a_exponent == 8'hff & _a_is_zero_T_2; // @[dut.scala 36:48]
  wire  _b_is_inf_T = b_exponent == 8'hff; // @[dut.scala 37:30]
  wire  b_is_inf = b_exponent == 8'hff & _b_is_zero_T_2; // @[dut.scala 37:48]
  wire  a_is_nan = _a_is_inf_T & io_a[22:0] != 23'h0; // @[dut.scala 38:48]
  wire  b_is_nan = _b_is_inf_T & io_b[22:0] != 23'h0; // @[dut.scala 39:48]
  reg [24:0] normalized_mantissa; // @[dut.scala 42:32]
  wire  _z_sign_T = a_sign ^ b_sign; // @[dut.scala 53:24]
  wire [7:0] _z_exponent_T_1 = a_exponent + b_exponent; // @[dut.scala 64:32]
  wire [7:0] _z_exponent_T_3 = _z_exponent_T_1 - 8'h7f; // @[dut.scala 64:45]
  wire [7:0] _z_exponent_T_5 = z_exponent - 8'h1; // @[dut.scala 75:34]
  wire [23:0] _GEN_0 = product[47] ? product[47:24] : product[46:23]; // @[dut.scala 68:29 69:29 74:29]
  wire  _GEN_1 = product[47] ? product[23] : product[22]; // @[dut.scala 68:29 70:19 76:19]
  wire  _GEN_2 = product[47] ? product[22] : product[21]; // @[dut.scala 68:29 71:19 77:19]
  wire  _GEN_3 = product[47] ? |product[21:0] : |product[20:0]; // @[dut.scala 68:29 72:20 78:20]
  wire [7:0] _GEN_4 = product[47] ? _z_exponent_T_3 : _z_exponent_T_5; // @[dut.scala 64:18 68:29 75:20]
  wire  _GEN_5 = a_is_zero | b_is_zero ? _z_sign_T : _z_sign_T; // @[dut.scala 56:40 57:14 61:14]
  wire [7:0] _GEN_6 = a_is_zero | b_is_zero ? 8'h0 : _GEN_4; // @[dut.scala 56:40 58:18]
  wire [23:0] _GEN_7 = a_is_zero | b_is_zero ? 24'h0 : _GEN_0; // @[dut.scala 56:40 59:27]
  wire  _GEN_8 = a_is_zero | b_is_zero ? guard_bit : _GEN_1; // @[dut.scala 29:26 56:40]
  wire  _GEN_9 = a_is_zero | b_is_zero ? round_bit : _GEN_2; // @[dut.scala 30:26 56:40]
  wire  _GEN_10 = a_is_zero | b_is_zero ? sticky_bit : _GEN_3; // @[dut.scala 31:27 56:40]
  wire [23:0] _GEN_13 = a_is_inf | b_is_inf ? 24'h0 : _GEN_7; // @[dut.scala 52:38 55:27]
  wire [23:0] _GEN_19 = a_is_nan | b_is_nan ? 24'h7fffff : _GEN_13; // @[dut.scala 48:32 51:27]
  wire [2:0] _counter_T_1 = counter + 3'h1; // @[dut.scala 82:24]
  wire [24:0] _normalized_mantissa_T_4 = normalized_mantissa + 25'h1; // @[dut.scala 86:50]
  wire [7:0] _z_exponent_T_7 = z_exponent + 8'h1; // @[dut.scala 89:34]
  wire [8:0] io_z_hi = {z_sign,z_exponent}; // @[Cat.scala 33:92]
  assign io_z = {io_z_hi,normalized_mantissa[22:0]}; // @[Cat.scala 33:92]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:23]
      z_sign <= 1'h0; // @[dut.scala 15:23]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      if (a_is_nan | b_is_nan) begin // @[dut.scala 48:32]
        z_sign <= 1'h0; // @[dut.scala 49:14]
      end else if (a_is_inf | b_is_inf) begin // @[dut.scala 52:38]
        z_sign <= a_sign ^ b_sign; // @[dut.scala 53:14]
      end else begin
        z_sign <= _GEN_5;
      end
    end
    if (reset) begin // @[dut.scala 19:27]
      z_exponent <= 8'h0; // @[dut.scala 19:27]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      if (a_is_nan | b_is_nan) begin // @[dut.scala 48:32]
        z_exponent <= 8'hff; // @[dut.scala 50:18]
      end else if (a_is_inf | b_is_inf) begin // @[dut.scala 52:38]
        z_exponent <= 8'hff; // @[dut.scala 54:18]
      end else begin
        z_exponent <= _GEN_6;
      end
    end else if (round_bit & (guard_bit | sticky_bit | normalized_mantissa[0])) begin // @[dut.scala 85:86]
      if (normalized_mantissa == 25'hffffff) begin // @[dut.scala 87:49]
        z_exponent <= _z_exponent_T_7; // @[dut.scala 89:20]
      end
    end
    if (reset) begin // @[dut.scala 26:24]
      counter <= 3'h0; // @[dut.scala 26:24]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      counter <= _counter_T_1; // @[dut.scala 82:13]
    end else begin
      counter <= 3'h0; // @[dut.scala 93:13]
    end
    if (reset) begin // @[dut.scala 29:26]
      guard_bit <= 1'h0; // @[dut.scala 29:26]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      if (!(a_is_nan | b_is_nan)) begin // @[dut.scala 48:32]
        if (!(a_is_inf | b_is_inf)) begin // @[dut.scala 52:38]
          guard_bit <= _GEN_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 30:26]
      round_bit <= 1'h0; // @[dut.scala 30:26]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      if (!(a_is_nan | b_is_nan)) begin // @[dut.scala 48:32]
        if (!(a_is_inf | b_is_inf)) begin // @[dut.scala 52:38]
          round_bit <= _GEN_9;
        end
      end
    end
    if (reset) begin // @[dut.scala 31:27]
      sticky_bit <= 1'h0; // @[dut.scala 31:27]
    end else if (counter == 3'h0) begin // @[dut.scala 46:25]
      if (!(a_is_nan | b_is_nan)) begin // @[dut.scala 48:32]
        if (!(a_is_inf | b_is_inf)) begin // @[dut.scala 52:38]
          sticky_bit <= _GEN_10;
        end
      end
    end
    if (counter == 3'h0) begin // @[dut.scala 46:25]
      normalized_mantissa <= {{1'd0}, _GEN_19};
    end else if (round_bit & (guard_bit | sticky_bit | normalized_mantissa[0])) begin // @[dut.scala 85:86]
      if (normalized_mantissa == 25'hffffff) begin // @[dut.scala 87:49]
        normalized_mantissa <= {{1'd0}, normalized_mantissa[24:1]}; // @[dut.scala 88:29]
      end else begin
        normalized_mantissa <= _normalized_mantissa_T_4; // @[dut.scala 86:27]
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
  z_sign = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  z_exponent = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  counter = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  guard_bit = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  round_bit = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  sticky_bit = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  normalized_mantissa = _RAND_6[24:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
