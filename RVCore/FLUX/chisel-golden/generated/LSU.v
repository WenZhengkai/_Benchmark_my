module LSU(
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
  wire  io_out_bits_signBit = io_from_mem_data[7]; // @[EXU.scala 8:20]
  wire [23:0] _io_out_bits_T_2 = io_out_bits_signBit ? 24'hffffff : 24'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _io_out_bits_T_3 = {_io_out_bits_T_2,io_from_mem_data[7:0]}; // @[Cat.scala 33:92]
  wire  io_out_bits_signBit_1 = io_from_mem_data[15]; // @[EXU.scala 8:20]
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
  assign io_to_mem_data = io_data_rfSrc2; // @[LSU.scala 81:20]
  assign io_to_mem_addr = io_in_bits_srca + io_in_bits_srcb; // @[LSU.scala 83:39]
  assign io_to_mem_Wmask = 7'hb == io_ctrl_fuOpType ? 8'hff : {{4'd0}, _io_to_mem_Wmask_T_5}; // @[Mux.scala 81:58]
  assign io_to_mem_MemWrite = io_ctrl_MemWrite; // @[LSU.scala 91:24]
endmodule
