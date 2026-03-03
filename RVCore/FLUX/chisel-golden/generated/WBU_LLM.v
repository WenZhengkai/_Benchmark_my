module WBU_LLM(
  output        io_from_exu_ready,
  input         io_from_exu_valid,
  input  [31:0] io_from_exu_bits_cf_inst,
  input  [31:0] io_from_exu_bits_cf_pc,
  input  [31:0] io_from_exu_bits_cf_next_pc,
  input  [1:0]  io_from_exu_bits_ctrl_ResSrc,
  input         io_from_exu_bits_ctrl_rfWen,
  input  [4:0]  io_from_exu_bits_ctrl_rd,
  input  [31:0] io_from_exu_bits_data_Alu0Res_bits,
  input  [31:0] io_from_exu_bits_data_data_from_mem,
  input  [31:0] io_from_exu_bits_data_csrRdata,
  output        io_to_reg_valid,
  output [4:0]  io_to_reg_bits_rd,
  output [31:0] io_to_reg_bits_Res,
  output        io_to_reg_bits_RegWrite,
  output [31:0] io_to_commit_inst,
  output [31:0] io_to_commit_pc,
  output [31:0] io_to_commit_next_pc
);
  wire [31:0] _writeBackData_T_3 = io_from_exu_bits_ctrl_ResSrc == 2'h2 ? io_from_exu_bits_data_csrRdata : 32'h0; // @[WBU.scala 69:23]
  wire [31:0] _writeBackData_T_4 = io_from_exu_bits_ctrl_ResSrc == 2'h1 ? io_from_exu_bits_data_data_from_mem :
    _writeBackData_T_3; // @[WBU.scala 68:23]
  assign io_from_exu_ready = ~io_from_exu_valid | io_to_reg_valid; // @[RVCore.scala 66:56]
  assign io_to_reg_valid = io_from_exu_valid; // @[RVCore.scala 67:40]
  assign io_to_reg_bits_rd = io_from_exu_bits_ctrl_rd; // @[WBU.scala 74:21]
  assign io_to_reg_bits_Res = io_from_exu_bits_ctrl_ResSrc == 2'h0 ? io_from_exu_bits_data_Alu0Res_bits :
    _writeBackData_T_4; // @[WBU.scala 67:23]
  assign io_to_reg_bits_RegWrite = io_from_exu_bits_ctrl_rfWen & io_to_reg_valid; // @[WBU.scala 76:58]
  assign io_to_commit_inst = io_from_exu_bits_cf_inst; // @[WBU.scala 78:16]
  assign io_to_commit_pc = io_from_exu_bits_cf_pc; // @[WBU.scala 78:16]
  assign io_to_commit_next_pc = io_from_exu_bits_cf_next_pc; // @[WBU.scala 78:16]
endmodule
