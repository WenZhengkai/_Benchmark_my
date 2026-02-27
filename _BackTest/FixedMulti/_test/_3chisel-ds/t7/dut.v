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
  reg [31:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_REG_INIT
  reg [23:0] a_mantissa; // @[dut.scala 13:27]
  reg [23:0] b_mantissa; // @[dut.scala 14:27]
  reg [23:0] z_mantissa; // @[dut.scala 15:27]
  reg [9:0] a_exponent; // @[dut.scala 16:27]
  reg [9:0] b_exponent; // @[dut.scala 17:27]
  reg [9:0] z_exponent; // @[dut.scala 18:27]
  reg  a_sign; // @[dut.scala 19:23]
  reg  b_sign; // @[dut.scala 20:23]
  reg  z_sign; // @[dut.scala 21:23]
  reg [49:0] product; // @[dut.scala 22:24]
  reg  guard_bit; // @[dut.scala 23:26]
  reg  round_bit; // @[dut.scala 24:26]
  reg  sticky; // @[dut.scala 25:23]
  reg [2:0] state; // @[dut.scala 39:22]
  wire [8:0] _a_exponent_T_2 = {1'b0,$signed(io_a[30:23])}; // @[dut.scala 50:39]
  wire [8:0] _b_exponent_T_2 = {1'b0,$signed(io_b[30:23])}; // @[dut.scala 51:39]
  wire  _a_mantissa_T = a_exponent == 10'h0; // @[dut.scala 52:36]
  wire  _a_mantissa_T_1 = a_exponent == 10'h0 ? 1'h0 : 1'h1; // @[dut.scala 52:24]
  wire [23:0] _a_mantissa_T_3 = {_a_mantissa_T_1,io_a[22:0]}; // @[dut.scala 52:65]
  wire  _b_mantissa_T = b_exponent == 10'h0; // @[dut.scala 53:36]
  wire  _b_mantissa_T_1 = b_exponent == 10'h0 ? 1'h0 : 1'h1; // @[dut.scala 53:24]
  wire [23:0] _b_mantissa_T_3 = {_b_mantissa_T_1,io_b[22:0]}; // @[dut.scala 53:65]
  wire  _a_is_zero_T_1 = a_mantissa == 24'h0; // @[dut.scala 59:59]
  wire  a_is_zero = _a_mantissa_T & a_mantissa == 24'h0; // @[dut.scala 59:44]
  wire  _b_is_zero_T_1 = b_mantissa == 24'h0; // @[dut.scala 60:59]
  wire  b_is_zero = _b_mantissa_T & b_mantissa == 24'h0; // @[dut.scala 60:44]
  wire  _a_is_inf_T = a_exponent == 10'hff; // @[dut.scala 61:34]
  wire  a_is_inf = a_exponent == 10'hff & _a_is_zero_T_1; // @[dut.scala 61:52]
  wire  _b_is_inf_T = b_exponent == 10'hff; // @[dut.scala 62:34]
  wire  b_is_inf = b_exponent == 10'hff & _b_is_zero_T_1; // @[dut.scala 62:52]
  wire  a_is_nan = _a_is_inf_T & a_mantissa != 24'h0; // @[dut.scala 63:52]
  wire  b_is_nan = _b_is_inf_T & b_mantissa != 24'h0; // @[dut.scala 64:52]
  wire  _z_sign_T = a_sign ^ b_sign; // @[dut.scala 80:26]
  wire  _GEN_0 = a_is_inf | b_is_inf ? _z_sign_T : z_sign; // @[dut.scala 84:40 86:16 21:23]
  wire [9:0] _GEN_1 = a_is_inf | b_is_inf ? 10'hff : z_exponent; // @[dut.scala 84:40 87:20 18:27]
  wire [23:0] _GEN_2 = a_is_inf | b_is_inf ? 24'h0 : z_mantissa; // @[dut.scala 84:40 88:20 15:27]
  wire [2:0] _GEN_3 = a_is_inf | b_is_inf ? 3'h7 : 3'h3; // @[dut.scala 84:40 89:15 91:15]
  wire  _GEN_4 = a_is_zero | b_is_zero ? a_sign ^ b_sign : _GEN_0; // @[dut.scala 78:42 80:16]
  wire [9:0] _GEN_5 = a_is_zero | b_is_zero ? 10'h0 : _GEN_1; // @[dut.scala 78:42 81:20]
  wire [23:0] _GEN_6 = a_is_zero | b_is_zero ? 24'h0 : _GEN_2; // @[dut.scala 78:42 82:20]
  wire [2:0] _GEN_7 = a_is_zero | b_is_zero ? 3'h7 : _GEN_3; // @[dut.scala 78:42 83:15]
  wire  _GEN_8 = a_is_zero & b_is_inf | a_is_inf & b_is_zero ? 1'h0 : _GEN_4; // @[dut.scala 72:70 74:16]
  wire [9:0] _GEN_9 = a_is_zero & b_is_inf | a_is_inf & b_is_zero ? 10'hff : _GEN_5; // @[dut.scala 72:70 75:20]
  wire [23:0] _GEN_10 = a_is_zero & b_is_inf | a_is_inf & b_is_zero ? 24'h1 : _GEN_6; // @[dut.scala 72:70 76:20]
  wire [2:0] _GEN_11 = a_is_zero & b_is_inf | a_is_inf & b_is_zero ? 3'h7 : _GEN_7; // @[dut.scala 72:70 77:15]
  wire  _GEN_12 = a_is_nan | b_is_nan ? 1'h0 : _GEN_8; // @[dut.scala 66:34 68:16]
  wire [9:0] _GEN_13 = a_is_nan | b_is_nan ? 10'hff : _GEN_9; // @[dut.scala 66:34 69:20]
  wire [23:0] _GEN_14 = a_is_nan | b_is_nan ? 24'h1 : _GEN_10; // @[dut.scala 66:34 70:20]
  wire [2:0] _GEN_15 = a_is_nan | b_is_nan ? 3'h7 : _GEN_11; // @[dut.scala 66:34 71:15]
  wire [47:0] _product_T = a_mantissa * b_mantissa; // @[dut.scala 96:29]
  wire [10:0] sum_exp = a_exponent + b_exponent; // @[dut.scala 99:32]
  wire [10:0] _z_exponent_T_1 = sum_exp - 11'h7f; // @[dut.scala 100:29]
  wire [9:0] _z_exponent_T_3 = z_exponent + 10'h1; // @[dut.scala 112:34]
  wire [49:0] _GEN_16 = product[47] ? {{1'd0}, product[49:1]} : product; // @[dut.scala 109:33 111:17 22:24]
  wire [9:0] _GEN_17 = product[47] ? _z_exponent_T_3 : z_exponent; // @[dut.scala 109:33 112:20 18:27]
  wire  lsb = z_mantissa[0]; // @[dut.scala 127:27]
  wire  round_up = guard_bit & (round_bit | sticky | lsb); // @[dut.scala 128:32]
  wire [23:0] _z_mantissa_T_2 = z_mantissa + 24'h1; // @[dut.scala 131:34]
  wire [23:0] _GEN_18 = &z_mantissa ? 24'h800000 : _z_mantissa_T_2; // @[dut.scala 131:20 133:31 134:22]
  wire [9:0] _GEN_19 = &z_mantissa ? _z_exponent_T_3 : z_exponent; // @[dut.scala 133:31 135:22 18:27]
  wire [23:0] _GEN_20 = round_up ? _GEN_18 : z_mantissa; // @[dut.scala 130:22 15:27]
  wire [9:0] _GEN_21 = round_up ? _GEN_19 : z_exponent; // @[dut.scala 130:22 18:27]
  wire [9:0] _GEN_22 = z_exponent == 10'h0 ? 10'h0 : z_exponent; // @[dut.scala 147:38 149:20 18:27]
  wire [23:0] _GEN_23 = z_exponent == 10'h0 ? 24'h0 : z_mantissa; // @[dut.scala 147:38 150:20 15:27]
  wire [9:0] _GEN_24 = z_exponent >= 10'hff ? 10'hff : _GEN_22; // @[dut.scala 143:40 145:20]
  wire [23:0] _GEN_25 = z_exponent >= 10'hff ? 24'h0 : _GEN_23; // @[dut.scala 143:40 146:20]
  wire [31:0] _io_z_T_3 = {z_sign,z_exponent[7:0],z_mantissa[22:0]}; // @[dut.scala 157:42]
  wire [31:0] _GEN_26 = 3'h7 == state ? _io_z_T_3 : 32'h0; // @[dut.scala 157:12 41:17 35:8]
  wire [2:0] _GEN_27 = 3'h7 == state ? 3'h0 : state; // @[dut.scala 160:13 41:17 39:22]
  wire [9:0] _GEN_28 = 3'h6 == state ? _GEN_24 : z_exponent; // @[dut.scala 41:17 18:27]
  wire [23:0] _GEN_29 = 3'h6 == state ? _GEN_25 : z_mantissa; // @[dut.scala 41:17 15:27]
  wire [2:0] _GEN_30 = 3'h6 == state ? 3'h7 : _GEN_27; // @[dut.scala 153:13 41:17]
  wire [31:0] _GEN_31 = 3'h6 == state ? 32'h0 : _GEN_26; // @[dut.scala 41:17 35:8]
  wire [23:0] _GEN_32 = 3'h5 == state ? _GEN_20 : _GEN_29; // @[dut.scala 41:17]
  wire [9:0] _GEN_33 = 3'h5 == state ? _GEN_21 : _GEN_28; // @[dut.scala 41:17]
  wire [2:0] _GEN_34 = 3'h5 == state ? 3'h6 : _GEN_30; // @[dut.scala 139:13 41:17]
  wire [31:0] _GEN_35 = 3'h5 == state ? 32'h0 : _GEN_31; // @[dut.scala 41:17 35:8]
  wire [49:0] _GEN_36 = 3'h4 == state ? _GEN_16 : product; // @[dut.scala 41:17 22:24]
  wire [9:0] _GEN_37 = 3'h4 == state ? _GEN_17 : _GEN_33; // @[dut.scala 41:17]
  wire  _GEN_38 = 3'h4 == state ? product[22] : guard_bit; // @[dut.scala 116:17 41:17 23:26]
  wire  _GEN_39 = 3'h4 == state ? product[21] : round_bit; // @[dut.scala 117:17 41:17 24:26]
  wire  _GEN_40 = 3'h4 == state ? |product[20:0] : sticky; // @[dut.scala 118:14 41:17 25:23]
  wire [23:0] _GEN_41 = 3'h4 == state ? product[46:23] : _GEN_32; // @[dut.scala 41:17 121:18]
  wire [2:0] _GEN_42 = 3'h4 == state ? 3'h5 : _GEN_34; // @[dut.scala 123:13 41:17]
  wire [31:0] _GEN_43 = 3'h4 == state ? 32'h0 : _GEN_35; // @[dut.scala 41:17 35:8]
  wire [49:0] _GEN_44 = 3'h3 == state ? {{2'd0}, _product_T} : _GEN_36; // @[dut.scala 41:17 96:15]
  wire [10:0] _GEN_45 = 3'h3 == state ? _z_exponent_T_1 : {{1'd0}, _GEN_37}; // @[dut.scala 41:17 100:18]
  wire  _GEN_46 = 3'h3 == state ? _z_sign_T : z_sign; // @[dut.scala 103:14 41:17 21:23]
  wire [2:0] _GEN_47 = 3'h3 == state ? 3'h4 : _GEN_42; // @[dut.scala 105:13 41:17]
  wire  _GEN_48 = 3'h3 == state ? guard_bit : _GEN_38; // @[dut.scala 41:17 23:26]
  wire  _GEN_49 = 3'h3 == state ? round_bit : _GEN_39; // @[dut.scala 41:17 24:26]
  wire  _GEN_50 = 3'h3 == state ? sticky : _GEN_40; // @[dut.scala 41:17 25:23]
  wire [23:0] _GEN_51 = 3'h3 == state ? z_mantissa : _GEN_41; // @[dut.scala 41:17 15:27]
  wire [31:0] _GEN_52 = 3'h3 == state ? 32'h0 : _GEN_43; // @[dut.scala 41:17 35:8]
  wire [10:0] _GEN_54 = 3'h2 == state ? {{1'd0}, _GEN_13} : _GEN_45; // @[dut.scala 41:17]
  wire [31:0] _GEN_61 = 3'h2 == state ? 32'h0 : _GEN_52; // @[dut.scala 41:17 35:8]
  wire [10:0] _GEN_70 = 3'h1 == state ? {{1'd0}, z_exponent} : _GEN_54; // @[dut.scala 41:17 18:27]
  wire [31:0] _GEN_76 = 3'h1 == state ? 32'h0 : _GEN_61; // @[dut.scala 41:17 35:8]
  wire [10:0] _GEN_86 = 3'h0 == state ? {{1'd0}, z_exponent} : _GEN_70; // @[dut.scala 41:17 18:27]
  wire [10:0] _GEN_93 = reset ? 11'h0 : _GEN_86; // @[dut.scala 18:{27,27}]
  assign io_z = 3'h0 == state ? 32'h0 : _GEN_76; // @[dut.scala 41:17 35:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:27]
      a_mantissa <= 24'h0; // @[dut.scala 13:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        a_mantissa <= _a_mantissa_T_3; // @[dut.scala 52:18]
      end
    end
    if (reset) begin // @[dut.scala 14:27]
      b_mantissa <= 24'h0; // @[dut.scala 14:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        b_mantissa <= _b_mantissa_T_3; // @[dut.scala 53:18]
      end
    end
    if (reset) begin // @[dut.scala 15:27]
      z_mantissa <= 24'h0; // @[dut.scala 15:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (3'h2 == state) begin // @[dut.scala 41:17]
          z_mantissa <= _GEN_14;
        end else begin
          z_mantissa <= _GEN_51;
        end
      end
    end
    if (reset) begin // @[dut.scala 16:27]
      a_exponent <= 10'h0; // @[dut.scala 16:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        a_exponent <= {{1'd0}, _a_exponent_T_2}; // @[dut.scala 50:18]
      end
    end
    if (reset) begin // @[dut.scala 17:27]
      b_exponent <= 10'h0; // @[dut.scala 17:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        b_exponent <= {{1'd0}, _b_exponent_T_2}; // @[dut.scala 51:18]
      end
    end
    z_exponent <= _GEN_93[9:0]; // @[dut.scala 18:{27,27}]
    if (reset) begin // @[dut.scala 19:23]
      a_sign <= 1'h0; // @[dut.scala 19:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        a_sign <= io_a[31]; // @[dut.scala 48:14]
      end
    end
    if (reset) begin // @[dut.scala 20:23]
      b_sign <= 1'h0; // @[dut.scala 20:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (3'h1 == state) begin // @[dut.scala 41:17]
        b_sign <= io_b[31]; // @[dut.scala 49:14]
      end
    end
    if (reset) begin // @[dut.scala 21:23]
      z_sign <= 1'h0; // @[dut.scala 21:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (3'h2 == state) begin // @[dut.scala 41:17]
          z_sign <= _GEN_12;
        end else begin
          z_sign <= _GEN_46;
        end
      end
    end
    if (reset) begin // @[dut.scala 22:24]
      product <= 50'h0; // @[dut.scala 22:24]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (!(3'h2 == state)) begin // @[dut.scala 41:17]
          product <= _GEN_44;
        end
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      guard_bit <= 1'h0; // @[dut.scala 23:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (!(3'h2 == state)) begin // @[dut.scala 41:17]
          guard_bit <= _GEN_48;
        end
      end
    end
    if (reset) begin // @[dut.scala 24:26]
      round_bit <= 1'h0; // @[dut.scala 24:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (!(3'h2 == state)) begin // @[dut.scala 41:17]
          round_bit <= _GEN_49;
        end
      end
    end
    if (reset) begin // @[dut.scala 25:23]
      sticky <= 1'h0; // @[dut.scala 25:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 41:17]
      if (!(3'h1 == state)) begin // @[dut.scala 41:17]
        if (!(3'h2 == state)) begin // @[dut.scala 41:17]
          sticky <= _GEN_50;
        end
      end
    end
    if (reset) begin // @[dut.scala 39:22]
      state <= 3'h0; // @[dut.scala 39:22]
    end else if (3'h0 == state) begin // @[dut.scala 41:17]
      state <= 3'h1; // @[dut.scala 44:13]
    end else if (3'h1 == state) begin // @[dut.scala 41:17]
      state <= 3'h2; // @[dut.scala 55:13]
    end else if (3'h2 == state) begin // @[dut.scala 41:17]
      state <= _GEN_15;
    end else begin
      state <= _GEN_47;
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
  a_mantissa = _RAND_0[23:0];
  _RAND_1 = {1{`RANDOM}};
  b_mantissa = _RAND_1[23:0];
  _RAND_2 = {1{`RANDOM}};
  z_mantissa = _RAND_2[23:0];
  _RAND_3 = {1{`RANDOM}};
  a_exponent = _RAND_3[9:0];
  _RAND_4 = {1{`RANDOM}};
  b_exponent = _RAND_4[9:0];
  _RAND_5 = {1{`RANDOM}};
  z_exponent = _RAND_5[9:0];
  _RAND_6 = {1{`RANDOM}};
  a_sign = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  b_sign = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  z_sign = _RAND_8[0:0];
  _RAND_9 = {2{`RANDOM}};
  product = _RAND_9[49:0];
  _RAND_10 = {1{`RANDOM}};
  guard_bit = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  round_bit = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sticky = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  state = _RAND_13[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
