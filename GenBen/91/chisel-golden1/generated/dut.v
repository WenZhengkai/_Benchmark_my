module dut(
  input         clock,
  input         reset,
  input         io_enable,
  input  [1:0]  io_rmode,
  input  [63:0] io_opa,
  input  [63:0] io_opb,
  input  [63:0] io_in_except,
  input  [11:0] io_exponent_in,
  input  [1:0]  io_mantissa_in,
  input  [2:0]  io_fpu_op,
  output [63:0] io_ref_out,
  output        io_ref_ex_enable,
  output        io_ref_underflow,
  output        io_ref_overflow,
  output        io_ref_inexact,
  output        io_ref_exception,
  output        io_ref_invalid
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
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [63:0] _RAND_48;
  reg [63:0] _RAND_49;
  reg [63:0] _RAND_50;
  reg [63:0] _RAND_51;
  reg [63:0] _RAND_52;
  reg [63:0] _RAND_53;
  reg [63:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [63:0] _RAND_61;
`endif // RANDOMIZE_REG_INIT
  reg  in_et_zero; // @[dut.scala 32:37]
  reg  opa_et_zero; // @[dut.scala 33:37]
  reg  opb_et_zero; // @[dut.scala 34:37]
  reg  add; // @[dut.scala 36:37]
  reg  subtract; // @[dut.scala 37:37]
  reg  multiply; // @[dut.scala 38:37]
  reg  divide; // @[dut.scala 39:37]
  reg  opa_QNaN; // @[dut.scala 40:37]
  reg  opb_QNaN; // @[dut.scala 41:37]
  reg  opa_SNaN; // @[dut.scala 42:37]
  reg  opb_SNaN; // @[dut.scala 43:37]
  reg  opa_pos_inf; // @[dut.scala 44:37]
  reg  opb_pos_inf; // @[dut.scala 45:37]
  reg  opa_neg_inf; // @[dut.scala 46:37]
  reg  opb_neg_inf; // @[dut.scala 47:37]
  reg  opa_inf; // @[dut.scala 48:37]
  reg  opb_inf; // @[dut.scala 49:37]
  reg  NaN_input; // @[dut.scala 50:37]
  reg  SNaN_input; // @[dut.scala 51:37]
  reg  a_NaN; // @[dut.scala 52:37]
  reg  div_by_0; // @[dut.scala 53:37]
  reg  div_0_by_0; // @[dut.scala 54:37]
  reg  div_inf_by_inf; // @[dut.scala 55:37]
  reg  div_by_inf; // @[dut.scala 56:37]
  reg  mul_0_by_inf; // @[dut.scala 57:37]
  reg  mul_inf; // @[dut.scala 58:37]
  reg  div_inf; // @[dut.scala 59:37]
  reg  add_inf; // @[dut.scala 60:37]
  reg  sub_inf; // @[dut.scala 61:37]
  reg  addsub_inf_invalid; // @[dut.scala 62:37]
  reg  addsub_inf; // @[dut.scala 63:37]
  reg  out_inf_trigger; // @[dut.scala 64:37]
  reg  out_pos_inf; // @[dut.scala 65:37]
  reg  out_neg_inf; // @[dut.scala 66:37]
  reg  round_to_zero; // @[dut.scala 68:37]
  reg  round_to_pos_inf; // @[dut.scala 69:37]
  reg  round_to_neg_inf; // @[dut.scala 70:37]
  reg  inf_round_down_trigger; // @[dut.scala 71:39]
  reg  mul_uf; // @[dut.scala 72:37]
  reg  div_uf; // @[dut.scala 73:37]
  reg  underflow_trigger; // @[dut.scala 74:37]
  reg  invalid_trigger; // @[dut.scala 75:37]
  reg  overflow_trigger; // @[dut.scala 76:37]
  reg  inexact_trigger; // @[dut.scala 77:37]
  reg  except_trigger; // @[dut.scala 78:37]
  reg  enable_trigger; // @[dut.scala 79:37]
  reg  NaN_out_trigger; // @[dut.scala 80:37]
  reg  SNaN_trigger; // @[dut.scala 81:37]
  reg [62:0] NaN_output_0; // @[dut.scala 82:37]
  reg [62:0] NaN_output; // @[dut.scala 83:37]
  reg [62:0] inf_round_down; // @[dut.scala 84:37]
  reg [62:0] out_inf; // @[dut.scala 85:37]
  reg [63:0] out_0; // @[dut.scala 86:37]
  reg [63:0] out_1; // @[dut.scala 87:37]
  reg [63:0] out_2; // @[dut.scala 88:37]
  reg  ref_ex_enable; // @[dut.scala 91:37]
  reg  ref_underflow; // @[dut.scala 92:37]
  reg  ref_overflow; // @[dut.scala 93:37]
  reg  ref_inexact; // @[dut.scala 94:37]
  reg  ref_exception; // @[dut.scala 95:37]
  reg  ref_invalid; // @[dut.scala 96:37]
  reg [63:0] ref_out; // @[dut.scala 97:37]
  wire  _opa_QNaN_T_1 = io_opa[62:52] == 11'h7ff; // @[dut.scala 171:32]
  wire  _opa_QNaN_T_3 = |io_opa[51:0]; // @[dut.scala 171:62]
  wire  _opa_QNaN_T_4 = io_opa[62:52] == 11'h7ff & |io_opa[51:0]; // @[dut.scala 171:46]
  wire  _opb_QNaN_T_1 = io_opb[62:52] == 11'h7ff; // @[dut.scala 172:32]
  wire  _opb_QNaN_T_3 = |io_opb[51:0]; // @[dut.scala 172:62]
  wire  _opb_QNaN_T_4 = io_opb[62:52] == 11'h7ff & |io_opb[51:0]; // @[dut.scala 172:46]
  wire  _opa_pos_inf_T_7 = ~_opa_QNaN_T_3; // @[dut.scala 176:67]
  wire  _opb_pos_inf_T_7 = ~_opb_QNaN_T_3; // @[dut.scala 177:67]
  wire  _div_by_0_T = divide & opb_et_zero; // @[dut.scala 187:32]
  wire  _div_by_0_T_1 = ~opa_et_zero; // @[dut.scala 187:50]
  wire  _div_inf_by_inf_T = divide & opa_inf; // @[dut.scala 189:32]
  wire  _mul_inf_T = opa_inf | opb_inf; // @[dut.scala 192:46]
  wire  _addsub_inf_invalid_T_6 = subtract & opa_pos_inf & opb_pos_inf; // @[dut.scala 197:52]
  wire  _addsub_inf_invalid_T_7 = add & opa_pos_inf & opb_neg_inf | add & opa_neg_inf & opb_pos_inf |
    _addsub_inf_invalid_T_6; // @[dut.scala 196:102]
  wire  _addsub_inf_invalid_T_10 = _addsub_inf_invalid_T_7 | subtract & opa_neg_inf & opb_neg_inf; // @[dut.scala 197:68]
  wire  _inf_round_down_trigger_T_1 = out_neg_inf & round_to_pos_inf; // @[dut.scala 208:43]
  wire  _inf_round_down_trigger_T_2 = out_pos_inf & round_to_neg_inf | _inf_round_down_trigger_T_1; // @[dut.scala 207:65]
  wire  _inf_round_down_trigger_T_3 = out_inf_trigger & round_to_zero; // @[dut.scala 209:47]
  wire  _inf_round_down_trigger_T_4 = _inf_round_down_trigger_T_2 | _inf_round_down_trigger_T_3; // @[dut.scala 208:64]
  wire  _invalid_trigger_T_2 = SNaN_input | addsub_inf_invalid | mul_0_by_inf | div_0_by_0; // @[dut.scala 215:73]
  wire  _invalid_trigger_T_3 = _invalid_trigger_T_2 | div_inf_by_inf; // @[dut.scala 216:35]
  wire  _overflow_trigger_T = ~NaN_input; // @[dut.scala 217:44]
  wire [62:0] _NaN_output_0_T_1 = {12'hfff,io_opa[50:0]}; // @[Cat.scala 33:92]
  wire [62:0] _NaN_output_0_T_3 = {12'hfff,io_opb[50:0]}; // @[Cat.scala 33:92]
  wire [62:0] _NaN_output_T_1 = {13'h1ffd,io_opa[49:0]}; // @[Cat.scala 33:92]
  wire [63:0] _out_0_T_1 = {io_in_except[63],63'h0}; // @[Cat.scala 33:92]
  wire [63:0] _out_1_T_1 = {io_in_except[63],out_inf}; // @[Cat.scala 33:92]
  wire [63:0] _out_2_T_1 = {io_in_except[63],NaN_output}; // @[Cat.scala 33:92]
  assign io_ref_out = ref_out; // @[dut.scala 260:20]
  assign io_ref_ex_enable = ref_ex_enable; // @[dut.scala 254:20]
  assign io_ref_underflow = ref_underflow; // @[dut.scala 255:20]
  assign io_ref_overflow = ref_overflow; // @[dut.scala 256:20]
  assign io_ref_inexact = ref_inexact; // @[dut.scala 257:20]
  assign io_ref_exception = ref_exception; // @[dut.scala 258:20]
  assign io_ref_invalid = ref_invalid; // @[dut.scala 259:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 32:37]
      in_et_zero <= 1'h0; // @[dut.scala 32:37]
    end else if (reset) begin // @[dut.scala 101:23]
      in_et_zero <= 1'h0; // @[dut.scala 102:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      in_et_zero <= ~(|io_in_except[62:0]); // @[dut.scala 161:19]
    end
    if (reset) begin // @[dut.scala 33:37]
      opa_et_zero <= 1'h0; // @[dut.scala 33:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_et_zero <= 1'h0; // @[dut.scala 103:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_et_zero <= ~(|io_opa[62:0]); // @[dut.scala 162:19]
    end
    if (reset) begin // @[dut.scala 34:37]
      opb_et_zero <= 1'h0; // @[dut.scala 34:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_et_zero <= 1'h0; // @[dut.scala 104:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_et_zero <= ~(|io_opb[62:0]); // @[dut.scala 163:19]
    end
    if (reset) begin // @[dut.scala 36:37]
      add <= 1'h0; // @[dut.scala 36:37]
    end else if (reset) begin // @[dut.scala 101:23]
      add <= 1'h0; // @[dut.scala 106:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      add <= io_fpu_op == 3'h0; // @[dut.scala 166:14]
    end
    if (reset) begin // @[dut.scala 37:37]
      subtract <= 1'h0; // @[dut.scala 37:37]
    end else if (reset) begin // @[dut.scala 101:23]
      subtract <= 1'h0; // @[dut.scala 107:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      subtract <= io_fpu_op == 3'h1; // @[dut.scala 167:14]
    end
    if (reset) begin // @[dut.scala 38:37]
      multiply <= 1'h0; // @[dut.scala 38:37]
    end else if (reset) begin // @[dut.scala 101:23]
      multiply <= 1'h0; // @[dut.scala 108:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      multiply <= io_fpu_op == 3'h2; // @[dut.scala 168:14]
    end
    if (reset) begin // @[dut.scala 39:37]
      divide <= 1'h0; // @[dut.scala 39:37]
    end else if (reset) begin // @[dut.scala 101:23]
      divide <= 1'h0; // @[dut.scala 109:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      divide <= io_fpu_op == 3'h3; // @[dut.scala 169:14]
    end
    if (reset) begin // @[dut.scala 40:37]
      opa_QNaN <= 1'h0; // @[dut.scala 40:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_QNaN <= 1'h0; // @[dut.scala 110:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_QNaN <= io_opa[62:52] == 11'h7ff & |io_opa[51:0] & io_opa[51]; // @[dut.scala 171:14]
    end
    if (reset) begin // @[dut.scala 41:37]
      opb_QNaN <= 1'h0; // @[dut.scala 41:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_QNaN <= 1'h0; // @[dut.scala 111:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_QNaN <= io_opb[62:52] == 11'h7ff & |io_opb[51:0] & io_opb[51]; // @[dut.scala 172:14]
    end
    if (reset) begin // @[dut.scala 42:37]
      opa_SNaN <= 1'h0; // @[dut.scala 42:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_SNaN <= 1'h0; // @[dut.scala 112:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_SNaN <= _opa_QNaN_T_4 & ~io_opa[51]; // @[dut.scala 173:14]
    end
    if (reset) begin // @[dut.scala 43:37]
      opb_SNaN <= 1'h0; // @[dut.scala 43:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_SNaN <= 1'h0; // @[dut.scala 113:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_SNaN <= _opb_QNaN_T_4 & ~io_opb[51]; // @[dut.scala 174:14]
    end
    if (reset) begin // @[dut.scala 44:37]
      opa_pos_inf <= 1'h0; // @[dut.scala 44:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_pos_inf <= 1'h0; // @[dut.scala 114:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_pos_inf <= ~io_opa[63] & _opa_QNaN_T_1 & ~_opa_QNaN_T_3; // @[dut.scala 176:17]
    end
    if (reset) begin // @[dut.scala 45:37]
      opb_pos_inf <= 1'h0; // @[dut.scala 45:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_pos_inf <= 1'h0; // @[dut.scala 115:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_pos_inf <= ~io_opb[63] & _opb_QNaN_T_1 & ~_opb_QNaN_T_3; // @[dut.scala 177:17]
    end
    if (reset) begin // @[dut.scala 46:37]
      opa_neg_inf <= 1'h0; // @[dut.scala 46:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_neg_inf <= 1'h0; // @[dut.scala 116:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_neg_inf <= io_opa[63] & _opa_QNaN_T_1 & _opa_pos_inf_T_7; // @[dut.scala 178:17]
    end
    if (reset) begin // @[dut.scala 47:37]
      opb_neg_inf <= 1'h0; // @[dut.scala 47:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_neg_inf <= 1'h0; // @[dut.scala 117:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_neg_inf <= io_opb[63] & _opb_QNaN_T_1 & _opb_pos_inf_T_7; // @[dut.scala 179:17]
    end
    if (reset) begin // @[dut.scala 48:37]
      opa_inf <= 1'h0; // @[dut.scala 48:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opa_inf <= 1'h0; // @[dut.scala 118:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opa_inf <= _opa_QNaN_T_1 & _opa_pos_inf_T_7; // @[dut.scala 180:13]
    end
    if (reset) begin // @[dut.scala 49:37]
      opb_inf <= 1'h0; // @[dut.scala 49:37]
    end else if (reset) begin // @[dut.scala 101:23]
      opb_inf <= 1'h0; // @[dut.scala 119:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      opb_inf <= _opb_QNaN_T_1 & _opb_pos_inf_T_7; // @[dut.scala 181:13]
    end
    if (reset) begin // @[dut.scala 50:37]
      NaN_input <= 1'h0; // @[dut.scala 50:37]
    end else if (reset) begin // @[dut.scala 101:23]
      NaN_input <= 1'h0; // @[dut.scala 120:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      NaN_input <= opa_QNaN | opb_QNaN | opa_SNaN | opb_SNaN; // @[dut.scala 183:15]
    end
    if (reset) begin // @[dut.scala 51:37]
      SNaN_input <= 1'h0; // @[dut.scala 51:37]
    end else if (reset) begin // @[dut.scala 101:23]
      SNaN_input <= 1'h0; // @[dut.scala 121:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      SNaN_input <= opa_SNaN | opb_SNaN; // @[dut.scala 184:16]
    end
    if (reset) begin // @[dut.scala 52:37]
      a_NaN <= 1'h0; // @[dut.scala 52:37]
    end else if (reset) begin // @[dut.scala 101:23]
      a_NaN <= 1'h0; // @[dut.scala 122:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      a_NaN <= opa_QNaN | opa_SNaN; // @[dut.scala 185:11]
    end
    if (reset) begin // @[dut.scala 53:37]
      div_by_0 <= 1'h0; // @[dut.scala 53:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_by_0 <= 1'h0; // @[dut.scala 123:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_by_0 <= divide & opb_et_zero & ~opa_et_zero; // @[dut.scala 187:22]
    end
    if (reset) begin // @[dut.scala 54:37]
      div_0_by_0 <= 1'h0; // @[dut.scala 54:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_0_by_0 <= 1'h0; // @[dut.scala 124:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_0_by_0 <= _div_by_0_T & opa_et_zero; // @[dut.scala 188:22]
    end
    if (reset) begin // @[dut.scala 55:37]
      div_inf_by_inf <= 1'h0; // @[dut.scala 55:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_inf_by_inf <= 1'h0; // @[dut.scala 125:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_inf_by_inf <= divide & opa_inf & opb_inf; // @[dut.scala 189:22]
    end
    if (reset) begin // @[dut.scala 56:37]
      div_by_inf <= 1'h0; // @[dut.scala 56:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_by_inf <= 1'h0; // @[dut.scala 126:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_by_inf <= divide & ~opa_inf & opb_inf; // @[dut.scala 190:22]
    end
    if (reset) begin // @[dut.scala 57:37]
      mul_0_by_inf <= 1'h0; // @[dut.scala 57:37]
    end else if (reset) begin // @[dut.scala 101:23]
      mul_0_by_inf <= 1'h0; // @[dut.scala 127:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      mul_0_by_inf <= multiply & (opa_inf & opb_et_zero | opa_et_zero & opb_inf); // @[dut.scala 191:22]
    end
    if (reset) begin // @[dut.scala 58:37]
      mul_inf <= 1'h0; // @[dut.scala 58:37]
    end else if (reset) begin // @[dut.scala 101:23]
      mul_inf <= 1'h0; // @[dut.scala 128:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      mul_inf <= multiply & (opa_inf | opb_inf) & ~mul_0_by_inf; // @[dut.scala 192:22]
    end
    if (reset) begin // @[dut.scala 59:37]
      div_inf <= 1'h0; // @[dut.scala 59:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_inf <= 1'h0; // @[dut.scala 129:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_inf <= _div_inf_by_inf_T & ~opb_inf; // @[dut.scala 193:22]
    end
    if (reset) begin // @[dut.scala 60:37]
      add_inf <= 1'h0; // @[dut.scala 60:37]
    end else if (reset) begin // @[dut.scala 101:23]
      add_inf <= 1'h0; // @[dut.scala 130:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      add_inf <= add & _mul_inf_T; // @[dut.scala 194:22]
    end
    if (reset) begin // @[dut.scala 61:37]
      sub_inf <= 1'h0; // @[dut.scala 61:37]
    end else if (reset) begin // @[dut.scala 101:23]
      sub_inf <= 1'h0; // @[dut.scala 131:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      sub_inf <= subtract & _mul_inf_T; // @[dut.scala 195:22]
    end
    if (reset) begin // @[dut.scala 62:37]
      addsub_inf_invalid <= 1'h0; // @[dut.scala 62:37]
    end else if (reset) begin // @[dut.scala 101:23]
      addsub_inf_invalid <= 1'h0; // @[dut.scala 132:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      addsub_inf_invalid <= _addsub_inf_invalid_T_10; // @[dut.scala 196:24]
    end
    if (reset) begin // @[dut.scala 63:37]
      addsub_inf <= 1'h0; // @[dut.scala 63:37]
    end else if (reset) begin // @[dut.scala 101:23]
      addsub_inf <= 1'h0; // @[dut.scala 133:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      addsub_inf <= (add_inf | sub_inf) & ~addsub_inf_invalid; // @[dut.scala 198:16]
    end
    if (reset) begin // @[dut.scala 64:37]
      out_inf_trigger <= 1'h0; // @[dut.scala 64:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_inf_trigger <= 1'h0; // @[dut.scala 134:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      out_inf_trigger <= addsub_inf | mul_inf | div_inf | div_by_0 | io_exponent_in > 12'h7fe; // @[dut.scala 199:21]
    end
    if (reset) begin // @[dut.scala 65:37]
      out_pos_inf <= 1'h0; // @[dut.scala 65:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_pos_inf <= 1'h0; // @[dut.scala 135:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      out_pos_inf <= out_inf_trigger & ~io_in_except[63]; // @[dut.scala 200:17]
    end
    if (reset) begin // @[dut.scala 66:37]
      out_neg_inf <= 1'h0; // @[dut.scala 66:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_neg_inf <= 1'h0; // @[dut.scala 136:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      out_neg_inf <= out_inf_trigger & io_in_except[63]; // @[dut.scala 201:17]
    end
    if (reset) begin // @[dut.scala 68:37]
      round_to_zero <= 1'h0; // @[dut.scala 68:37]
    end else if (reset) begin // @[dut.scala 101:23]
      round_to_zero <= 1'h0; // @[dut.scala 138:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      round_to_zero <= io_rmode == 2'h1; // @[dut.scala 204:22]
    end
    if (reset) begin // @[dut.scala 69:37]
      round_to_pos_inf <= 1'h0; // @[dut.scala 69:37]
    end else if (reset) begin // @[dut.scala 101:23]
      round_to_pos_inf <= 1'h0; // @[dut.scala 139:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      round_to_pos_inf <= io_rmode == 2'h2; // @[dut.scala 205:22]
    end
    if (reset) begin // @[dut.scala 70:37]
      round_to_neg_inf <= 1'h0; // @[dut.scala 70:37]
    end else if (reset) begin // @[dut.scala 101:23]
      round_to_neg_inf <= 1'h0; // @[dut.scala 140:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      round_to_neg_inf <= io_rmode == 2'h3; // @[dut.scala 206:22]
    end
    if (reset) begin // @[dut.scala 71:39]
      inf_round_down_trigger <= 1'h0; // @[dut.scala 71:39]
    end else if (reset) begin // @[dut.scala 101:23]
      inf_round_down_trigger <= 1'h0; // @[dut.scala 141:28]
    end else if (io_enable) begin // @[dut.scala 159:27]
      inf_round_down_trigger <= _inf_round_down_trigger_T_4; // @[dut.scala 207:28]
    end
    if (reset) begin // @[dut.scala 72:37]
      mul_uf <= 1'h0; // @[dut.scala 72:37]
    end else if (reset) begin // @[dut.scala 101:23]
      mul_uf <= 1'h0; // @[dut.scala 142:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      mul_uf <= multiply & _div_by_0_T_1 & ~opb_et_zero & in_et_zero; // @[dut.scala 211:12]
    end
    if (reset) begin // @[dut.scala 73:37]
      div_uf <= 1'h0; // @[dut.scala 73:37]
    end else if (reset) begin // @[dut.scala 101:23]
      div_uf <= 1'h0; // @[dut.scala 143:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      div_uf <= divide & _div_by_0_T_1 & in_et_zero; // @[dut.scala 212:12]
    end
    if (reset) begin // @[dut.scala 74:37]
      underflow_trigger <= 1'h0; // @[dut.scala 74:37]
    end else if (reset) begin // @[dut.scala 101:23]
      underflow_trigger <= 1'h0; // @[dut.scala 144:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      underflow_trigger <= div_by_inf | mul_uf | div_uf; // @[dut.scala 213:23]
    end
    if (reset) begin // @[dut.scala 75:37]
      invalid_trigger <= 1'h0; // @[dut.scala 75:37]
    end else if (reset) begin // @[dut.scala 101:23]
      invalid_trigger <= 1'h0; // @[dut.scala 145:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      invalid_trigger <= _invalid_trigger_T_3; // @[dut.scala 215:21]
    end
    if (reset) begin // @[dut.scala 76:37]
      overflow_trigger <= 1'h0; // @[dut.scala 76:37]
    end else if (reset) begin // @[dut.scala 101:23]
      overflow_trigger <= 1'h0; // @[dut.scala 146:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      overflow_trigger <= out_inf_trigger & ~NaN_input; // @[dut.scala 217:22]
    end
    if (reset) begin // @[dut.scala 77:37]
      inexact_trigger <= 1'h0; // @[dut.scala 77:37]
    end else if (reset) begin // @[dut.scala 101:23]
      inexact_trigger <= 1'h0; // @[dut.scala 147:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      inexact_trigger <= (|io_mantissa_in | out_inf_trigger | underflow_trigger) & _overflow_trigger_T; // @[dut.scala 218:21]
    end
    if (reset) begin // @[dut.scala 78:37]
      except_trigger <= 1'h0; // @[dut.scala 78:37]
    end else if (reset) begin // @[dut.scala 101:23]
      except_trigger <= 1'h0; // @[dut.scala 148:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      except_trigger <= invalid_trigger | overflow_trigger | underflow_trigger | inexact_trigger; // @[dut.scala 219:20]
    end
    if (reset) begin // @[dut.scala 79:37]
      enable_trigger <= 1'h0; // @[dut.scala 79:37]
    end else if (reset) begin // @[dut.scala 101:23]
      enable_trigger <= 1'h0; // @[dut.scala 149:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      enable_trigger <= except_trigger | out_inf_trigger | NaN_input; // @[dut.scala 220:20]
    end
    if (reset) begin // @[dut.scala 80:37]
      NaN_out_trigger <= 1'h0; // @[dut.scala 80:37]
    end else if (reset) begin // @[dut.scala 101:23]
      NaN_out_trigger <= 1'h0; // @[dut.scala 150:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      NaN_out_trigger <= NaN_input | invalid_trigger; // @[dut.scala 221:21]
    end
    if (reset) begin // @[dut.scala 81:37]
      SNaN_trigger <= 1'h0; // @[dut.scala 81:37]
    end else if (reset) begin // @[dut.scala 101:23]
      SNaN_trigger <= 1'h0; // @[dut.scala 151:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      SNaN_trigger <= invalid_trigger & ~SNaN_input; // @[dut.scala 222:18]
    end
    if (reset) begin // @[dut.scala 82:37]
      NaN_output_0 <= 63'h0; // @[dut.scala 82:37]
    end else if (reset) begin // @[dut.scala 101:23]
      NaN_output_0 <= 63'h0; // @[dut.scala 152:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (a_NaN) begin // @[dut.scala 224:24]
        NaN_output_0 <= _NaN_output_0_T_1;
      end else begin
        NaN_output_0 <= _NaN_output_0_T_3;
      end
    end
    if (reset) begin // @[dut.scala 83:37]
      NaN_output <= 63'h0; // @[dut.scala 83:37]
    end else if (reset) begin // @[dut.scala 101:23]
      NaN_output <= 63'h0; // @[dut.scala 153:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (SNaN_trigger) begin // @[dut.scala 225:22]
        NaN_output <= _NaN_output_T_1;
      end else begin
        NaN_output <= NaN_output_0;
      end
    end
    if (reset) begin // @[dut.scala 84:37]
      inf_round_down <= 63'h0; // @[dut.scala 84:37]
    end else if (reset) begin // @[dut.scala 101:23]
      inf_round_down <= 63'h0; // @[dut.scala 154:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      inf_round_down <= 63'h7fefffffffffffff; // @[dut.scala 226:20]
    end
    if (reset) begin // @[dut.scala 85:37]
      out_inf <= 63'h0; // @[dut.scala 85:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_inf <= 63'h0; // @[dut.scala 155:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (inf_round_down_trigger) begin // @[dut.scala 227:19]
        out_inf <= inf_round_down;
      end else begin
        out_inf <= 63'h7ff0000000000000;
      end
    end
    if (reset) begin // @[dut.scala 86:37]
      out_0 <= 64'h0; // @[dut.scala 86:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_0 <= 64'h0; // @[dut.scala 156:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (underflow_trigger) begin // @[dut.scala 229:17]
        out_0 <= _out_0_T_1;
      end else begin
        out_0 <= io_in_except;
      end
    end
    if (reset) begin // @[dut.scala 87:37]
      out_1 <= 64'h0; // @[dut.scala 87:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_1 <= 64'h0; // @[dut.scala 157:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (out_inf_trigger) begin // @[dut.scala 230:17]
        out_1 <= _out_1_T_1;
      end else begin
        out_1 <= out_0;
      end
    end
    if (reset) begin // @[dut.scala 88:37]
      out_2 <= 64'h0; // @[dut.scala 88:37]
    end else if (reset) begin // @[dut.scala 101:23]
      out_2 <= 64'h0; // @[dut.scala 158:26]
    end else if (io_enable) begin // @[dut.scala 159:27]
      if (NaN_out_trigger) begin // @[dut.scala 231:17]
        out_2 <= _out_2_T_1;
      end else begin
        out_2 <= out_1;
      end
    end
    if (reset) begin // @[dut.scala 91:37]
      ref_ex_enable <= 1'h0; // @[dut.scala 91:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_ex_enable <= 1'h0; // @[dut.scala 236:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_ex_enable <= enable_trigger; // @[dut.scala 244:19]
    end
    if (reset) begin // @[dut.scala 92:37]
      ref_underflow <= 1'h0; // @[dut.scala 92:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_underflow <= 1'h0; // @[dut.scala 237:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_underflow <= underflow_trigger; // @[dut.scala 245:19]
    end
    if (reset) begin // @[dut.scala 93:37]
      ref_overflow <= 1'h0; // @[dut.scala 93:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_overflow <= 1'h0; // @[dut.scala 238:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_overflow <= overflow_trigger; // @[dut.scala 246:19]
    end
    if (reset) begin // @[dut.scala 94:37]
      ref_inexact <= 1'h0; // @[dut.scala 94:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_inexact <= 1'h0; // @[dut.scala 239:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_inexact <= inexact_trigger; // @[dut.scala 247:19]
    end
    if (reset) begin // @[dut.scala 95:37]
      ref_exception <= 1'h0; // @[dut.scala 95:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_exception <= 1'h0; // @[dut.scala 240:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_exception <= except_trigger; // @[dut.scala 248:19]
    end
    if (reset) begin // @[dut.scala 96:37]
      ref_invalid <= 1'h0; // @[dut.scala 96:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_invalid <= 1'h0; // @[dut.scala 241:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_invalid <= invalid_trigger; // @[dut.scala 249:19]
    end
    if (reset) begin // @[dut.scala 97:37]
      ref_out <= 64'h0; // @[dut.scala 97:37]
    end else if (reset) begin // @[dut.scala 235:23]
      ref_out <= 64'h0; // @[dut.scala 242:19]
    end else if (io_enable) begin // @[dut.scala 243:27]
      ref_out <= out_2; // @[dut.scala 250:19]
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
  in_et_zero = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  opa_et_zero = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  opb_et_zero = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  add = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  subtract = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  multiply = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  divide = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  opa_QNaN = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  opb_QNaN = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  opa_SNaN = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  opb_SNaN = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  opa_pos_inf = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  opb_pos_inf = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  opa_neg_inf = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  opb_neg_inf = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  opa_inf = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  opb_inf = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  NaN_input = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  SNaN_input = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  a_NaN = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  div_by_0 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  div_0_by_0 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  div_inf_by_inf = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  div_by_inf = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  mul_0_by_inf = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  mul_inf = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  div_inf = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  add_inf = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  sub_inf = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  addsub_inf_invalid = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  addsub_inf = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  out_inf_trigger = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  out_pos_inf = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  out_neg_inf = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  round_to_zero = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  round_to_pos_inf = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  round_to_neg_inf = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  inf_round_down_trigger = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  mul_uf = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  div_uf = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  underflow_trigger = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  invalid_trigger = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  overflow_trigger = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  inexact_trigger = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  except_trigger = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  enable_trigger = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  NaN_out_trigger = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  SNaN_trigger = _RAND_47[0:0];
  _RAND_48 = {2{`RANDOM}};
  NaN_output_0 = _RAND_48[62:0];
  _RAND_49 = {2{`RANDOM}};
  NaN_output = _RAND_49[62:0];
  _RAND_50 = {2{`RANDOM}};
  inf_round_down = _RAND_50[62:0];
  _RAND_51 = {2{`RANDOM}};
  out_inf = _RAND_51[62:0];
  _RAND_52 = {2{`RANDOM}};
  out_0 = _RAND_52[63:0];
  _RAND_53 = {2{`RANDOM}};
  out_1 = _RAND_53[63:0];
  _RAND_54 = {2{`RANDOM}};
  out_2 = _RAND_54[63:0];
  _RAND_55 = {1{`RANDOM}};
  ref_ex_enable = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  ref_underflow = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  ref_overflow = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  ref_inexact = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  ref_exception = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  ref_invalid = _RAND_60[0:0];
  _RAND_61 = {2{`RANDOM}};
  ref_out = _RAND_61[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
