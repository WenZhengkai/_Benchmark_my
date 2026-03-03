module ALU(
  output [31:0] io_out_bits,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  output        io_taken
);
  wire  isAdderSub = ~io_in_bits_fuOpType[6]; // @[EXU.scala 93:22]
  wire [31:0] _adderRes_T_1 = isAdderSub ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _adderRes_T_2 = io_in_bits_srcb ^ _adderRes_T_1; // @[EXU.scala 94:35]
  wire [32:0] _adderRes_T_3 = io_in_bits_srca + _adderRes_T_2; // @[EXU.scala 94:26]
  wire [32:0] _GEN_0 = {{32'd0}, isAdderSub}; // @[EXU.scala 94:62]
  wire [32:0] adderRes = _adderRes_T_3 + _GEN_0; // @[EXU.scala 94:62]
  wire [31:0] xorRes = io_in_bits_srca ^ io_in_bits_srcb; // @[EXU.scala 95:23]
  wire  sltu = ~adderRes[32]; // @[EXU.scala 96:16]
  wire  slt = xorRes[31] ^ sltu; // @[EXU.scala 97:30]
  wire [4:0] shamt = io_in_bits_fuOpType[5] ? io_in_bits_srcb[4:0] : io_in_bits_srcb[4:0]; // @[EXU.scala 103:20]
  wire [62:0] _GEN_1 = {{31'd0}, io_in_bits_srca}; // @[EXU.scala 105:35]
  wire [62:0] _res_T = _GEN_1 << shamt; // @[EXU.scala 105:35]
  wire [31:0] _res_T_2 = {31'h0,slt}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_3 = {31'h0,sltu}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_4 = io_in_bits_srca >> shamt; // @[EXU.scala 109:34]
  wire [31:0] _res_T_5 = io_in_bits_srca | io_in_bits_srcb; // @[EXU.scala 110:32]
  wire [31:0] _res_T_6 = io_in_bits_srca & io_in_bits_srcb; // @[EXU.scala 111:32]
  wire [31:0] _res_T_9 = $signed(io_in_bits_srca) >>> shamt; // @[EXU.scala 112:51]
  wire [32:0] _res_T_11 = 7'h1 == io_in_bits_fuOpType ? {{1'd0}, _res_T[31:0]} : adderRes; // @[Mux.scala 81:58]
  wire [32:0] _res_T_13 = 7'h2 == io_in_bits_fuOpType ? {{1'd0}, _res_T_2} : _res_T_11; // @[Mux.scala 81:58]
  wire [32:0] _res_T_15 = 7'h3 == io_in_bits_fuOpType ? {{1'd0}, _res_T_3} : _res_T_13; // @[Mux.scala 81:58]
  wire [32:0] _res_T_17 = 7'h4 == io_in_bits_fuOpType ? {{1'd0}, xorRes} : _res_T_15; // @[Mux.scala 81:58]
  wire [32:0] _res_T_19 = 7'h5 == io_in_bits_fuOpType ? {{1'd0}, _res_T_4} : _res_T_17; // @[Mux.scala 81:58]
  wire [32:0] _res_T_21 = 7'h6 == io_in_bits_fuOpType ? {{1'd0}, _res_T_5} : _res_T_19; // @[Mux.scala 81:58]
  wire [32:0] _res_T_23 = 7'h7 == io_in_bits_fuOpType ? {{1'd0}, _res_T_6} : _res_T_21; // @[Mux.scala 81:58]
  wire [32:0] res = 7'hd == io_in_bits_fuOpType ? {{1'd0}, _res_T_9} : _res_T_23; // @[Mux.scala 81:58]
  wire  aluRes_signBit = res[31]; // @[EXU.scala 8:20]
  wire [31:0] _aluRes_T_3 = aluRes_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _aluRes_T_4 = {_aluRes_T_3,res[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] aluRes = io_in_bits_fuOpType[5] ? _aluRes_T_4 : {{31'd0}, res}; // @[EXU.scala 114:18]
  wire  _T_1 = ~(|xorRes); // @[EXU.scala 118:48]
  wire  _io_taken_T_4 = 2'h2 == io_in_bits_fuOpType[2:1] ? slt : 2'h0 == io_in_bits_fuOpType[2:1] & _T_1; // @[Mux.scala 81:58]
  wire  _io_taken_T_6 = 2'h3 == io_in_bits_fuOpType[2:1] ? sltu : _io_taken_T_4; // @[Mux.scala 81:58]
  assign io_out_bits = aluRes[31:0]; // @[EXU.scala 90:17]
  assign io_taken = _io_taken_T_6 ^ io_in_bits_fuOpType[0]; // @[EXU.scala 122:86]
endmodule
