module IFU_LLM(
  input         clock,
  input         reset,
  input  [31:0] io_inst,
  input         io_to_idu_ready,
  output [31:0] io_to_idu_bits_inst,
  output [31:0] io_to_idu_bits_pc,
  output [31:0] io_to_idu_bits_next_pc,
  output        io_to_idu_bits_isBranch,
  output [31:0] io_pc,
  input  [31:0] io_redirect_target,
  input         io_redirect_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcReg; // @[IFU.scala 86:22]
  wire [6:0] opcode = io_inst[6:0]; // @[IFU.scala 92:23]
  wire  isJal = opcode == 7'h6f; // @[IFU.scala 94:23]
  wire  isJalr = opcode == 7'h67; // @[IFU.scala 95:24]
  wire  isBranch = opcode == 7'h63; // @[IFU.scala 96:26]
  wire  isJump = isJal | isJalr | isBranch; // @[IFU.scala 97:32]
  wire [10:0] _jalOffset_T_2 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] jalOffset = {_jalOffset_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] jalTarget = pcReg + jalOffset; // @[IFU.scala 110:25]
  wire [31:0] predictPc = pcReg + 32'h4; // @[IFU.scala 113:20]
  wire  _next_pc_T = ~io_to_idu_ready; // @[IFU.scala 119:5]
  wire  _next_pc_T_1 = ~isJump; // @[IFU.scala 120:5]
  wire  _next_pc_T_2 = isJalr | isBranch; // @[IFU.scala 122:13]
  wire [31:0] _next_pc_T_3 = _next_pc_T_2 ? predictPc : pcReg; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_4 = isJal ? jalTarget : _next_pc_T_3; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_5 = _next_pc_T_1 ? predictPc : _next_pc_T_4; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_6 = _next_pc_T ? pcReg : _next_pc_T_5; // @[Mux.scala 101:16]
  assign io_to_idu_bits_inst = io_inst; // @[IFU.scala 132:23]
  assign io_to_idu_bits_pc = pcReg; // @[IFU.scala 133:23]
  assign io_to_idu_bits_next_pc = io_redirect_valid ? io_redirect_target : _next_pc_T_6; // @[Mux.scala 101:16]
  assign io_to_idu_bits_isBranch = isJal | isJalr | isBranch; // @[IFU.scala 97:32]
  assign io_pc = pcReg; // @[IFU.scala 89:9]
  always @(posedge clock) begin
    if (reset) begin // @[IFU.scala 86:22]
      pcReg <= 32'h80000000; // @[IFU.scala 86:22]
    end else if (io_redirect_valid) begin // @[Mux.scala 101:16]
      pcReg <= io_redirect_target;
    end else if (!(_next_pc_T)) begin // @[Mux.scala 101:16]
      if (_next_pc_T_1) begin // @[Mux.scala 101:16]
        pcReg <= predictPc;
      end else begin
        pcReg <= _next_pc_T_4;
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
  pcReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
