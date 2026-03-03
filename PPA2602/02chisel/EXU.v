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

module CSR(
  input         clock,
  input         reset,
  output [31:0] io_out_bits,
  input         io_in_valid,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  input  [31:0] io_cfIn_inst,
  input  [31:0] io_cfIn_pc,
  output        io_jmp
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mtvec; // @[CSR.scala 183:24]
  reg [31:0] mcause; // @[CSR.scala 184:25]
  reg [31:0] mepc; // @[CSR.scala 186:23]
  reg [31:0] mstatus; // @[CSR.scala 190:26]
  wire  isEcall = io_cfIn_inst == 32'h73; // @[CSR.scala 194:29]
  wire  isMret = io_cfIn_inst == 32'h30200073; // @[CSR.scala 195:29]
  wire  isEbreak = io_cfIn_inst == 32'h100073; // @[CSR.scala 196:30]
  wire [31:0] _csr_T_1 = 32'h305 == io_in_bits_srcb ? mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_3 = 32'h342 == io_in_bits_srcb ? mcause : _csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_5 = 32'h341 == io_in_bits_srcb ? mepc : _csr_T_3; // @[Mux.scala 81:58]
  wire [31:0] csr = 32'h300 == io_in_bits_srcb ? mstatus : _csr_T_5; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T = io_in_bits_srca | csr; // @[CSR.scala 206:33]
  wire [31:0] _csrUpdate_T_1 = ~io_in_bits_srca; // @[CSR.scala 207:26]
  wire [31:0] _csrUpdate_T_2 = _csrUpdate_T_1 & csr; // @[CSR.scala 207:32]
  wire [31:0] _csrUpdate_T_4 = 7'h1 == io_in_bits_fuOpType ? io_in_bits_srca : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T_6 = 7'h2 == io_in_bits_fuOpType ? _csrUpdate_T : _csrUpdate_T_4; // @[Mux.scala 81:58]
  wire [31:0] csrUpdate = 7'h3 == io_in_bits_fuOpType ? _csrUpdate_T_2 : _csrUpdate_T_6; // @[Mux.scala 81:58]
  wire  csrWen = io_in_valid & io_in_bits_fuOpType != 7'h0; // @[CSR.scala 209:24]
  wire [31:0] _io_out_bits_T_2 = isMret ? mepc : csr; // @[Mux.scala 101:16]
  assign io_out_bits = isEcall ? mtvec : _io_out_bits_T_2; // @[Mux.scala 101:16]
  assign io_jmp = io_in_valid & io_in_bits_fuOpType == 7'h0 & ~isEbreak; // @[CSR.scala 230:53]
  always @(posedge clock) begin
    if (reset) begin // @[CSR.scala 183:24]
      mtvec <= 32'h0; // @[CSR.scala 183:24]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h305) begin // @[CSR.scala 211:33]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mtvec <= _csrUpdate_T_2;
        end else begin
          mtvec <= _csrUpdate_T_6;
        end
      end
    end
    if (reset) begin // @[CSR.scala 184:25]
      mcause <= 32'h0; // @[CSR.scala 184:25]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mcause <= 32'hb; // @[CSR.scala 226:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h342) begin // @[CSR.scala 214:34]
        mcause <= csrUpdate; // @[CSR.scala 215:16]
      end
    end
    if (reset) begin // @[CSR.scala 186:23]
      mepc <= 32'h0; // @[CSR.scala 186:23]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[CSR.scala 225:62]
      mepc <= io_cfIn_pc; // @[CSR.scala 227:15]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h341) begin // @[CSR.scala 217:32]
        mepc <= csrUpdate; // @[CSR.scala 218:15]
      end
    end
    if (reset) begin // @[CSR.scala 190:26]
      mstatus <= 32'h1800; // @[CSR.scala 190:26]
    end else if (csrWen) begin // @[CSR.scala 210:28]
      if (io_in_bits_srcb == 32'h300) begin // @[CSR.scala 220:35]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mstatus <= _csrUpdate_T_2;
        end else begin
          mstatus <= _csrUpdate_T_6;
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
  mtvec = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  mcause = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  mstatus = _RAND_3[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule

module ISU(
  input         clock,
  input         reset,
  output        io_from_idu_ready,
  input         io_from_idu_valid,
  input  [31:0] io_from_idu_bits_cf_inst,
  input  [31:0] io_from_idu_bits_cf_pc,
  input  [31:0] io_from_idu_bits_cf_next_pc,
  input         io_from_idu_bits_cf_isBranch,
  input         io_from_idu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_idu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_idu_bits_ctrl_fuType,
  input  [6:0]  io_from_idu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_idu_bits_ctrl_rs1,
  input  [4:0]  io_from_idu_bits_ctrl_rs2,
  input         io_from_idu_bits_ctrl_rfWen,
  input  [4:0]  io_from_idu_bits_ctrl_rd,
  input  [31:0] io_from_idu_bits_data_imm,
  input         io_to_exu_ready,
  output        io_to_exu_valid,
  output [31:0] io_to_exu_bits_cf_inst,
  output [31:0] io_to_exu_bits_cf_pc,
  output [31:0] io_to_exu_bits_cf_next_pc,
  output        io_to_exu_bits_cf_isBranch,
  output        io_to_exu_bits_ctrl_MemWrite,
  output [1:0]  io_to_exu_bits_ctrl_ResSrc,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
  output        io_to_exu_bits_ctrl_rfWen,
  output [4:0]  io_to_exu_bits_ctrl_rd,
  output [31:0] io_to_exu_bits_data_fuSrc1,
  output [31:0] io_to_exu_bits_data_fuSrc2,
  output [31:0] io_to_exu_bits_data_imm,
  output [31:0] io_to_exu_bits_data_rfSrc1,
  output [31:0] io_to_exu_bits_data_rfSrc2,
  input  [4:0]  io_wb_rd,
  input         io_wb_RegWrite,
  input  [31:0] io_from_reg_rfSrc1,
  input  [31:0] io_from_reg_rfSrc2
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] busy_1; // @[ISU.scala 23:23]
  reg [1:0] busy_2; // @[ISU.scala 23:23]
  reg [1:0] busy_3; // @[ISU.scala 23:23]
  reg [1:0] busy_4; // @[ISU.scala 23:23]
  reg [1:0] busy_5; // @[ISU.scala 23:23]
  reg [1:0] busy_6; // @[ISU.scala 23:23]
  reg [1:0] busy_7; // @[ISU.scala 23:23]
  reg [1:0] busy_8; // @[ISU.scala 23:23]
  reg [1:0] busy_9; // @[ISU.scala 23:23]
  reg [1:0] busy_10; // @[ISU.scala 23:23]
  reg [1:0] busy_11; // @[ISU.scala 23:23]
  reg [1:0] busy_12; // @[ISU.scala 23:23]
  reg [1:0] busy_13; // @[ISU.scala 23:23]
  reg [1:0] busy_14; // @[ISU.scala 23:23]
  reg [1:0] busy_15; // @[ISU.scala 23:23]
  wire [1:0] _GEN_1 = 4'h1 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_2 = 4'h2 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_2 : _GEN_1; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_3 = 4'h3 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_3 : _GEN_2; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_4 = 4'h4 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_4 : _GEN_3; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_5 = 4'h5 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_5 : _GEN_4; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_6 = 4'h6 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_6 : _GEN_5; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_7 = 4'h7 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_7 : _GEN_6; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_8 = 4'h8 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_8 : _GEN_7; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_9 = 4'h9 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_9 : _GEN_8; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_10 = 4'ha == io_from_idu_bits_ctrl_rs1[3:0] ? busy_10 : _GEN_9; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_11 = 4'hb == io_from_idu_bits_ctrl_rs1[3:0] ? busy_11 : _GEN_10; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_12 = 4'hc == io_from_idu_bits_ctrl_rs1[3:0] ? busy_12 : _GEN_11; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_13 = 4'hd == io_from_idu_bits_ctrl_rs1[3:0] ? busy_13 : _GEN_12; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_14 = 4'he == io_from_idu_bits_ctrl_rs1[3:0] ? busy_14 : _GEN_13; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_15 = 4'hf == io_from_idu_bits_ctrl_rs1[3:0] ? busy_15 : _GEN_14; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_1 = _GEN_15 != 2'h0; // @[ISU.scala 24:47]
  wire [1:0] _GEN_17 = 4'h1 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_1 : 2'h0; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_18 = 4'h2 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_2 : _GEN_17; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_19 = 4'h3 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_3 : _GEN_18; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_20 = 4'h4 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_4 : _GEN_19; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_21 = 4'h5 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_5 : _GEN_20; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_22 = 4'h6 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_6 : _GEN_21; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_23 = 4'h7 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_7 : _GEN_22; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_24 = 4'h8 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_8 : _GEN_23; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_25 = 4'h9 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_9 : _GEN_24; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_26 = 4'ha == io_from_idu_bits_ctrl_rs2[3:0] ? busy_10 : _GEN_25; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_27 = 4'hb == io_from_idu_bits_ctrl_rs2[3:0] ? busy_11 : _GEN_26; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_28 = 4'hc == io_from_idu_bits_ctrl_rs2[3:0] ? busy_12 : _GEN_27; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_29 = 4'hd == io_from_idu_bits_ctrl_rs2[3:0] ? busy_13 : _GEN_28; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_30 = 4'he == io_from_idu_bits_ctrl_rs2[3:0] ? busy_14 : _GEN_29; // @[ISU.scala 24:{47,47}]
  wire [1:0] _GEN_31 = 4'hf == io_from_idu_bits_ctrl_rs2[3:0] ? busy_15 : _GEN_30; // @[ISU.scala 24:{47,47}]
  wire  _AnyInvalidCondition_T_3 = _GEN_31 != 2'h0; // @[ISU.scala 24:47]
  wire  AnyInvalidCondition = _AnyInvalidCondition_T_1 | _AnyInvalidCondition_T_3; // @[ISU.scala 138:66]
  wire  _io_from_idu_ready_T_1 = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _fuSrc1_T_1 = 3'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_reg_rfSrc1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc1_T_3 = 3'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc : _fuSrc1_T_1; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_1 = 3'h1 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_reg_rfSrc2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _fuSrc2_T_3 = 3'h3 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm : _fuSrc2_T_1; // @[Mux.scala 81:58]
  wire [46:0] _isFireSetMask_T_2 = 47'h1 << io_from_idu_bits_ctrl_rd; // @[ISU.scala 25:50]
  wire [15:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _io_from_idu_ready_T_1 ? _isFireSetMask_T_2[15:0] : 16'h0; // @[ISU.scala 159:26]
  wire [46:0] _wbuClearMask_T = 47'h1 << io_wb_rd; // @[ISU.scala 25:50]
  wire [15:0] wbuClearMask = io_wb_RegWrite ? _wbuClearMask_T[15:0] : 16'h0; // @[ISU.scala 160:25]
  wire [1:0] _busy_1_T_2 = busy_1 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_1_T_6 = busy_1 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_1_T_7 = busy_1 == 2'h0 ? 2'h0 : _busy_1_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_2_T_2 = busy_2 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_2_T_6 = busy_2 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_2_T_7 = busy_2 == 2'h0 ? 2'h0 : _busy_2_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_3_T_2 = busy_3 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_3_T_6 = busy_3 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_3_T_7 = busy_3 == 2'h0 ? 2'h0 : _busy_3_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_4_T_2 = busy_4 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_4_T_6 = busy_4 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_4_T_7 = busy_4 == 2'h0 ? 2'h0 : _busy_4_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_5_T_2 = busy_5 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_5_T_6 = busy_5 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_5_T_7 = busy_5 == 2'h0 ? 2'h0 : _busy_5_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_6_T_2 = busy_6 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_6_T_6 = busy_6 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_6_T_7 = busy_6 == 2'h0 ? 2'h0 : _busy_6_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_7_T_2 = busy_7 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_7_T_6 = busy_7 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_7_T_7 = busy_7 == 2'h0 ? 2'h0 : _busy_7_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_8_T_2 = busy_8 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_8_T_6 = busy_8 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_8_T_7 = busy_8 == 2'h0 ? 2'h0 : _busy_8_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_9_T_2 = busy_9 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_9_T_6 = busy_9 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_9_T_7 = busy_9 == 2'h0 ? 2'h0 : _busy_9_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_10_T_2 = busy_10 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_10_T_6 = busy_10 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_10_T_7 = busy_10 == 2'h0 ? 2'h0 : _busy_10_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_11_T_2 = busy_11 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_11_T_6 = busy_11 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_11_T_7 = busy_11 == 2'h0 ? 2'h0 : _busy_11_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_12_T_2 = busy_12 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_12_T_6 = busy_12 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_12_T_7 = busy_12 == 2'h0 ? 2'h0 : _busy_12_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_13_T_2 = busy_13 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_13_T_6 = busy_13 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_13_T_7 = busy_13 == 2'h0 ? 2'h0 : _busy_13_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_14_T_2 = busy_14 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_14_T_6 = busy_14 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_14_T_7 = busy_14 == 2'h0 ? 2'h0 : _busy_14_T_6; // @[ISU.scala 34:33]
  wire [1:0] _busy_15_T_2 = busy_15 + 2'h1; // @[ISU.scala 32:82]
  wire [1:0] _busy_15_T_6 = busy_15 - 2'h1; // @[ISU.scala 34:68]
  wire [1:0] _busy_15_T_7 = busy_15 == 2'h0 ? 2'h0 : _busy_15_T_6; // @[ISU.scala 34:33]
  assign io_from_idu_ready = ~io_from_idu_valid | _io_from_idu_ready_T_1; // @[RVCore.scala 66:56]
  assign io_to_exu_valid = io_from_idu_valid & ~AnyInvalidCondition; // @[RVCore.scala 67:40]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[ISU.scala 153:18]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_fuSrc1 = 3'h4 == io_from_idu_bits_ctrl_fuSrc1Type ? 32'h0 : _fuSrc1_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 3'h5 == io_from_idu_bits_ctrl_fuSrc2Type ? 32'h4 : _fuSrc2_T_3; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[ISU.scala 153:18]
  assign io_to_exu_bits_data_rfSrc1 = io_from_reg_rfSrc1; // @[ISU.scala 156:30]
  assign io_to_exu_bits_data_rfSrc2 = io_from_reg_rfSrc2; // @[ISU.scala 157:30]
  always @(posedge clock) begin
    if (reset) begin // @[ISU.scala 23:23]
      busy_1 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[1] & wbuClearMask[1])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[1]) begin // @[ISU.scala 31:38]
        if (busy_1 == 2'h3) begin // @[ISU.scala 32:33]
          busy_1 <= 2'h3;
        end else begin
          busy_1 <= _busy_1_T_2;
        end
      end else if (wbuClearMask[1]) begin // @[ISU.scala 33:40]
        busy_1 <= _busy_1_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_2 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[2] & wbuClearMask[2])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[2]) begin // @[ISU.scala 31:38]
        if (busy_2 == 2'h3) begin // @[ISU.scala 32:33]
          busy_2 <= 2'h3;
        end else begin
          busy_2 <= _busy_2_T_2;
        end
      end else if (wbuClearMask[2]) begin // @[ISU.scala 33:40]
        busy_2 <= _busy_2_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_3 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[3] & wbuClearMask[3])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[3]) begin // @[ISU.scala 31:38]
        if (busy_3 == 2'h3) begin // @[ISU.scala 32:33]
          busy_3 <= 2'h3;
        end else begin
          busy_3 <= _busy_3_T_2;
        end
      end else if (wbuClearMask[3]) begin // @[ISU.scala 33:40]
        busy_3 <= _busy_3_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_4 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[4] & wbuClearMask[4])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[4]) begin // @[ISU.scala 31:38]
        if (busy_4 == 2'h3) begin // @[ISU.scala 32:33]
          busy_4 <= 2'h3;
        end else begin
          busy_4 <= _busy_4_T_2;
        end
      end else if (wbuClearMask[4]) begin // @[ISU.scala 33:40]
        busy_4 <= _busy_4_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_5 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[5] & wbuClearMask[5])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[5]) begin // @[ISU.scala 31:38]
        if (busy_5 == 2'h3) begin // @[ISU.scala 32:33]
          busy_5 <= 2'h3;
        end else begin
          busy_5 <= _busy_5_T_2;
        end
      end else if (wbuClearMask[5]) begin // @[ISU.scala 33:40]
        busy_5 <= _busy_5_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_6 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[6] & wbuClearMask[6])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[6]) begin // @[ISU.scala 31:38]
        if (busy_6 == 2'h3) begin // @[ISU.scala 32:33]
          busy_6 <= 2'h3;
        end else begin
          busy_6 <= _busy_6_T_2;
        end
      end else if (wbuClearMask[6]) begin // @[ISU.scala 33:40]
        busy_6 <= _busy_6_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_7 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[7] & wbuClearMask[7])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[7]) begin // @[ISU.scala 31:38]
        if (busy_7 == 2'h3) begin // @[ISU.scala 32:33]
          busy_7 <= 2'h3;
        end else begin
          busy_7 <= _busy_7_T_2;
        end
      end else if (wbuClearMask[7]) begin // @[ISU.scala 33:40]
        busy_7 <= _busy_7_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_8 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[8] & wbuClearMask[8])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[8]) begin // @[ISU.scala 31:38]
        if (busy_8 == 2'h3) begin // @[ISU.scala 32:33]
          busy_8 <= 2'h3;
        end else begin
          busy_8 <= _busy_8_T_2;
        end
      end else if (wbuClearMask[8]) begin // @[ISU.scala 33:40]
        busy_8 <= _busy_8_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_9 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[9] & wbuClearMask[9])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[9]) begin // @[ISU.scala 31:38]
        if (busy_9 == 2'h3) begin // @[ISU.scala 32:33]
          busy_9 <= 2'h3;
        end else begin
          busy_9 <= _busy_9_T_2;
        end
      end else if (wbuClearMask[9]) begin // @[ISU.scala 33:40]
        busy_9 <= _busy_9_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_10 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[10] & wbuClearMask[10])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[10]) begin // @[ISU.scala 31:38]
        if (busy_10 == 2'h3) begin // @[ISU.scala 32:33]
          busy_10 <= 2'h3;
        end else begin
          busy_10 <= _busy_10_T_2;
        end
      end else if (wbuClearMask[10]) begin // @[ISU.scala 33:40]
        busy_10 <= _busy_10_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_11 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[11] & wbuClearMask[11])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[11]) begin // @[ISU.scala 31:38]
        if (busy_11 == 2'h3) begin // @[ISU.scala 32:33]
          busy_11 <= 2'h3;
        end else begin
          busy_11 <= _busy_11_T_2;
        end
      end else if (wbuClearMask[11]) begin // @[ISU.scala 33:40]
        busy_11 <= _busy_11_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_12 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[12] & wbuClearMask[12])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[12]) begin // @[ISU.scala 31:38]
        if (busy_12 == 2'h3) begin // @[ISU.scala 32:33]
          busy_12 <= 2'h3;
        end else begin
          busy_12 <= _busy_12_T_2;
        end
      end else if (wbuClearMask[12]) begin // @[ISU.scala 33:40]
        busy_12 <= _busy_12_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_13 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[13] & wbuClearMask[13])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[13]) begin // @[ISU.scala 31:38]
        if (busy_13 == 2'h3) begin // @[ISU.scala 32:33]
          busy_13 <= 2'h3;
        end else begin
          busy_13 <= _busy_13_T_2;
        end
      end else if (wbuClearMask[13]) begin // @[ISU.scala 33:40]
        busy_13 <= _busy_13_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_14 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[14] & wbuClearMask[14])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[14]) begin // @[ISU.scala 31:38]
        if (busy_14 == 2'h3) begin // @[ISU.scala 32:33]
          busy_14 <= 2'h3;
        end else begin
          busy_14 <= _busy_14_T_2;
        end
      end else if (wbuClearMask[14]) begin // @[ISU.scala 33:40]
        busy_14 <= _busy_14_T_7; // @[ISU.scala 34:27]
      end
    end
    if (reset) begin // @[ISU.scala 23:23]
      busy_15 <= 2'h0; // @[ISU.scala 23:23]
    end else if (!(isFireSetMask[15] & wbuClearMask[15])) begin // @[ISU.scala 29:50]
      if (isFireSetMask[15]) begin // @[ISU.scala 31:38]
        if (busy_15 == 2'h3) begin // @[ISU.scala 32:33]
          busy_15 <= 2'h3;
        end else begin
          busy_15 <= _busy_15_T_2;
        end
      end else if (wbuClearMask[15]) begin // @[ISU.scala 33:40]
        busy_15 <= _busy_15_T_7; // @[ISU.scala 34:27]
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
  busy_1 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  busy_2 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  busy_3 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  busy_4 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  busy_5 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  busy_6 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  busy_7 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  busy_8 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  busy_9 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  busy_10 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  busy_11 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  busy_12 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  busy_13 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  busy_14 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  busy_15 = _RAND_14[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule


module EXU(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [31:0] io_from_isu_bits_cf_pc,
  input  [31:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [1:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_isu_bits_ctrl_fuType,
  input  [6:0]  io_from_isu_bits_ctrl_fuOpType,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [31:0] io_from_isu_bits_data_fuSrc1,
  input  [31:0] io_from_isu_bits_data_fuSrc2,
  input  [31:0] io_from_isu_bits_data_imm,
  input  [31:0] io_from_isu_bits_data_rfSrc1,
  input  [31:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [31:0] io_to_wbu_bits_cf_pc,
  output [31:0] io_to_wbu_bits_cf_next_pc,
  output [1:0]  io_to_wbu_bits_ctrl_ResSrc,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [31:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [31:0] io_to_wbu_bits_data_data_from_mem,
  output [31:0] io_to_wbu_bits_data_csrRdata,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  output [31:0] io_redirect_target,
  output        io_redirect_valid
);
  wire [31:0] alu0_io_out_bits; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srca; // @[EXU.scala 402:20]
  wire [31:0] alu0_io_in_bits_srcb; // @[EXU.scala 402:20]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[EXU.scala 402:20]
  wire  alu0_io_taken; // @[EXU.scala 402:20]
  wire [31:0] lsu0_io_out_bits; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srca; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_in_bits_srcb; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_data; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_to_mem_addr; // @[EXU.scala 403:20]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[EXU.scala 403:20]
  wire  lsu0_io_to_mem_MemWrite; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_from_mem_data; // @[EXU.scala 403:20]
  wire  lsu0_io_ctrl_MemWrite; // @[EXU.scala 403:20]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[EXU.scala 403:20]
  wire [31:0] lsu0_io_data_rfSrc2; // @[EXU.scala 403:20]
  wire  csr0_clock; // @[EXU.scala 404:20]
  wire  csr0_reset; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_out_bits; // @[EXU.scala 404:20]
  wire  csr0_io_in_valid; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srca; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_in_bits_srcb; // @[EXU.scala 404:20]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_inst; // @[EXU.scala 404:20]
  wire [31:0] csr0_io_cfIn_pc; // @[EXU.scala 404:20]
  wire  csr0_io_jmp; // @[EXU.scala 404:20]
  wire  bruRes_jalrBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[BruRes.scala 9:48]
  wire [31:0] _bruRes_jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[BruRes.scala 10:52]
  wire [31:0] bruRes_jalrBruRes_targetPc = _bruRes_jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[BruRes.scala 10:71]
  wire  bruRes_typebBruRes_valid = io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[BruRes.scala 13:49]
  wire [31:0] bruRes_pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[BruRes.scala 14:39]
  wire [31:0] _bruRes_typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[BruRes.scala 15:77]
  wire [31:0] bruRes_typebBruRes_targetPc = alu0_io_taken ? bruRes_pcIfBranch : _bruRes_typebBruRes_targetPc_T_1; // @[BruRes.scala 15:36]
  wire  bruRes_csrBruRes_valid = csr0_io_jmp; // @[BruRes.scala 17:29 18:25]
  wire [31:0] bruRes_csrBruRes_targetPc = csr0_io_out_bits; // @[BruRes.scala 17:29 19:28]
  wire [31:0] _bruRes_bruRes_T_targetPc = bruRes_csrBruRes_valid ? bruRes_csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_bruRes_T_1_valid = bruRes_typebBruRes_valid ? bruRes_typebBruRes_valid : bruRes_csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_bruRes_T_1_targetPc = bruRes_typebBruRes_valid ? bruRes_typebBruRes_targetPc :
    _bruRes_bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_bruRes_valid = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_valid : _bruRes_bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_bruRes_targetPc = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc :
    _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[EXU.scala 452:41]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU alu0 ( // @[EXU.scala 402:20]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU lsu0 ( // @[EXU.scala 403:20]
    .io_out_bits(lsu0_io_out_bits),
    .io_in_bits_srca(lsu0_io_in_bits_srca),
    .io_in_bits_srcb(lsu0_io_in_bits_srcb),
    .io_to_mem_data(lsu0_io_to_mem_data),
    .io_to_mem_addr(lsu0_io_to_mem_addr),
    .io_to_mem_Wmask(lsu0_io_to_mem_Wmask),
    .io_to_mem_MemWrite(lsu0_io_to_mem_MemWrite),
    .io_from_mem_data(lsu0_io_from_mem_data),
    .io_ctrl_MemWrite(lsu0_io_ctrl_MemWrite),
    .io_ctrl_fuOpType(lsu0_io_ctrl_fuOpType),
    .io_data_rfSrc2(lsu0_io_data_rfSrc2)
  );
  CSR csr0 ( // @[EXU.scala 404:20]
    .clock(csr0_clock),
    .reset(csr0_reset),
    .io_out_bits(csr0_io_out_bits),
    .io_in_valid(csr0_io_in_valid),
    .io_in_bits_srca(csr0_io_in_bits_srca),
    .io_in_bits_srcb(csr0_io_in_bits_srcb),
    .io_in_bits_fuOpType(csr0_io_in_bits_fuOpType),
    .io_cfIn_inst(csr0_io_cfIn_inst),
    .io_cfIn_pc(csr0_io_cfIn_pc),
    .io_jmp(csr0_io_jmp)
  );
  assign io_from_isu_ready = (~io_from_isu_valid | _io_from_isu_ready_T_1) & ~_T; // @[RVCore.scala 66:74]
  assign io_to_wbu_valid = io_from_isu_valid; // @[RVCore.scala 67:40]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 399:21]
  assign io_to_wbu_bits_cf_next_pc = io_redirect_valid ? bruRes_bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[EXU.scala 445:35]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[EXU.scala 398:23]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[EXU.scala 431:36]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[EXU.scala 432:37]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[EXU.scala 434:32]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[EXU.scala 433:13]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[EXU.scala 433:13]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[EXU.scala 433:13]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[EXU.scala 433:13]
  assign io_redirect_target = bruRes_jalrBruRes_valid ? bruRes_jalrBruRes_targetPc : _bruRes_bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_bruRes_valid & io_from_isu_bits_cf_next_pc !=
    bruRes_bruRes_targetPc; // @[EXU.scala 441:58]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 407:24]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 408:24]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 409:28]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 413:24]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 414:24]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[EXU.scala 418:20]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[EXU.scala 416:16]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 416:16]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[EXU.scala 417:16]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[EXU.scala 427:41]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[EXU.scala 423:24]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[EXU.scala 424:24]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[EXU.scala 425:28]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[EXU.scala 426:16]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[EXU.scala 426:16]
endmodule
