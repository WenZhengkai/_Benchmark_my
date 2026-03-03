module ALU_golden(
  output [31:0] io_out_bits,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  input  [6:0]  io_in_bits_fuOpType,
  output        io_taken
);
  wire  isAdderSub = ~io_in_bits_fuOpType[6]; // @[dut.scala 25:22]
  wire [31:0] _adderRes_T_1 = isAdderSub ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _adderRes_T_2 = io_in_bits_srcb ^ _adderRes_T_1; // @[dut.scala 26:35]
  wire [32:0] _adderRes_T_3 = io_in_bits_srca + _adderRes_T_2; // @[dut.scala 26:26]
  wire [32:0] _GEN_0 = {{32'd0}, isAdderSub}; // @[dut.scala 26:62]
  wire [32:0] adderRes = _adderRes_T_3 + _GEN_0; // @[dut.scala 26:62]
  wire [31:0] xorRes = io_in_bits_srca ^ io_in_bits_srcb; // @[dut.scala 27:23]
  wire  sltu = ~adderRes[32]; // @[dut.scala 28:16]
  wire  slt = xorRes[31] ^ sltu; // @[dut.scala 29:30]
  wire [4:0] shamt = io_in_bits_fuOpType[5] ? io_in_bits_srcb[4:0] : io_in_bits_srcb[4:0]; // @[dut.scala 35:20]
  wire [62:0] _GEN_1 = {{31'd0}, io_in_bits_srca}; // @[dut.scala 37:35]
  wire [62:0] _res_T = _GEN_1 << shamt; // @[dut.scala 37:35]
  wire [31:0] _res_T_2 = {31'h0,slt}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_3 = {31'h0,sltu}; // @[Cat.scala 33:92]
  wire [31:0] _res_T_4 = io_in_bits_srca >> shamt; // @[dut.scala 41:34]
  wire [31:0] _res_T_5 = io_in_bits_srca | io_in_bits_srcb; // @[dut.scala 42:32]
  wire [31:0] _res_T_6 = io_in_bits_srca & io_in_bits_srcb; // @[dut.scala 43:32]
  wire [31:0] _res_T_9 = $signed(io_in_bits_srca) >>> shamt; // @[dut.scala 44:51]
  wire [32:0] _res_T_11 = 7'h1 == io_in_bits_fuOpType ? {{1'd0}, _res_T[31:0]} : adderRes; // @[Mux.scala 81:58]
  wire [32:0] _res_T_13 = 7'h2 == io_in_bits_fuOpType ? {{1'd0}, _res_T_2} : _res_T_11; // @[Mux.scala 81:58]
  wire [32:0] _res_T_15 = 7'h3 == io_in_bits_fuOpType ? {{1'd0}, _res_T_3} : _res_T_13; // @[Mux.scala 81:58]
  wire [32:0] _res_T_17 = 7'h4 == io_in_bits_fuOpType ? {{1'd0}, xorRes} : _res_T_15; // @[Mux.scala 81:58]
  wire [32:0] _res_T_19 = 7'h5 == io_in_bits_fuOpType ? {{1'd0}, _res_T_4} : _res_T_17; // @[Mux.scala 81:58]
  wire [32:0] _res_T_21 = 7'h6 == io_in_bits_fuOpType ? {{1'd0}, _res_T_5} : _res_T_19; // @[Mux.scala 81:58]
  wire [32:0] _res_T_23 = 7'h7 == io_in_bits_fuOpType ? {{1'd0}, _res_T_6} : _res_T_21; // @[Mux.scala 81:58]
  wire [32:0] res = 7'hd == io_in_bits_fuOpType ? {{1'd0}, _res_T_9} : _res_T_23; // @[Mux.scala 81:58]
  wire  aluRes_signBit = res[31]; // @[driver.scala 183:20]
  wire [31:0] _aluRes_T_3 = aluRes_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 77:12]
  wire [63:0] _aluRes_T_4 = {_aluRes_T_3,res[31:0]}; // @[Cat.scala 33:92]
  wire [63:0] aluRes = io_in_bits_fuOpType[5] ? _aluRes_T_4 : {{31'd0}, res}; // @[dut.scala 46:18]
  wire  _T_1 = ~(|xorRes); // @[dut.scala 50:48]
  wire  _io_taken_T_4 = 2'h2 == io_in_bits_fuOpType[2:1] ? slt : 2'h0 == io_in_bits_fuOpType[2:1] & _T_1; // @[Mux.scala 81:58]
  wire  _io_taken_T_6 = 2'h3 == io_in_bits_fuOpType[2:1] ? sltu : _io_taken_T_4; // @[Mux.scala 81:58]
  assign io_out_bits = aluRes[31:0]; // @[dut.scala 22:17]
  assign io_taken = _io_taken_T_6 ^ io_in_bits_fuOpType[0]; // @[dut.scala 54:86]
endmodule
module LSU_golden(
  output [31:0] io_out_bits,
  input  [31:0] io_in_bits_srca,
  input  [31:0] io_in_bits_srcb,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  input         io_ctrl_MemWrite,
  input  [6:0]  io_ctrl_fuOpType,
  input  [31:0] io_data_rfSrc2
);
  wire [1:0] _io_to_mem_Wmask_T_3 = 7'h9 == io_ctrl_fuOpType ? 2'h3 : {{1'd0}, 7'h8 == io_ctrl_fuOpType}; // @[Mux.scala 81:58]
  wire [3:0] _io_to_mem_Wmask_T_5 = 7'ha == io_ctrl_fuOpType ? 4'hf : {{2'd0}, _io_to_mem_Wmask_T_3}; // @[Mux.scala 81:58]
  wire  io_out_bits_signBit = io_from_mem_data[7]; // @[driver.scala 183:20]
  wire [23:0] _io_out_bits_T_2 = io_out_bits_signBit ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_bits_T_3 = {_io_out_bits_T_2,io_from_mem_data[7:0]}; // @[Cat.scala 33:92]
  wire  io_out_bits_signBit_1 = io_from_mem_data[15]; // @[driver.scala 183:20]
  wire [15:0] _io_out_bits_T_6 = io_out_bits_signBit_1 ? 16'hffff : 16'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_bits_T_7 = {_io_out_bits_T_6,io_from_mem_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_11 = {24'h0,io_from_mem_data[7:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_13 = {16'h0,io_from_mem_data[15:0]}; // @[Cat.scala 33:92]
  wire [31:0] _io_out_bits_T_17 = 7'h0 == io_ctrl_fuOpType ? _io_out_bits_T_3 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_19 = 7'h1 == io_ctrl_fuOpType ? _io_out_bits_T_7 : _io_out_bits_T_17; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_21 = 7'h2 == io_ctrl_fuOpType ? io_from_mem_data : _io_out_bits_T_19; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_23 = 7'h4 == io_ctrl_fuOpType ? _io_out_bits_T_11 : _io_out_bits_T_21; // @[Mux.scala 81:58]
  wire [31:0] _io_out_bits_T_25 = 7'h5 == io_ctrl_fuOpType ? _io_out_bits_T_13 : _io_out_bits_T_23; // @[Mux.scala 81:58]
  assign io_out_bits = 7'h6 == io_ctrl_fuOpType ? io_from_mem_data : _io_out_bits_T_25; // @[Mux.scala 81:58]
  assign io_to_mem_data = io_data_rfSrc2; // @[dut.scala 252:20]
  assign io_to_mem_addr = io_in_bits_srca + io_in_bits_srcb; // @[dut.scala 254:39]
  assign io_to_mem_Wmask = 7'hb == io_ctrl_fuOpType ? 8'hff : {{4'd0}, _io_to_mem_Wmask_T_5}; // @[Mux.scala 81:58]
  assign io_to_mem_MemWrite = io_ctrl_MemWrite; // @[dut.scala 262:24]
endmodule
module CSR_golden(
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
  reg [31:0] mtvec; // @[dut.scala 316:24]
  reg [31:0] mcause; // @[dut.scala 317:25]
  reg [31:0] mepc; // @[dut.scala 319:23]
  reg [31:0] mstatus; // @[dut.scala 323:26]
  wire  isEcall = io_cfIn_inst == 32'h73; // @[dut.scala 327:29]
  wire  isMret = io_cfIn_inst == 32'h30200073; // @[dut.scala 328:29]
  wire  isEbreak = io_cfIn_inst == 32'h100073; // @[dut.scala 329:30]
  wire [31:0] _csr_T_1 = 32'h305 == io_in_bits_srcb ? mtvec : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_3 = 32'h342 == io_in_bits_srcb ? mcause : _csr_T_1; // @[Mux.scala 81:58]
  wire [31:0] _csr_T_5 = 32'h341 == io_in_bits_srcb ? mepc : _csr_T_3; // @[Mux.scala 81:58]
  wire [31:0] csr = 32'h300 == io_in_bits_srcb ? mstatus : _csr_T_5; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T = io_in_bits_srca | csr; // @[dut.scala 339:33]
  wire [31:0] _csrUpdate_T_1 = ~io_in_bits_srca; // @[dut.scala 340:26]
  wire [31:0] _csrUpdate_T_2 = _csrUpdate_T_1 & csr; // @[dut.scala 340:32]
  wire [31:0] _csrUpdate_T_4 = 7'h1 == io_in_bits_fuOpType ? io_in_bits_srca : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _csrUpdate_T_6 = 7'h2 == io_in_bits_fuOpType ? _csrUpdate_T : _csrUpdate_T_4; // @[Mux.scala 81:58]
  wire [31:0] csrUpdate = 7'h3 == io_in_bits_fuOpType ? _csrUpdate_T_2 : _csrUpdate_T_6; // @[Mux.scala 81:58]
  wire  csrWen = io_in_valid & io_in_bits_fuOpType != 7'h0; // @[dut.scala 342:24]
  wire [31:0] _io_out_bits_T_2 = isMret ? mepc : csr; // @[Mux.scala 101:16]
  assign io_out_bits = isEcall ? mtvec : _io_out_bits_T_2; // @[Mux.scala 101:16]
  assign io_jmp = io_in_valid & io_in_bits_fuOpType == 7'h0 & ~isEbreak; // @[dut.scala 363:53]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 316:24]
      mtvec <= 32'h0; // @[dut.scala 316:24]
    end else if (csrWen) begin // @[dut.scala 343:28]
      if (io_in_bits_srcb == 32'h305) begin // @[dut.scala 344:33]
        if (7'h3 == io_in_bits_fuOpType) begin // @[Mux.scala 81:58]
          mtvec <= _csrUpdate_T_2;
        end else begin
          mtvec <= _csrUpdate_T_6;
        end
      end
    end
    if (reset) begin // @[dut.scala 317:25]
      mcause <= 32'h0; // @[dut.scala 317:25]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[dut.scala 358:62]
      mcause <= 32'hb; // @[dut.scala 359:15]
    end else if (csrWen) begin // @[dut.scala 343:28]
      if (io_in_bits_srcb == 32'h342) begin // @[dut.scala 347:34]
        mcause <= csrUpdate; // @[dut.scala 348:16]
      end
    end
    if (reset) begin // @[dut.scala 319:23]
      mepc <= 32'h0; // @[dut.scala 319:23]
    end else if (~csrWen & io_in_valid & isEcall) begin // @[dut.scala 358:62]
      mepc <= io_cfIn_pc; // @[dut.scala 360:15]
    end else if (csrWen) begin // @[dut.scala 343:28]
      if (io_in_bits_srcb == 32'h341) begin // @[dut.scala 350:32]
        mepc <= csrUpdate; // @[dut.scala 351:15]
      end
    end
    if (reset) begin // @[dut.scala 323:26]
      mstatus <= 32'h1800; // @[dut.scala 323:26]
    end else if (csrWen) begin // @[dut.scala 343:28]
      if (io_in_bits_srcb == 32'h300) begin // @[dut.scala 353:35]
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
module EXU_golden(
  input         clock,
  input         reset,
  output        io_from_isu_ready,
  input         io_from_isu_valid,
  input  [31:0] io_from_isu_bits_cf_inst,
  input  [31:0] io_from_isu_bits_cf_pc,
  input  [31:0] io_from_isu_bits_cf_next_pc,
  input         io_from_isu_bits_cf_isBranch,
  input         io_from_isu_bits_ctrl_MemWrite,
  input  [2:0]  io_from_isu_bits_ctrl_ResSrc,
  input  [2:0]  io_from_isu_bits_ctrl_fuSrc1Type,
  input  [2:0]  io_from_isu_bits_ctrl_fuSrc2Type,
  input  [2:0]  io_from_isu_bits_ctrl_fuType,
  input  [6:0]  io_from_isu_bits_ctrl_fuOpType,
  input  [4:0]  io_from_isu_bits_ctrl_rs1,
  input  [4:0]  io_from_isu_bits_ctrl_rs2,
  input         io_from_isu_bits_ctrl_rfWen,
  input  [4:0]  io_from_isu_bits_ctrl_rd,
  input  [31:0] io_from_isu_bits_data_fuSrc1,
  input  [31:0] io_from_isu_bits_data_fuSrc2,
  input  [31:0] io_from_isu_bits_data_imm,
  input         io_from_isu_bits_data_Alu0Res_ready,
  input         io_from_isu_bits_data_Alu0Res_valid,
  input  [31:0] io_from_isu_bits_data_Alu0Res_bits,
  input  [31:0] io_from_isu_bits_data_data_from_mem,
  input  [31:0] io_from_isu_bits_data_csrRdata,
  input  [31:0] io_from_isu_bits_data_rfSrc1,
  input  [31:0] io_from_isu_bits_data_rfSrc2,
  input         io_to_wbu_ready,
  output        io_to_wbu_valid,
  output [31:0] io_to_wbu_bits_cf_inst,
  output [31:0] io_to_wbu_bits_cf_pc,
  output [31:0] io_to_wbu_bits_cf_next_pc,
  output        io_to_wbu_bits_cf_isBranch,
  output        io_to_wbu_bits_ctrl_MemWrite,
  output [2:0]  io_to_wbu_bits_ctrl_ResSrc,
  output [2:0]  io_to_wbu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_wbu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_wbu_bits_ctrl_fuType,
  output [6:0]  io_to_wbu_bits_ctrl_fuOpType,
  output [4:0]  io_to_wbu_bits_ctrl_rs1,
  output [4:0]  io_to_wbu_bits_ctrl_rs2,
  output        io_to_wbu_bits_ctrl_rfWen,
  output [4:0]  io_to_wbu_bits_ctrl_rd,
  output [31:0] io_to_wbu_bits_data_fuSrc1,
  output [31:0] io_to_wbu_bits_data_fuSrc2,
  output [31:0] io_to_wbu_bits_data_imm,
  output        io_to_wbu_bits_data_Alu0Res_ready,
  output        io_to_wbu_bits_data_Alu0Res_valid,
  output [31:0] io_to_wbu_bits_data_Alu0Res_bits,
  output [31:0] io_to_wbu_bits_data_data_from_mem,
  output [31:0] io_to_wbu_bits_data_csrRdata,
  output [31:0] io_to_wbu_bits_data_rfSrc1,
  output [31:0] io_to_wbu_bits_data_rfSrc2,
  output [31:0] io_to_mem_data,
  output [31:0] io_to_mem_addr,
  output [7:0]  io_to_mem_Wmask,
  output        io_to_mem_MemWrite,
  input  [31:0] io_from_mem_data,
  output [31:0] io_redirect_target,
  output        io_redirect_valid
);
  wire [31:0] alu0_io_out_bits; // @[dut.scala 115:22]
  wire [31:0] alu0_io_in_bits_srca; // @[dut.scala 115:22]
  wire [31:0] alu0_io_in_bits_srcb; // @[dut.scala 115:22]
  wire [6:0] alu0_io_in_bits_fuOpType; // @[dut.scala 115:22]
  wire  alu0_io_taken; // @[dut.scala 115:22]
  wire [31:0] lsu0_io_out_bits; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_in_bits_srca; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_in_bits_srcb; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_to_mem_data; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_to_mem_addr; // @[dut.scala 124:22]
  wire [7:0] lsu0_io_to_mem_Wmask; // @[dut.scala 124:22]
  wire  lsu0_io_to_mem_MemWrite; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_from_mem_data; // @[dut.scala 124:22]
  wire  lsu0_io_ctrl_MemWrite; // @[dut.scala 124:22]
  wire [6:0] lsu0_io_ctrl_fuOpType; // @[dut.scala 124:22]
  wire [31:0] lsu0_io_data_rfSrc2; // @[dut.scala 124:22]
  wire  csr0_clock; // @[dut.scala 138:22]
  wire  csr0_reset; // @[dut.scala 138:22]
  wire [31:0] csr0_io_out_bits; // @[dut.scala 138:22]
  wire  csr0_io_in_valid; // @[dut.scala 138:22]
  wire [31:0] csr0_io_in_bits_srca; // @[dut.scala 138:22]
  wire [31:0] csr0_io_in_bits_srcb; // @[dut.scala 138:22]
  wire [6:0] csr0_io_in_bits_fuOpType; // @[dut.scala 138:22]
  wire [31:0] csr0_io_cfIn_inst; // @[dut.scala 138:22]
  wire [31:0] csr0_io_cfIn_pc; // @[dut.scala 138:22]
  wire  csr0_io_jmp; // @[dut.scala 138:22]
  wire  _jalrBruRes_valid_T = io_from_isu_valid & io_from_isu_bits_cf_isBranch; // @[dut.scala 162:34]
  wire  jalrBruRes_valid = io_from_isu_valid & io_from_isu_bits_cf_isBranch & io_from_isu_bits_cf_inst[6:0] == 7'h67; // @[dut.scala 162:56]
  wire [31:0] _jalrBruRes_targetPc_T_1 = io_from_isu_bits_data_rfSrc1 + io_from_isu_bits_data_imm; // @[dut.scala 164:48]
  wire [31:0] jalrBruRes_targetPc = _jalrBruRes_targetPc_T_1 & 32'hfffffffe; // @[dut.scala 164:67]
  wire  typebBruRes_valid = _jalrBruRes_valid_T & io_from_isu_bits_cf_inst[6:0] == 7'h63; // @[dut.scala 167:57]
  wire [31:0] pcIfBranch = io_from_isu_bits_cf_pc + io_from_isu_bits_data_imm; // @[dut.scala 168:35]
  wire [31:0] _typebBruRes_targetPc_T_1 = io_from_isu_bits_cf_pc + 32'h4; // @[dut.scala 169:73]
  wire [31:0] typebBruRes_targetPc = alu0_io_taken ? pcIfBranch : _typebBruRes_targetPc_T_1; // @[dut.scala 169:32]
  wire  csrBruRes_valid = io_from_isu_valid & csr0_io_jmp; // @[dut.scala 172:33]
  wire [31:0] csrBruRes_targetPc = csr0_io_out_bits; // @[dut.scala 171:25 173:24]
  wire [31:0] _bruRes_T_targetPc = csrBruRes_valid ? csrBruRes_targetPc : 32'h0; // @[Mux.scala 101:16]
  wire  _bruRes_T_1_valid = typebBruRes_valid ? typebBruRes_valid : csrBruRes_valid; // @[Mux.scala 101:16]
  wire [31:0] _bruRes_T_1_targetPc = typebBruRes_valid ? typebBruRes_targetPc : _bruRes_T_targetPc; // @[Mux.scala 101:16]
  wire  bruRes_valid = jalrBruRes_valid ? jalrBruRes_valid : _bruRes_T_1_valid; // @[Mux.scala 101:16]
  wire [31:0] bruRes_targetPc = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  wire  PredictError = bruRes_targetPc != io_from_isu_bits_cf_next_pc; // @[dut.scala 187:40]
  wire  _T = io_redirect_valid & io_from_isu_valid; // @[dut.scala 207:48]
  wire  _io_from_isu_ready_T_1 = io_to_wbu_ready & io_to_wbu_valid; // @[Decoupled.scala 51:35]
  ALU_golden alu0 ( // @[dut.scala 115:22]
    .io_out_bits(alu0_io_out_bits),
    .io_in_bits_srca(alu0_io_in_bits_srca),
    .io_in_bits_srcb(alu0_io_in_bits_srcb),
    .io_in_bits_fuOpType(alu0_io_in_bits_fuOpType),
    .io_taken(alu0_io_taken)
  );
  LSU_golden lsu0 ( // @[dut.scala 124:22]
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
  CSR_golden csr0 ( // @[dut.scala 138:22]
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
  assign io_from_isu_ready = (~io_from_isu_valid | _io_from_isu_ready_T_1) & ~_T; // @[driver.scala 70:74]
  assign io_to_wbu_valid = io_from_isu_valid; // @[driver.scala 71:40]
  assign io_to_wbu_bits_cf_inst = io_from_isu_bits_cf_inst; // @[dut.scala 104:17]
  assign io_to_wbu_bits_cf_pc = io_from_isu_bits_cf_pc; // @[dut.scala 104:17]
  assign io_to_wbu_bits_cf_next_pc = bruRes_valid ? bruRes_targetPc : io_from_isu_bits_cf_next_pc; // @[dut.scala 191:31]
  assign io_to_wbu_bits_cf_isBranch = io_from_isu_bits_cf_isBranch; // @[dut.scala 104:17]
  assign io_to_wbu_bits_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_ResSrc = io_from_isu_bits_ctrl_ResSrc; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_fuSrc1Type = io_from_isu_bits_ctrl_fuSrc1Type; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_fuSrc2Type = io_from_isu_bits_ctrl_fuSrc2Type; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_fuType = io_from_isu_bits_ctrl_fuType; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_rs1 = io_from_isu_bits_ctrl_rs1; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_rs2 = io_from_isu_bits_ctrl_rs2; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_rfWen = io_from_isu_bits_ctrl_rfWen; // @[dut.scala 105:19]
  assign io_to_wbu_bits_ctrl_rd = io_from_isu_bits_ctrl_rd; // @[dut.scala 105:19]
  assign io_to_wbu_bits_data_fuSrc1 = io_from_isu_bits_data_fuSrc1; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_fuSrc2 = io_from_isu_bits_data_fuSrc2; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_imm = io_from_isu_bits_data_imm; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_Alu0Res_ready = io_from_isu_bits_data_Alu0Res_ready; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_Alu0Res_valid = io_from_isu_bits_data_Alu0Res_valid; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_Alu0Res_bits = alu0_io_out_bits; // @[dut.scala 201:32]
  assign io_to_wbu_bits_data_data_from_mem = lsu0_io_out_bits; // @[dut.scala 135:33]
  assign io_to_wbu_bits_data_csrRdata = csr0_io_out_bits; // @[dut.scala 146:28]
  assign io_to_wbu_bits_data_rfSrc1 = io_from_isu_bits_data_rfSrc1; // @[dut.scala 106:19]
  assign io_to_wbu_bits_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 106:19]
  assign io_to_mem_data = lsu0_io_to_mem_data; // @[dut.scala 130:15]
  assign io_to_mem_addr = lsu0_io_to_mem_addr; // @[dut.scala 130:15]
  assign io_to_mem_Wmask = lsu0_io_to_mem_Wmask; // @[dut.scala 130:15]
  assign io_to_mem_MemWrite = lsu0_io_to_mem_MemWrite; // @[dut.scala 130:15]
  assign io_redirect_target = jalrBruRes_valid ? jalrBruRes_targetPc : _bruRes_T_1_targetPc; // @[Mux.scala 101:16]
  assign io_redirect_valid = io_from_isu_valid & bruRes_valid & PredictError; // @[dut.scala 188:51]
  assign alu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 117:21]
  assign alu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 118:21]
  assign alu0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 119:25]
  assign lsu0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 125:26]
  assign lsu0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 126:26]
  assign lsu0_io_from_mem_data = io_from_mem_data; // @[dut.scala 129:22]
  assign lsu0_io_ctrl_MemWrite = io_from_isu_bits_ctrl_MemWrite; // @[dut.scala 132:18]
  assign lsu0_io_ctrl_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 132:18]
  assign lsu0_io_data_rfSrc2 = io_from_isu_bits_data_rfSrc2; // @[dut.scala 133:18]
  assign csr0_clock = clock;
  assign csr0_reset = reset;
  assign csr0_io_in_valid = io_from_isu_valid & io_from_isu_bits_ctrl_fuType == 3'h3; // @[dut.scala 141:16]
  assign csr0_io_in_bits_srca = io_from_isu_bits_data_fuSrc1; // @[dut.scala 305:15]
  assign csr0_io_in_bits_srcb = io_from_isu_bits_data_fuSrc2; // @[dut.scala 306:15]
  assign csr0_io_in_bits_fuOpType = io_from_isu_bits_ctrl_fuOpType; // @[dut.scala 307:19]
  assign csr0_io_cfIn_inst = io_from_isu_bits_cf_inst; // @[dut.scala 139:15]
  assign csr0_io_cfIn_pc = io_from_isu_bits_cf_pc; // @[dut.scala 139:15]
endmodule
