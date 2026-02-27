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
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
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
  reg  a_is_nan; // @[dut.scala 28:25]
  reg  b_is_nan; // @[dut.scala 29:25]
  reg  a_is_inf; // @[dut.scala 30:25]
  reg  b_is_inf; // @[dut.scala 31:25]
  reg  a_is_zero; // @[dut.scala 32:26]
  reg  b_is_zero; // @[dut.scala 33:26]
  reg [2:0] state; // @[dut.scala 40:22]
  wire [8:0] _a_exponent_T_2 = {1'b0,$signed(io_a[30:23])}; // @[dut.scala 52:39]
  wire [8:0] _b_exponent_T_2 = {1'b0,$signed(io_b[30:23])}; // @[dut.scala 53:39]
  wire [23:0] _a_mantissa_T_3 = {1'h1,io_a[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] _a_mantissa_T_5 = {1'h0,io_a[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] _b_mantissa_T_3 = {1'h1,io_b[22:0]}; // @[Cat.scala 33:92]
  wire [23:0] _b_mantissa_T_5 = {1'h0,io_b[22:0]}; // @[Cat.scala 33:92]
  wire  _a_is_nan_T_3 = |io_a[22:0]; // @[dut.scala 59:51]
  wire  _b_is_nan_T_3 = |io_b[22:0]; // @[dut.scala 60:51]
  wire  _io_z_T = a_sign ^ b_sign; // @[dut.scala 72:28]
  wire [31:0] _io_z_T_1 = {_io_z_T,8'hff,23'h1}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_5 = {_io_z_T,8'hff,23'h0}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_7 = {_io_z_T,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_0 = a_is_zero | b_is_zero ? _io_z_T_7 : 32'h0; // @[dut.scala 82:42 84:14 36:8]
  wire [2:0] _GEN_1 = a_is_zero | b_is_zero ? 3'h0 : 3'h3; // @[dut.scala 82:42 85:15 87:15]
  wire [31:0] _GEN_2 = a_is_inf | b_is_inf ? _io_z_T_5 : _GEN_0; // @[dut.scala 78:40 80:14]
  wire [2:0] _GEN_3 = a_is_inf | b_is_inf ? 3'h0 : _GEN_1; // @[dut.scala 78:40 81:15]
  wire [31:0] _GEN_4 = a_is_inf & b_is_zero | b_is_inf & a_is_zero ? _io_z_T_1 : _GEN_2; // @[dut.scala 74:70 76:14]
  wire [2:0] _GEN_5 = a_is_inf & b_is_zero | b_is_inf & a_is_zero ? 3'h0 : _GEN_3; // @[dut.scala 74:70 77:15]
  wire [31:0] _GEN_6 = a_is_nan | b_is_nan ? _io_z_T_1 : _GEN_4; // @[dut.scala 70:34 72:14]
  wire [2:0] _GEN_7 = a_is_nan | b_is_nan ? 3'h0 : _GEN_5; // @[dut.scala 70:34 73:15]
  wire [47:0] _product_T = a_mantissa * b_mantissa; // @[dut.scala 92:29]
  wire [9:0] _z_exponent_T_1 = a_exponent + b_exponent; // @[dut.scala 95:32]
  wire [9:0] _z_exponent_T_3 = _z_exponent_T_1 - 10'h7f; // @[dut.scala 95:45]
  wire [9:0] _z_exponent_T_5 = z_exponent + 10'h1; // @[dut.scala 110:34]
  wire [23:0] _GEN_8 = product[47] ? product[47:24] : product[46:23]; // @[dut.scala 104:25 106:20 113:20]
  wire  _GEN_9 = product[47] ? product[23] : product[22]; // @[dut.scala 104:25 107:19 114:19]
  wire  _GEN_10 = product[47] ? product[22] : product[21]; // @[dut.scala 104:25 108:19 115:19]
  wire  _GEN_11 = product[47] ? |product[21:0] : |product[20:0]; // @[dut.scala 104:25 109:16 116:16]
  wire [9:0] _GEN_12 = product[47] ? _z_exponent_T_5 : z_exponent; // @[dut.scala 104:25 110:20 18:27]
  wire [23:0] _z_mantissa_T_3 = z_mantissa + 24'h1; // @[dut.scala 124:34]
  wire [23:0] _GEN_13 = &z_mantissa ? 24'h800000 : _z_mantissa_T_3; // @[dut.scala 124:20 126:31 127:22]
  wire [9:0] _GEN_14 = &z_mantissa ? _z_exponent_T_5 : z_exponent; // @[dut.scala 126:31 128:22 18:27]
  wire [23:0] _GEN_15 = guard_bit & (round_bit | sticky | z_mantissa[0]) ? _GEN_13 : z_mantissa; // @[dut.scala 123:65 15:27]
  wire [9:0] _GEN_16 = guard_bit & (round_bit | sticky | z_mantissa[0]) ? _GEN_14 : z_exponent; // @[dut.scala 123:65 18:27]
  wire [31:0] _io_z_T_8 = {z_sign,8'hff,23'h0}; // @[Cat.scala 33:92]
  wire [31:0] _io_z_T_9 = {z_sign,31'h0}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_17 = z_exponent == 10'h0 ? _io_z_T_9 : 32'h0; // @[dut.scala 140:38 142:14 36:8]
  wire [2:0] _GEN_18 = z_exponent == 10'h0 ? 3'h0 : 3'h7; // @[dut.scala 140:38 143:15 145:15]
  wire [31:0] _GEN_19 = z_exponent >= 10'hff ? _io_z_T_8 : _GEN_17; // @[dut.scala 136:33 138:14]
  wire [2:0] _GEN_20 = z_exponent >= 10'hff ? 3'h0 : _GEN_18; // @[dut.scala 136:33 139:15]
  wire [31:0] _io_z_T_12 = {z_sign,z_exponent[7:0],z_mantissa[22:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_21 = 3'h7 == state ? _io_z_T_12 : 32'h0; // @[dut.scala 150:12 42:17 36:8]
  wire [2:0] _GEN_22 = 3'h7 == state ? 3'h0 : state; // @[dut.scala 151:13 42:17 40:22]
  wire [31:0] _GEN_23 = 3'h6 == state ? _GEN_19 : _GEN_21; // @[dut.scala 42:17]
  wire [2:0] _GEN_24 = 3'h6 == state ? _GEN_20 : _GEN_22; // @[dut.scala 42:17]
  wire [23:0] _GEN_25 = 3'h5 == state ? _GEN_15 : z_mantissa; // @[dut.scala 42:17 15:27]
  wire [9:0] _GEN_26 = 3'h5 == state ? _GEN_16 : z_exponent; // @[dut.scala 42:17 18:27]
  wire [2:0] _GEN_27 = 3'h5 == state ? 3'h6 : _GEN_24; // @[dut.scala 132:13 42:17]
  wire [31:0] _GEN_28 = 3'h5 == state ? 32'h0 : _GEN_23; // @[dut.scala 42:17 36:8]
  wire [23:0] _GEN_29 = 3'h4 == state ? _GEN_8 : _GEN_25; // @[dut.scala 42:17]
  wire  _GEN_30 = 3'h4 == state ? _GEN_9 : guard_bit; // @[dut.scala 42:17 23:26]
  wire  _GEN_31 = 3'h4 == state ? _GEN_10 : round_bit; // @[dut.scala 42:17 24:26]
  wire  _GEN_32 = 3'h4 == state ? _GEN_11 : sticky; // @[dut.scala 42:17 25:23]
  wire [9:0] _GEN_33 = 3'h4 == state ? _GEN_12 : _GEN_26; // @[dut.scala 42:17]
  wire [2:0] _GEN_34 = 3'h4 == state ? 3'h5 : _GEN_27; // @[dut.scala 119:13 42:17]
  wire [31:0] _GEN_35 = 3'h4 == state ? 32'h0 : _GEN_28; // @[dut.scala 42:17 36:8]
  wire [49:0] _GEN_36 = 3'h3 == state ? {{2'd0}, _product_T} : product; // @[dut.scala 42:17 92:15 22:24]
  wire [9:0] _GEN_37 = 3'h3 == state ? _z_exponent_T_3 : _GEN_33; // @[dut.scala 42:17 95:18]
  wire  _GEN_38 = 3'h3 == state ? _io_z_T : z_sign; // @[dut.scala 42:17 98:14 21:23]
  wire [2:0] _GEN_39 = 3'h3 == state ? 3'h4 : _GEN_34; // @[dut.scala 100:13 42:17]
  wire [23:0] _GEN_40 = 3'h3 == state ? z_mantissa : _GEN_29; // @[dut.scala 42:17 15:27]
  wire  _GEN_41 = 3'h3 == state ? guard_bit : _GEN_30; // @[dut.scala 42:17 23:26]
  wire  _GEN_42 = 3'h3 == state ? round_bit : _GEN_31; // @[dut.scala 42:17 24:26]
  wire  _GEN_43 = 3'h3 == state ? sticky : _GEN_32; // @[dut.scala 42:17 25:23]
  wire [31:0] _GEN_44 = 3'h3 == state ? 32'h0 : _GEN_35; // @[dut.scala 42:17 36:8]
  wire [31:0] _GEN_45 = 3'h2 == state ? _GEN_6 : _GEN_44; // @[dut.scala 42:17]
  wire [31:0] _GEN_67 = 3'h1 == state ? 32'h0 : _GEN_45; // @[dut.scala 42:17 36:8]
  assign io_z = 3'h0 == state ? 32'h0 : _GEN_67; // @[dut.scala 42:17 36:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:27]
      a_mantissa <= 24'h0; // @[dut.scala 13:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        if (|io_a[30:23]) begin // @[dut.scala 55:24]
          a_mantissa <= _a_mantissa_T_3;
        end else begin
          a_mantissa <= _a_mantissa_T_5;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:27]
      b_mantissa <= 24'h0; // @[dut.scala 14:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        if (|io_b[30:23]) begin // @[dut.scala 56:24]
          b_mantissa <= _b_mantissa_T_3;
        end else begin
          b_mantissa <= _b_mantissa_T_5;
        end
      end
    end
    if (reset) begin // @[dut.scala 15:27]
      z_mantissa <= 24'h0; // @[dut.scala 15:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          z_mantissa <= _GEN_40;
        end
      end
    end
    if (reset) begin // @[dut.scala 16:27]
      a_exponent <= 10'h0; // @[dut.scala 16:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        a_exponent <= {{1'd0}, _a_exponent_T_2}; // @[dut.scala 52:18]
      end
    end
    if (reset) begin // @[dut.scala 17:27]
      b_exponent <= 10'h0; // @[dut.scala 17:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        b_exponent <= {{1'd0}, _b_exponent_T_2}; // @[dut.scala 53:18]
      end
    end
    if (reset) begin // @[dut.scala 18:27]
      z_exponent <= 10'h0; // @[dut.scala 18:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          z_exponent <= _GEN_37;
        end
      end
    end
    if (reset) begin // @[dut.scala 19:23]
      a_sign <= 1'h0; // @[dut.scala 19:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        a_sign <= io_a[31]; // @[dut.scala 49:14]
      end
    end
    if (reset) begin // @[dut.scala 20:23]
      b_sign <= 1'h0; // @[dut.scala 20:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        b_sign <= io_b[31]; // @[dut.scala 50:14]
      end
    end
    if (reset) begin // @[dut.scala 21:23]
      z_sign <= 1'h0; // @[dut.scala 21:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          z_sign <= _GEN_38;
        end
      end
    end
    if (reset) begin // @[dut.scala 22:24]
      product <= 50'h0; // @[dut.scala 22:24]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          product <= _GEN_36;
        end
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      guard_bit <= 1'h0; // @[dut.scala 23:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          guard_bit <= _GEN_41;
        end
      end
    end
    if (reset) begin // @[dut.scala 24:26]
      round_bit <= 1'h0; // @[dut.scala 24:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          round_bit <= _GEN_42;
        end
      end
    end
    if (reset) begin // @[dut.scala 25:23]
      sticky <= 1'h0; // @[dut.scala 25:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (!(3'h1 == state)) begin // @[dut.scala 42:17]
        if (!(3'h2 == state)) begin // @[dut.scala 42:17]
          sticky <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[dut.scala 28:25]
      a_is_nan <= 1'h0; // @[dut.scala 28:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        a_is_nan <= &io_a[30:0] & |io_a[22:0]; // @[dut.scala 59:16]
      end
    end
    if (reset) begin // @[dut.scala 29:25]
      b_is_nan <= 1'h0; // @[dut.scala 29:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        b_is_nan <= &io_b[30:0] & |io_b[22:0]; // @[dut.scala 60:16]
      end
    end
    if (reset) begin // @[dut.scala 30:25]
      a_is_inf <= 1'h0; // @[dut.scala 30:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        a_is_inf <= &io_a[30:23] & ~_a_is_nan_T_3; // @[dut.scala 61:16]
      end
    end
    if (reset) begin // @[dut.scala 31:25]
      b_is_inf <= 1'h0; // @[dut.scala 31:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        b_is_inf <= &io_b[30:23] & ~_b_is_nan_T_3; // @[dut.scala 62:16]
      end
    end
    if (reset) begin // @[dut.scala 32:26]
      a_is_zero <= 1'h0; // @[dut.scala 32:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        a_is_zero <= ~(|io_a[30:0]); // @[dut.scala 63:17]
      end
    end
    if (reset) begin // @[dut.scala 33:26]
      b_is_zero <= 1'h0; // @[dut.scala 33:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 42:17]
      if (3'h1 == state) begin // @[dut.scala 42:17]
        b_is_zero <= ~(|io_b[30:0]); // @[dut.scala 64:17]
      end
    end
    if (reset) begin // @[dut.scala 40:22]
      state <= 3'h0; // @[dut.scala 40:22]
    end else if (3'h0 == state) begin // @[dut.scala 42:17]
      state <= 3'h1; // @[dut.scala 45:13]
    end else if (3'h1 == state) begin // @[dut.scala 42:17]
      state <= 3'h2; // @[dut.scala 66:13]
    end else if (3'h2 == state) begin // @[dut.scala 42:17]
      state <= _GEN_7;
    end else begin
      state <= _GEN_39;
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
  a_is_nan = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  b_is_nan = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  a_is_inf = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  b_is_inf = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  a_is_zero = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  b_is_zero = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  state = _RAND_19[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
