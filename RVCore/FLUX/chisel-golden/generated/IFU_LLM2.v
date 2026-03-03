module IFU_LLM2(
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
  reg [31:0] pc; // @[frontend.scala 20:21]
  wire [6:0] inInstOp = io_inst[6:0]; // @[frontend.scala 25:27]
  wire  isBranch = 7'h63 == inInstOp | (7'h67 == inInstOp | 7'h6f == inInstOp); // @[Mux.scala 81:58]
  wire  isEcall = io_inst == 32'h73; // @[frontend.scala 33:26]
  wire  isMret = io_inst == 32'h30200073; // @[frontend.scala 34:26]
  wire  needBruRes = isBranch | isEcall | isMret; // @[frontend.scala 35:42]
  wire  jalBruRes_valid = inInstOp == 7'h6f; // @[frontend.scala 40:33]
  wire [10:0] _jalImmExt_T_2 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] jalImmExt = {_jalImmExt_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] jalBruRes_targetPc = pc + jalImmExt; // @[frontend.scala 43:30]
  wire [31:0] predictPc = pc + 32'h4; // @[frontend.scala 47:19]
  wire [31:0] _next_pc_T_3 = ~jalBruRes_valid ? predictPc : pc; // @[frontend.scala 55:24]
  wire [31:0] _next_pc_T_4 = jalBruRes_valid ? jalBruRes_targetPc : _next_pc_T_3; // @[frontend.scala 54:24]
  wire [31:0] _next_pc_T_5 = ~needBruRes ? predictPc : _next_pc_T_4; // @[frontend.scala 53:24]
  wire [31:0] _next_pc_T_6 = ~io_to_idu_ready ? pc : _next_pc_T_5; // @[frontend.scala 52:24]
  assign io_to_idu_bits_inst = io_inst; // @[frontend.scala 62:25]
  assign io_to_idu_bits_pc = pc; // @[frontend.scala 60:23]
  assign io_to_idu_bits_next_pc = io_redirect_valid ? io_redirect_target : _next_pc_T_6; // @[frontend.scala 51:24]
  assign io_to_idu_bits_isBranch = 7'h63 == inInstOp | (7'h67 == inInstOp | 7'h6f == inInstOp); // @[Mux.scala 81:58]
  assign io_pc = pc; // @[frontend.scala 61:11]
  always @(posedge clock) begin
    if (reset) begin // @[frontend.scala 20:21]
      pc <= 32'h80000000; // @[frontend.scala 20:21]
    end else if (io_redirect_valid) begin // @[frontend.scala 51:24]
      pc <= io_redirect_target;
    end else if (!(~io_to_idu_ready)) begin // @[frontend.scala 52:24]
      if (~needBruRes) begin // @[frontend.scala 53:24]
        pc <= predictPc;
      end else begin
        pc <= _next_pc_T_4;
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
  pc = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
