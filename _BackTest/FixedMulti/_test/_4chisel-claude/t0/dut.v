module FloatMultiplier(
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
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] counter; // @[dut.scala 11:24]
  reg [23:0] a_mantissa; // @[dut.scala 12:23]
  reg [23:0] b_mantissa; // @[dut.scala 13:23]
  reg [23:0] z_mantissa; // @[dut.scala 14:23]
  reg [9:0] a_exponent; // @[dut.scala 15:23]
  reg [9:0] b_exponent; // @[dut.scala 16:23]
  reg [9:0] z_exponent; // @[dut.scala 17:23]
  reg  a_sign; // @[dut.scala 18:19]
  reg  b_sign; // @[dut.scala 19:19]
  reg  z_sign; // @[dut.scala 20:19]
  reg [49:0] product; // @[dut.scala 21:20]
  reg  guard_bit; // @[dut.scala 22:22]
  reg  round_bit; // @[dut.scala 23:22]
  reg  sticky; // @[dut.scala 24:19]
  wire [23:0] _a_mantissa_T_1 = {1'h1,io_a[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] _b_mantissa_T_1 = {1'h1,io_b[22:0]}; // @[Cat.scala 33:92]
  wire [2:0] _counter_T_1 = counter + 3'h1; // @[dut.scala 38:26]
  wire  _T_2 = a_exponent == 10'hff; // @[dut.scala 43:23]
  wire  _T_3 = b_exponent == 10'hff; // @[dut.scala 43:47]
  wire  _z_sign_T = a_sign ^ b_sign; // @[dut.scala 58:28]
  wire [23:0] _GEN_0 = _T_3 & b_mantissa != 24'h0 ? b_mantissa : 24'h0; // @[dut.scala 49:64 51:22 56:22]
  wire  _GEN_2 = _T_3 & b_mantissa != 24'h0 ? b_sign : a_sign ^ b_sign; // @[dut.scala 49:64 53:18 58:18]
  wire [47:0] _product_T = a_mantissa * b_mantissa; // @[dut.scala 62:31]
  wire [10:0] _z_exponent_T = a_exponent + b_exponent; // @[dut.scala 63:34]
  wire [11:0] _z_exponent_T_1 = _z_exponent_T - 11'h7f; // @[dut.scala 63:48]
  wire [11:0] _GEN_7 = a_exponent == 10'hff | b_exponent == 10'hff ? 12'hff : _z_exponent_T_1; // @[dut.scala 43:58 63:20]
  wire [9:0] _z_exponent_T_4 = z_exponent + 10'h1; // @[dut.scala 76:34]
  wire [9:0] _GEN_14 = product[49] ? _z_exponent_T_4 : z_exponent; // @[dut.scala 71:25 76:20 17:23]
  wire [23:0] _z_mantissa_T_3 = z_mantissa + 24'h1; // @[dut.scala 89:34]
  wire [9:0] _GEN_15 = z_mantissa == 24'hffffff ? _z_exponent_T_4 : z_exponent; // @[dut.scala 90:42 91:22 17:23]
  wire [23:0] _GEN_16 = guard_bit & (round_bit | sticky | z_mantissa[0]) ? _z_mantissa_T_3 : z_mantissa; // @[dut.scala 88:65 89:20 14:23]
  wire [9:0] _GEN_17 = guard_bit & (round_bit | sticky | z_mantissa[0]) ? _GEN_15 : z_exponent; // @[dut.scala 17:23 88:65]
  wire [31:0] _io_z_T = {z_sign,8'hff,23'h0}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_1 = {z_sign,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_4 = {z_sign,z_exponent[7:0],z_mantissa[22:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_18 = z_exponent <= 10'h0 ? _io_z_T_1 : _io_z_T_4; // @[dut.scala 102:37 104:14 106:14]
  wire [31:0] _GEN_19 = z_exponent >= 10'hff ? _io_z_T : _GEN_18; // @[dut.scala 101:14 99:33]
  wire [31:0] _GEN_20 = 3'h4 == counter ? _GEN_19 : 32'h0; // @[dut.scala 29:19 27:8]
  wire [2:0] _GEN_21 = 3'h4 == counter ? 3'h0 : counter; // @[dut.scala 108:15 29:19 11:24]
  wire [9:0] _GEN_23 = 3'h3 == counter ? _GEN_17 : z_exponent; // @[dut.scala 29:19 17:23]
  wire [2:0] _GEN_24 = 3'h3 == counter ? _counter_T_1 : _GEN_21; // @[dut.scala 29:19 94:15]
  wire [31:0] _GEN_25 = 3'h3 == counter ? 32'h0 : _GEN_20; // @[dut.scala 29:19 27:8]
  wire [9:0] _GEN_30 = 3'h2 == counter ? _GEN_14 : _GEN_23; // @[dut.scala 29:19]
  wire [31:0] _GEN_32 = 3'h2 == counter ? 32'h0 : _GEN_25; // @[dut.scala 29:19 27:8]
  wire [11:0] _GEN_34 = 3'h1 == counter ? _GEN_7 : {{2'd0}, _GEN_30}; // @[dut.scala 29:19]
  wire [31:0] _GEN_41 = 3'h1 == counter ? 32'h0 : _GEN_32; // @[dut.scala 29:19 27:8]
  wire [11:0] _GEN_50 = 3'h0 == counter ? {{2'd0}, z_exponent} : _GEN_34; // @[dut.scala 29:19 17:23]
  assign io_z = 3'h0 == counter ? 32'h0 : _GEN_41; // @[dut.scala 29:19 27:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 11:24]
      counter <= 3'h0; // @[dut.scala 11:24]
    end else if (3'h0 == counter) begin // @[dut.scala 29:19]
      counter <= _counter_T_1; // @[dut.scala 38:15]
    end else if (3'h1 == counter) begin // @[dut.scala 29:19]
      counter <= _counter_T_1; // @[dut.scala 66:15]
    end else if (3'h2 == counter) begin // @[dut.scala 29:19]
      counter <= _counter_T_1; // @[dut.scala 83:15]
    end else begin
      counter <= _GEN_24;
    end
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      a_mantissa <= _a_mantissa_T_1; // @[dut.scala 32:18]
    end
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      b_mantissa <= _b_mantissa_T_1; // @[dut.scala 33:18]
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (3'h1 == counter) begin // @[dut.scala 29:19]
        if (a_exponent == 10'hff | b_exponent == 10'hff) begin // @[dut.scala 43:58]
          if (_T_2 & a_mantissa != 24'h0) begin // @[dut.scala 44:58]
            z_mantissa <= a_mantissa; // @[dut.scala 46:22]
          end else begin
            z_mantissa <= _GEN_0;
          end
        end
      end else if (3'h2 == counter) begin // @[dut.scala 29:19]
        if (product[49]) begin // @[dut.scala 71:25]
          z_mantissa <= product[49:26]; // @[dut.scala 72:20]
        end else begin
          z_mantissa <= product[48:25]; // @[dut.scala 78:20]
        end
      end else if (3'h3 == counter) begin // @[dut.scala 29:19]
        z_mantissa <= _GEN_16;
      end
    end
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      a_exponent <= {{2'd0}, io_a[30:23]}; // @[dut.scala 34:18]
    end
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      b_exponent <= {{2'd0}, io_b[30:23]}; // @[dut.scala 35:18]
    end
    z_exponent <= _GEN_50[9:0];
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      a_sign <= io_a[31]; // @[dut.scala 36:14]
    end
    if (3'h0 == counter) begin // @[dut.scala 29:19]
      b_sign <= io_b[31]; // @[dut.scala 37:14]
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (3'h1 == counter) begin // @[dut.scala 29:19]
        if (a_exponent == 10'hff | b_exponent == 10'hff) begin // @[dut.scala 43:58]
          if (_T_2 & a_mantissa != 24'h0) begin // @[dut.scala 44:58]
            z_sign <= a_sign; // @[dut.scala 48:18]
          end else begin
            z_sign <= _GEN_2;
          end
        end else begin
          z_sign <= _z_sign_T; // @[dut.scala 64:16]
        end
      end
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (3'h1 == counter) begin // @[dut.scala 29:19]
        if (!(a_exponent == 10'hff | b_exponent == 10'hff)) begin // @[dut.scala 43:58]
          product <= {{2'd0}, _product_T}; // @[dut.scala 62:17]
        end
      end
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (!(3'h1 == counter)) begin // @[dut.scala 29:19]
        if (3'h2 == counter) begin // @[dut.scala 29:19]
          if (product[49]) begin // @[dut.scala 71:25]
            guard_bit <= product[25]; // @[dut.scala 73:19]
          end else begin
            guard_bit <= product[24]; // @[dut.scala 79:19]
          end
        end
      end
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (!(3'h1 == counter)) begin // @[dut.scala 29:19]
        if (3'h2 == counter) begin // @[dut.scala 29:19]
          if (product[49]) begin // @[dut.scala 71:25]
            round_bit <= product[24]; // @[dut.scala 74:19]
          end else begin
            round_bit <= product[23]; // @[dut.scala 80:19]
          end
        end
      end
    end
    if (!(3'h0 == counter)) begin // @[dut.scala 29:19]
      if (!(3'h1 == counter)) begin // @[dut.scala 29:19]
        if (3'h2 == counter) begin // @[dut.scala 29:19]
          if (product[49]) begin // @[dut.scala 71:25]
            sticky <= |product[23:0]; // @[dut.scala 75:16]
          end else begin
            sticky <= |product[22:0]; // @[dut.scala 81:16]
          end
        end
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
  counter = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  a_mantissa = _RAND_1[23:0];
  _RAND_2 = {1{`RANDOM}};
  b_mantissa = _RAND_2[23:0];
  _RAND_3 = {1{`RANDOM}};
  z_mantissa = _RAND_3[23:0];
  _RAND_4 = {1{`RANDOM}};
  a_exponent = _RAND_4[9:0];
  _RAND_5 = {1{`RANDOM}};
  b_exponent = _RAND_5[9:0];
  _RAND_6 = {1{`RANDOM}};
  z_exponent = _RAND_6[9:0];
  _RAND_7 = {1{`RANDOM}};
  a_sign = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  b_sign = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  z_sign = _RAND_9[0:0];
  _RAND_10 = {2{`RANDOM}};
  product = _RAND_10[49:0];
  _RAND_11 = {1{`RANDOM}};
  guard_bit = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  round_bit = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  sticky = _RAND_13[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dut(
  input         clock,
  input         reset,
  input  [31:0] io_a,
  input  [31:0] io_b,
  output [31:0] io_z
);
  wire  multiplier_clock; // @[dut.scala 121:26]
  wire  multiplier_reset; // @[dut.scala 121:26]
  wire [31:0] multiplier_io_a; // @[dut.scala 121:26]
  wire [31:0] multiplier_io_b; // @[dut.scala 121:26]
  wire [31:0] multiplier_io_z; // @[dut.scala 121:26]
  FloatMultiplier multiplier ( // @[dut.scala 121:26]
    .clock(multiplier_clock),
    .reset(multiplier_reset),
    .io_a(multiplier_io_a),
    .io_b(multiplier_io_b),
    .io_z(multiplier_io_z)
  );
  assign io_z = multiplier_io_z; // @[dut.scala 124:8]
  assign multiplier_clock = clock;
  assign multiplier_reset = reset;
  assign multiplier_io_a = io_a; // @[dut.scala 122:19]
  assign multiplier_io_b = io_b; // @[dut.scala 123:19]
endmodule
