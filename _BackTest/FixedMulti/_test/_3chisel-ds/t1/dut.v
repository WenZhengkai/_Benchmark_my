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
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
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
  reg  a_is_zero; // @[dut.scala 28:26]
  reg  b_is_zero; // @[dut.scala 29:26]
  reg  a_is_inf; // @[dut.scala 30:25]
  reg  b_is_inf; // @[dut.scala 31:25]
  reg  a_is_nan; // @[dut.scala 32:25]
  reg  b_is_nan; // @[dut.scala 33:25]
  reg  z_is_zero; // @[dut.scala 34:26]
  reg  z_is_inf; // @[dut.scala 35:25]
  reg  z_is_nan; // @[dut.scala 36:25]
  reg [2:0] state; // @[dut.scala 43:22]
  wire [8:0] _a_exponent_T_2 = {1'b0,$signed(io_a[30:23])}; // @[dut.scala 55:39]
  wire [8:0] _b_exponent_T_2 = {1'b0,$signed(io_b[30:23])}; // @[dut.scala 56:39]
  wire [23:0] _a_mantissa_T_3 = {1'h0,io_a[22:0]}; // @[dut.scala 59:56]
  wire [23:0] _a_mantissa_T_5 = {1'h1,io_a[22:0]}; // @[dut.scala 59:81]
  wire [23:0] _b_mantissa_T_3 = {1'h0,io_b[22:0]}; // @[dut.scala 60:56]
  wire [23:0] _b_mantissa_T_5 = {1'h1,io_b[22:0]}; // @[dut.scala 60:81]
  wire  _a_is_inf_T_1 = io_a[30:23] == 8'hff; // @[dut.scala 65:32]
  wire  _b_is_inf_T_1 = io_b[30:23] == 8'hff; // @[dut.scala 66:32]
  wire  _z_is_inf_T_1 = ~z_is_nan; // @[dut.scala 75:45]
  wire  _z_sign_T = a_sign ^ b_sign; // @[dut.scala 80:26]
  wire [7:0] _GEN_0 = z_is_inf ? 8'hff : 8'h0; // @[dut.scala 86:30 88:22 92:22]
  wire [7:0] _GEN_2 = z_is_nan ? 8'hff : _GEN_0; // @[dut.scala 82:24 84:22]
  wire [23:0] _GEN_3 = z_is_nan ? 24'h400000 : 24'h0; // @[dut.scala 82:24 85:22]
  wire  _GEN_4 = z_is_nan | z_is_inf | z_is_zero ? a_sign ^ b_sign : z_sign; // @[dut.scala 78:47 80:16 21:23]
  wire [9:0] _GEN_5 = z_is_nan | z_is_inf | z_is_zero ? {{2'd0}, _GEN_2} : z_exponent; // @[dut.scala 18:27 78:47]
  wire [23:0] _GEN_6 = z_is_nan | z_is_inf | z_is_zero ? _GEN_3 : z_mantissa; // @[dut.scala 15:27 78:47]
  wire [2:0] _GEN_7 = z_is_nan | z_is_inf | z_is_zero ? 3'h7 : 3'h3; // @[dut.scala 78:47 96:15 99:15]
  wire [47:0] _product_T = a_mantissa * b_mantissa; // @[dut.scala 104:29]
  wire [10:0] _z_exponent_T = a_exponent + b_exponent; // @[dut.scala 107:32]
  wire [10:0] _z_exponent_T_2 = _z_exponent_T - 11'h7f; // @[dut.scala 107:46]
  wire [9:0] _z_exponent_T_4 = z_exponent + 10'h1; // @[dut.scala 122:34]
  wire [23:0] _GEN_8 = product[47] ? product[47:24] : product[46:23]; // @[dut.scala 116:33 118:20 125:20]
  wire  _GEN_9 = product[47] ? product[23] : product[22]; // @[dut.scala 116:33 119:19 126:19]
  wire  _GEN_10 = product[47] ? product[22] : product[21]; // @[dut.scala 116:33 120:19 127:19]
  wire  _GEN_11 = product[47] ? |product[21:0] : |product[20:0]; // @[dut.scala 116:33 121:16 128:16]
  wire [9:0] _GEN_12 = product[47] ? _z_exponent_T_4 : z_exponent; // @[dut.scala 116:33 122:20 18:27]
  wire  round_up = guard_bit & (round_bit | sticky | z_mantissa[0]); // @[dut.scala 135:32]
  wire [23:0] _z_mantissa_T_3 = z_mantissa + 24'h1; // @[dut.scala 138:34]
  wire [24:0] _GEN_108 = {{1'd0}, z_mantissa}; // @[dut.scala 141:25]
  wire [23:0] _GEN_13 = _GEN_108 == 25'h1000000 ? 24'h800000 : _z_mantissa_T_3; // @[dut.scala 138:20 141:43 142:22]
  wire [9:0] _GEN_14 = _GEN_108 == 25'h1000000 ? _z_exponent_T_4 : z_exponent; // @[dut.scala 141:43 143:22 18:27]
  wire [23:0] _GEN_15 = round_up ? _GEN_13 : z_mantissa; // @[dut.scala 137:22 15:27]
  wire [9:0] _GEN_16 = round_up ? _GEN_14 : z_exponent; // @[dut.scala 137:22 18:27]
  wire [9:0] _GEN_17 = z_exponent == 10'h0 ? 10'h0 : z_exponent; // @[dut.scala 155:38 157:20 18:27]
  wire [23:0] _GEN_18 = z_exponent == 10'h0 ? 24'h0 : z_mantissa; // @[dut.scala 155:38 158:20 15:27]
  wire [9:0] _GEN_19 = z_exponent >= 10'hff ? 10'hff : _GEN_17; // @[dut.scala 151:33 153:20]
  wire [23:0] _GEN_20 = z_exponent >= 10'hff ? 24'h0 : _GEN_18; // @[dut.scala 151:33 154:20]
  wire [31:0] _io_z_T_2 = {z_sign,z_exponent[7:0],z_mantissa[22:0]}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_21 = 3'h7 == state ? _io_z_T_2 : 32'h0; // @[dut.scala 165:12 45:17 39:8]
  wire [2:0] _GEN_22 = 3'h7 == state ? 3'h0 : state; // @[dut.scala 168:13 45:17 43:22]
  wire [9:0] _GEN_23 = 3'h6 == state ? _GEN_19 : z_exponent; // @[dut.scala 45:17 18:27]
  wire [23:0] _GEN_24 = 3'h6 == state ? _GEN_20 : z_mantissa; // @[dut.scala 45:17 15:27]
  wire [2:0] _GEN_25 = 3'h6 == state ? 3'h7 : _GEN_22; // @[dut.scala 161:13 45:17]
  wire [31:0] _GEN_26 = 3'h6 == state ? 32'h0 : _GEN_21; // @[dut.scala 45:17 39:8]
  wire [23:0] _GEN_27 = 3'h5 == state ? _GEN_15 : _GEN_24; // @[dut.scala 45:17]
  wire [9:0] _GEN_28 = 3'h5 == state ? _GEN_16 : _GEN_23; // @[dut.scala 45:17]
  wire [2:0] _GEN_29 = 3'h5 == state ? 3'h6 : _GEN_25; // @[dut.scala 147:13 45:17]
  wire [31:0] _GEN_30 = 3'h5 == state ? 32'h0 : _GEN_26; // @[dut.scala 45:17 39:8]
  wire [23:0] _GEN_31 = 3'h4 == state ? _GEN_8 : _GEN_27; // @[dut.scala 45:17]
  wire  _GEN_32 = 3'h4 == state ? _GEN_9 : guard_bit; // @[dut.scala 45:17 23:26]
  wire  _GEN_33 = 3'h4 == state ? _GEN_10 : round_bit; // @[dut.scala 45:17 24:26]
  wire  _GEN_34 = 3'h4 == state ? _GEN_11 : sticky; // @[dut.scala 45:17 25:23]
  wire [9:0] _GEN_35 = 3'h4 == state ? _GEN_12 : _GEN_28; // @[dut.scala 45:17]
  wire [2:0] _GEN_36 = 3'h4 == state ? 3'h5 : _GEN_29; // @[dut.scala 131:13 45:17]
  wire [31:0] _GEN_37 = 3'h4 == state ? 32'h0 : _GEN_30; // @[dut.scala 45:17 39:8]
  wire [49:0] _GEN_38 = 3'h3 == state ? {{2'd0}, _product_T} : product; // @[dut.scala 104:15 45:17 22:24]
  wire [10:0] _GEN_39 = 3'h3 == state ? _z_exponent_T_2 : {{1'd0}, _GEN_35}; // @[dut.scala 45:17 107:18]
  wire  _GEN_40 = 3'h3 == state ? _z_sign_T : z_sign; // @[dut.scala 110:14 45:17 21:23]
  wire [2:0] _GEN_41 = 3'h3 == state ? 3'h4 : _GEN_36; // @[dut.scala 112:13 45:17]
  wire [23:0] _GEN_42 = 3'h3 == state ? z_mantissa : _GEN_31; // @[dut.scala 45:17 15:27]
  wire  _GEN_43 = 3'h3 == state ? guard_bit : _GEN_32; // @[dut.scala 45:17 23:26]
  wire  _GEN_44 = 3'h3 == state ? round_bit : _GEN_33; // @[dut.scala 45:17 24:26]
  wire  _GEN_45 = 3'h3 == state ? sticky : _GEN_34; // @[dut.scala 45:17 25:23]
  wire [31:0] _GEN_46 = 3'h3 == state ? 32'h0 : _GEN_37; // @[dut.scala 45:17 39:8]
  wire [10:0] _GEN_51 = 3'h2 == state ? {{1'd0}, _GEN_5} : _GEN_39; // @[dut.scala 45:17]
  wire [31:0] _GEN_58 = 3'h2 == state ? 32'h0 : _GEN_46; // @[dut.scala 45:17 39:8]
  wire [10:0] _GEN_76 = 3'h1 == state ? {{1'd0}, z_exponent} : _GEN_51; // @[dut.scala 45:17 18:27]
  wire [31:0] _GEN_82 = 3'h1 == state ? 32'h0 : _GEN_58; // @[dut.scala 45:17 39:8]
  wire [10:0] _GEN_101 = 3'h0 == state ? {{1'd0}, z_exponent} : _GEN_76; // @[dut.scala 45:17 18:27]
  wire [10:0] _GEN_109 = reset ? 11'h0 : _GEN_101; // @[dut.scala 18:{27,27}]
  assign io_z = 3'h0 == state ? 32'h0 : _GEN_82; // @[dut.scala 45:17 39:8]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:27]
      a_mantissa <= 24'h0; // @[dut.scala 13:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        if (io_a[30:23] == 8'h0) begin // @[dut.scala 59:24]
          a_mantissa <= _a_mantissa_T_3;
        end else begin
          a_mantissa <= _a_mantissa_T_5;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:27]
      b_mantissa <= 24'h0; // @[dut.scala 14:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        if (io_b[30:23] == 8'h0) begin // @[dut.scala 60:24]
          b_mantissa <= _b_mantissa_T_3;
        end else begin
          b_mantissa <= _b_mantissa_T_5;
        end
      end
    end
    if (reset) begin // @[dut.scala 15:27]
      z_mantissa <= 24'h0; // @[dut.scala 15:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (3'h2 == state) begin // @[dut.scala 45:17]
          z_mantissa <= _GEN_6;
        end else begin
          z_mantissa <= _GEN_42;
        end
      end
    end
    if (reset) begin // @[dut.scala 16:27]
      a_exponent <= 10'h0; // @[dut.scala 16:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        a_exponent <= {{1'd0}, _a_exponent_T_2}; // @[dut.scala 55:18]
      end
    end
    if (reset) begin // @[dut.scala 17:27]
      b_exponent <= 10'h0; // @[dut.scala 17:27]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        b_exponent <= {{1'd0}, _b_exponent_T_2}; // @[dut.scala 56:18]
      end
    end
    z_exponent <= _GEN_109[9:0]; // @[dut.scala 18:{27,27}]
    if (reset) begin // @[dut.scala 19:23]
      a_sign <= 1'h0; // @[dut.scala 19:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        a_sign <= io_a[31]; // @[dut.scala 52:14]
      end
    end
    if (reset) begin // @[dut.scala 20:23]
      b_sign <= 1'h0; // @[dut.scala 20:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        b_sign <= io_b[31]; // @[dut.scala 53:14]
      end
    end
    if (reset) begin // @[dut.scala 21:23]
      z_sign <= 1'h0; // @[dut.scala 21:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (3'h2 == state) begin // @[dut.scala 45:17]
          z_sign <= _GEN_4;
        end else begin
          z_sign <= _GEN_40;
        end
      end
    end
    if (reset) begin // @[dut.scala 22:24]
      product <= 50'h0; // @[dut.scala 22:24]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (!(3'h2 == state)) begin // @[dut.scala 45:17]
          product <= _GEN_38;
        end
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      guard_bit <= 1'h0; // @[dut.scala 23:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (!(3'h2 == state)) begin // @[dut.scala 45:17]
          guard_bit <= _GEN_43;
        end
      end
    end
    if (reset) begin // @[dut.scala 24:26]
      round_bit <= 1'h0; // @[dut.scala 24:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (!(3'h2 == state)) begin // @[dut.scala 45:17]
          round_bit <= _GEN_44;
        end
      end
    end
    if (reset) begin // @[dut.scala 25:23]
      sticky <= 1'h0; // @[dut.scala 25:23]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (!(3'h2 == state)) begin // @[dut.scala 45:17]
          sticky <= _GEN_45;
        end
      end
    end
    if (reset) begin // @[dut.scala 28:26]
      a_is_zero <= 1'h0; // @[dut.scala 28:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        a_is_zero <= io_a[30:0] == 31'h0; // @[dut.scala 63:17]
      end
    end
    if (reset) begin // @[dut.scala 29:26]
      b_is_zero <= 1'h0; // @[dut.scala 29:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        b_is_zero <= io_b[30:0] == 31'h0; // @[dut.scala 64:17]
      end
    end
    if (reset) begin // @[dut.scala 30:25]
      a_is_inf <= 1'h0; // @[dut.scala 30:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        a_is_inf <= io_a[30:23] == 8'hff & io_a[22:0] == 23'h0; // @[dut.scala 65:16]
      end
    end
    if (reset) begin // @[dut.scala 31:25]
      b_is_inf <= 1'h0; // @[dut.scala 31:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        b_is_inf <= io_b[30:23] == 8'hff & io_b[22:0] == 23'h0; // @[dut.scala 66:16]
      end
    end
    if (reset) begin // @[dut.scala 32:25]
      a_is_nan <= 1'h0; // @[dut.scala 32:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        a_is_nan <= _a_is_inf_T_1 & io_a[22:0] != 23'h0; // @[dut.scala 67:16]
      end
    end
    if (reset) begin // @[dut.scala 33:25]
      b_is_nan <= 1'h0; // @[dut.scala 33:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (3'h1 == state) begin // @[dut.scala 45:17]
        b_is_nan <= _b_is_inf_T_1 & io_b[22:0] != 23'h0; // @[dut.scala 68:16]
      end
    end
    if (reset) begin // @[dut.scala 34:26]
      z_is_zero <= 1'h0; // @[dut.scala 34:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (3'h2 == state) begin // @[dut.scala 45:17]
          z_is_zero <= (a_is_zero | b_is_zero) & _z_is_inf_T_1; // @[dut.scala 76:17]
        end
      end
    end
    if (reset) begin // @[dut.scala 35:25]
      z_is_inf <= 1'h0; // @[dut.scala 35:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (3'h2 == state) begin // @[dut.scala 45:17]
          z_is_inf <= (a_is_inf | b_is_inf) & ~z_is_nan; // @[dut.scala 75:16]
        end
      end
    end
    if (reset) begin // @[dut.scala 36:25]
      z_is_nan <= 1'h0; // @[dut.scala 36:25]
    end else if (!(3'h0 == state)) begin // @[dut.scala 45:17]
      if (!(3'h1 == state)) begin // @[dut.scala 45:17]
        if (3'h2 == state) begin // @[dut.scala 45:17]
          z_is_nan <= a_is_nan | b_is_nan | a_is_zero & b_is_inf | a_is_inf & b_is_zero; // @[dut.scala 74:16]
        end
      end
    end
    if (reset) begin // @[dut.scala 43:22]
      state <= 3'h0; // @[dut.scala 43:22]
    end else if (3'h0 == state) begin // @[dut.scala 45:17]
      state <= 3'h1; // @[dut.scala 48:13]
    end else if (3'h1 == state) begin // @[dut.scala 45:17]
      state <= 3'h2; // @[dut.scala 70:13]
    end else if (3'h2 == state) begin // @[dut.scala 45:17]
      state <= _GEN_7;
    end else begin
      state <= _GEN_41;
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
  a_is_zero = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  b_is_zero = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  a_is_inf = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  b_is_inf = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  a_is_nan = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  b_is_nan = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  z_is_zero = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  z_is_inf = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  z_is_nan = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  state = _RAND_22[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
