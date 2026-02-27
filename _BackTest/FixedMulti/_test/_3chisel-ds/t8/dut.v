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
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] counter; // @[dut.scala 12:24]
  reg [23:0] a_mantissa; // @[dut.scala 13:27]
  reg [23:0] b_mantissa; // @[dut.scala 14:27]
  reg [23:0] z_mantissa; // @[dut.scala 15:27]
  reg [9:0] a_exponent; // @[dut.scala 16:27]
  reg [9:0] b_exponent; // @[dut.scala 17:27]
  reg [9:0] z_exponent; // @[dut.scala 18:27]
  reg  z_sign; // @[dut.scala 21:23]
  reg [49:0] product; // @[dut.scala 22:24]
  reg  guard_bit; // @[dut.scala 23:26]
  reg  round_bit; // @[dut.scala 24:26]
  reg  sticky; // @[dut.scala 25:23]
  wire  a_s = io_a[31]; // @[dut.scala 34:17]
  wire [7:0] a_exp = io_a[30:23]; // @[dut.scala 35:19]
  wire [22:0] a_man = io_a[22:0]; // @[dut.scala 36:19]
  wire  b_s = io_b[31]; // @[dut.scala 38:17]
  wire [7:0] b_exp = io_b[30:23]; // @[dut.scala 39:19]
  wire [22:0] b_man = io_b[22:0]; // @[dut.scala 40:19]
  wire  _a_is_zero_T = a_exp == 8'h0; // @[dut.scala 43:25]
  wire  _a_is_zero_T_1 = a_man == 23'h0; // @[dut.scala 43:42]
  wire  a_is_zero = a_exp == 8'h0 & a_man == 23'h0; // @[dut.scala 43:33]
  wire  _b_is_zero_T = b_exp == 8'h0; // @[dut.scala 44:25]
  wire  _b_is_zero_T_1 = b_man == 23'h0; // @[dut.scala 44:42]
  wire  b_is_zero = b_exp == 8'h0 & b_man == 23'h0; // @[dut.scala 44:33]
  wire  _a_is_inf_T = a_exp == 8'hff; // @[dut.scala 45:24]
  wire  a_is_inf = a_exp == 8'hff & _a_is_zero_T_1; // @[dut.scala 45:41]
  wire  _b_is_inf_T = b_exp == 8'hff; // @[dut.scala 46:24]
  wire  b_is_inf = b_exp == 8'hff & _b_is_zero_T_1; // @[dut.scala 46:41]
  wire  a_is_nan = _a_is_inf_T & a_man != 23'h0; // @[dut.scala 47:41]
  wire  b_is_nan = _b_is_inf_T & b_man != 23'h0; // @[dut.scala 48:41]
  wire [23:0] _a_mantissa_T_1 = {1'h0,a_man}; // @[Cat.scala 33:92]
  wire [23:0] _a_mantissa_T_2 = {1'h1,a_man}; // @[Cat.scala 33:92]
  wire [23:0] _b_mantissa_T_1 = {1'h0,b_man}; // @[Cat.scala 33:92]
  wire [23:0] _b_mantissa_T_2 = {1'h1,b_man}; // @[Cat.scala 33:92]
  wire [7:0] _a_exponent_T_1 = _a_is_zero_T ? 8'h1 : a_exp; // @[dut.scala 64:22]
  wire [7:0] _b_exponent_T_1 = _b_is_zero_T ? 8'h1 : b_exp; // @[dut.scala 65:22]
  wire  _io_z_T = a_s | b_s; // @[dut.scala 70:23]
  wire [31:0] _io_z_T_1 = {_io_z_T,8'hff,23'h2}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_2 = {z_sign,8'hff,23'h2}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_3 = {z_sign,8'hff,23'h0}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_4 = {z_sign,31'h0}; // @[Cat.scala 33:92]
  wire [2:0] _counter_T_1 = counter + 3'h1; // @[dut.scala 85:26]
  wire [31:0] _GEN_0 = a_is_zero | b_is_zero ? _io_z_T_4 : 32'h0; // @[dut.scala 80:40 82:12 51:8]
  wire [2:0] _GEN_1 = a_is_zero | b_is_zero ? 3'h0 : _counter_T_1; // @[dut.scala 80:40 83:15 85:15]
  wire [31:0] _GEN_2 = a_is_inf | b_is_inf ? _io_z_T_3 : _GEN_0; // @[dut.scala 76:38 78:12]
  wire [2:0] _GEN_3 = a_is_inf | b_is_inf ? 3'h0 : _GEN_1; // @[dut.scala 76:38 79:15]
  wire [31:0] _GEN_4 = a_is_zero & b_is_inf | a_is_inf & b_is_zero ? _io_z_T_2 : _GEN_2; // @[dut.scala 72:68 74:12]
  wire [31:0] _GEN_6 = a_is_nan | b_is_nan ? _io_z_T_1 : _GEN_4; // @[dut.scala 68:32 70:12]
  wire [47:0] _product_T = a_mantissa * b_mantissa; // @[dut.scala 89:27]
  wire [9:0] _raw_exponent_T_1 = a_exponent + b_exponent; // @[dut.scala 93:35]
  wire [9:0] raw_exponent = _raw_exponent_T_1 - 10'h7f; // @[dut.scala 93:48]
  wire  norm_shift = ~product[47]; // @[dut.scala 96:22]
  wire [50:0] _normalized_product_T = {product, 1'h0}; // @[dut.scala 97:54]
  wire [50:0] normalized_product = norm_shift ? _normalized_product_T : {{1'd0}, product}; // @[dut.scala 97:33]
  wire [9:0] _z_exponent_T_1 = raw_exponent - 10'h1; // @[dut.scala 100:48]
  wire [9:0] _z_exponent_T_2 = norm_shift ? _z_exponent_T_1 : raw_exponent; // @[dut.scala 100:22]
  wire  round_up = guard_bit & (round_bit | sticky | z_mantissa[0]); // @[dut.scala 111:30]
  wire [23:0] _GEN_42 = {{23'd0}, round_up}; // @[dut.scala 113:39]
  wire [23:0] rounded_mantissa = z_mantissa + _GEN_42; // @[dut.scala 113:39]
  wire [9:0] _GEN_43 = {{9'd0}, rounded_mantissa[23]}; // @[dut.scala 114:39]
  wire [9:0] rounded_exponent = z_exponent + _GEN_43; // @[dut.scala 114:39]
  wire [31:0] _io_z_T_9 = {z_sign,rounded_exponent[7:0],rounded_mantissa[22:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_8 = rounded_exponent == 10'h0 ? _io_z_T_4 : _io_z_T_9; // @[dut.scala 120:42 122:12 125:12]
  wire [31:0] _GEN_9 = rounded_exponent >= 10'h1fe ? _io_z_T_3 : _GEN_8; // @[dut.scala 117:60 119:12]
  wire [31:0] _GEN_10 = counter == 3'h3 ? _GEN_9 : 32'h0; // @[dut.scala 109:31 51:8]
  wire [2:0] _GEN_11 = counter == 3'h3 ? 3'h0 : counter; // @[dut.scala 109:31 128:13 12:24]
  wire [31:0] _GEN_18 = counter == 3'h2 ? 32'h0 : _GEN_10; // @[dut.scala 91:31 51:8]
  wire [31:0] _GEN_26 = counter == 3'h1 ? 32'h0 : _GEN_18; // @[dut.scala 87:31 51:8]
  assign io_z = counter == 3'h0 ? _GEN_6 : _GEN_26; // @[dut.scala 54:25]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:24]
      counter <= 3'h0; // @[dut.scala 12:24]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      if (a_is_nan | b_is_nan) begin // @[dut.scala 68:32]
        counter <= 3'h0; // @[dut.scala 71:15]
      end else if (a_is_zero & b_is_inf | a_is_inf & b_is_zero) begin // @[dut.scala 72:68]
        counter <= 3'h0; // @[dut.scala 75:15]
      end else begin
        counter <= _GEN_3;
      end
    end else if (counter == 3'h1) begin // @[dut.scala 87:31]
      counter <= _counter_T_1; // @[dut.scala 90:13]
    end else if (counter == 3'h2) begin // @[dut.scala 91:31]
      counter <= _counter_T_1; // @[dut.scala 108:13]
    end else begin
      counter <= _GEN_11;
    end
    if (reset) begin // @[dut.scala 13:27]
      a_mantissa <= 24'h0; // @[dut.scala 13:27]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      if (_a_is_zero_T) begin // @[dut.scala 61:22]
        a_mantissa <= _a_mantissa_T_1;
      end else begin
        a_mantissa <= _a_mantissa_T_2;
      end
    end
    if (reset) begin // @[dut.scala 14:27]
      b_mantissa <= 24'h0; // @[dut.scala 14:27]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      if (_b_is_zero_T) begin // @[dut.scala 62:22]
        b_mantissa <= _b_mantissa_T_1;
      end else begin
        b_mantissa <= _b_mantissa_T_2;
      end
    end
    if (reset) begin // @[dut.scala 15:27]
      z_mantissa <= 24'h0; // @[dut.scala 15:27]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (!(counter == 3'h1)) begin // @[dut.scala 87:31]
        if (counter == 3'h2) begin // @[dut.scala 91:31]
          z_mantissa <= {{1'd0}, normalized_product[47:25]}; // @[dut.scala 103:16]
        end
      end
    end
    if (reset) begin // @[dut.scala 16:27]
      a_exponent <= 10'h0; // @[dut.scala 16:27]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      a_exponent <= {{2'd0}, _a_exponent_T_1}; // @[dut.scala 64:16]
    end
    if (reset) begin // @[dut.scala 17:27]
      b_exponent <= 10'h0; // @[dut.scala 17:27]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      b_exponent <= {{2'd0}, _b_exponent_T_1}; // @[dut.scala 65:16]
    end
    if (reset) begin // @[dut.scala 18:27]
      z_exponent <= 10'h0; // @[dut.scala 18:27]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (!(counter == 3'h1)) begin // @[dut.scala 87:31]
        if (counter == 3'h2) begin // @[dut.scala 91:31]
          z_exponent <= _z_exponent_T_2; // @[dut.scala 100:16]
        end
      end
    end
    if (reset) begin // @[dut.scala 21:23]
      z_sign <= 1'h0; // @[dut.scala 21:23]
    end else if (counter == 3'h0) begin // @[dut.scala 54:25]
      z_sign <= a_s ^ b_s; // @[dut.scala 58:12]
    end
    if (reset) begin // @[dut.scala 22:24]
      product <= 50'h0; // @[dut.scala 22:24]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (counter == 3'h1) begin // @[dut.scala 87:31]
        product <= {{2'd0}, _product_T}; // @[dut.scala 89:13]
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      guard_bit <= 1'h0; // @[dut.scala 23:26]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (!(counter == 3'h1)) begin // @[dut.scala 87:31]
        if (counter == 3'h2) begin // @[dut.scala 91:31]
          guard_bit <= normalized_product[24]; // @[dut.scala 104:15]
        end
      end
    end
    if (reset) begin // @[dut.scala 24:26]
      round_bit <= 1'h0; // @[dut.scala 24:26]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (!(counter == 3'h1)) begin // @[dut.scala 87:31]
        if (counter == 3'h2) begin // @[dut.scala 91:31]
          round_bit <= normalized_product[23]; // @[dut.scala 105:15]
        end
      end
    end
    if (reset) begin // @[dut.scala 25:23]
      sticky <= 1'h0; // @[dut.scala 25:23]
    end else if (!(counter == 3'h0)) begin // @[dut.scala 54:25]
      if (!(counter == 3'h1)) begin // @[dut.scala 87:31]
        if (counter == 3'h2) begin // @[dut.scala 91:31]
          sticky <= |normalized_product[22:0]; // @[dut.scala 106:12]
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
  z_sign = _RAND_7[0:0];
  _RAND_8 = {2{`RANDOM}};
  product = _RAND_8[49:0];
  _RAND_9 = {1{`RANDOM}};
  guard_bit = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  round_bit = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  sticky = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
