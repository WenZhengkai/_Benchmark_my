`timescale 1ns/1ps

module frontend_tb;

  // Clock & Reset
  reg clock;
  reg reset;

  // Inputs
  reg         io_redirect;
  reg  [31:0] io_inst;
  reg  [31:0] io_ifuredirect_target;
  reg         io_ifuredirect_valid;
  reg         io_to_exu_ready;
  reg  [4:0]  io_wb_rd;
  reg  [31:0] io_wb_Res;
  reg         io_wb_RegWrite;
  reg  [31:0] io_rfSrc1;
  reg  [31:0] io_rfSrc2;

  // Outputs (for ref)
  wire [31:0] ref_io_pc;
  wire        ref_io_to_exu_valid;
  wire [31:0] ref_io_to_exu_bits_cf_inst;
  wire [31:0] ref_io_to_exu_bits_cf_pc;
  wire [31:0] ref_io_to_exu_bits_cf_next_pc;
  wire        ref_io_to_exu_bits_cf_isBranch;
  wire        ref_io_to_exu_bits_ctrl_MemWrite;
  wire [1:0]  ref_io_to_exu_bits_ctrl_ResSrc;
  wire [2:0]  ref_io_to_exu_bits_ctrl_fuSrc1Type;
  wire [2:0]  ref_io_to_exu_bits_ctrl_fuSrc2Type;
  wire [2:0]  ref_io_to_exu_bits_ctrl_fuType;
  wire [6:0]  ref_io_to_exu_bits_ctrl_fuOpType;
  wire [4:0]  ref_io_to_exu_bits_ctrl_rs1;
  wire [4:0]  ref_io_to_exu_bits_ctrl_rs2;
  wire        ref_io_to_exu_bits_ctrl_rfWen;
  wire [4:0]  ref_io_to_exu_bits_ctrl_rd;
  wire [31:0] ref_io_to_exu_bits_data_fuSrc1;
  wire [31:0] ref_io_to_exu_bits_data_fuSrc2;
  wire [31:0] ref_io_to_exu_bits_data_imm;
  wire        ref_io_to_exu_bits_data_Alu0Res_ready;
  wire        ref_io_to_exu_bits_data_Alu0Res_valid;
  wire [31:0] ref_io_to_exu_bits_data_Alu0Res_bits;
  wire [31:0] ref_io_to_exu_bits_data_data_from_mem;
  wire [31:0] ref_io_to_exu_bits_data_csrRdata;
  wire [31:0] ref_io_to_exu_bits_data_rfSrc1;
  wire [31:0] ref_io_to_exu_bits_data_rfSrc2;
  wire [4:0]  ref_io_rs1;
  wire [4:0]  ref_io_rs2;

  // Outputs (for dut)
  wire [31:0] dut_io_pc;
  wire        dut_io_to_exu_valid;
  wire [31:0] dut_io_to_exu_bits_cf_inst;
  wire [31:0] dut_io_to_exu_bits_cf_pc;
  wire [31:0] dut_io_to_exu_bits_cf_next_pc;
  wire        dut_io_to_exu_bits_cf_isBranch;
  wire        dut_io_to_exu_bits_ctrl_MemWrite;
  wire [1:0]  dut_io_to_exu_bits_ctrl_ResSrc;
  wire [2:0]  dut_io_to_exu_bits_ctrl_fuSrc1Type;
  wire [2:0]  dut_io_to_exu_bits_ctrl_fuSrc2Type;
  wire [2:0]  dut_io_to_exu_bits_ctrl_fuType;
  wire [6:0]  dut_io_to_exu_bits_ctrl_fuOpType;
  wire [4:0]  dut_io_to_exu_bits_ctrl_rs1;
  wire [4:0]  dut_io_to_exu_bits_ctrl_rs2;
  wire        dut_io_to_exu_bits_ctrl_rfWen;
  wire [4:0]  dut_io_to_exu_bits_ctrl_rd;
  wire [31:0] dut_io_to_exu_bits_data_fuSrc1;
  wire [31:0] dut_io_to_exu_bits_data_fuSrc2;
  wire [31:0] dut_io_to_exu_bits_data_imm;
  wire        dut_io_to_exu_bits_data_Alu0Res_ready;
  wire        dut_io_to_exu_bits_data_Alu0Res_valid;
  wire [31:0] dut_io_to_exu_bits_data_Alu0Res_bits;
  wire [31:0] dut_io_to_exu_bits_data_data_from_mem;
  wire [31:0] dut_io_to_exu_bits_data_csrRdata;
  wire [31:0] dut_io_to_exu_bits_data_rfSrc1;
  wire [31:0] dut_io_to_exu_bits_data_rfSrc2;
  wire [4:0]  dut_io_rs1;
  wire [4:0]  dut_io_rs2;

  // Counters for report
  integer test_count, pass_count, fail_count;
  integer fail_cycle[0:9999];
  integer fail_index;
  reg [1023:0] fail_msg[0:9999];

  // Test timing
  integer test_start_time, test_end_time;

  // Instantiate Reference Model
  frontend_golden ref_u (
    .clock(clock),
    .reset(reset),
    .io_redirect(io_redirect),
    .io_inst(io_inst),
    .io_pc(ref_io_pc),
    .io_ifuredirect_target(io_ifuredirect_target),
    .io_ifuredirect_valid(io_ifuredirect_valid),
    .io_to_exu_ready(io_to_exu_ready),
    .io_to_exu_valid(ref_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(ref_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(ref_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(ref_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(ref_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(ref_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(ref_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuSrc1Type(ref_io_to_exu_bits_ctrl_fuSrc1Type),
    .io_to_exu_bits_ctrl_fuSrc2Type(ref_io_to_exu_bits_ctrl_fuSrc2Type),
    .io_to_exu_bits_ctrl_fuType(ref_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(ref_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rs1(ref_io_to_exu_bits_ctrl_rs1),
    .io_to_exu_bits_ctrl_rs2(ref_io_to_exu_bits_ctrl_rs2),
    .io_to_exu_bits_ctrl_rfWen(ref_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(ref_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(ref_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(ref_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(ref_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_Alu0Res_ready(ref_io_to_exu_bits_data_Alu0Res_ready),
    .io_to_exu_bits_data_Alu0Res_valid(ref_io_to_exu_bits_data_Alu0Res_valid),
    .io_to_exu_bits_data_Alu0Res_bits(ref_io_to_exu_bits_data_Alu0Res_bits),
    .io_to_exu_bits_data_data_from_mem(ref_io_to_exu_bits_data_data_from_mem),
    .io_to_exu_bits_data_csrRdata(ref_io_to_exu_bits_data_csrRdata),
    .io_to_exu_bits_data_rfSrc1(ref_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(ref_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(io_wb_rd),
    .io_wb_Res(io_wb_Res),
    .io_wb_RegWrite(io_wb_RegWrite),
    .io_rfSrc1(io_rfSrc1),
    .io_rfSrc2(io_rfSrc2),
    .io_rs1(ref_io_rs1),
    .io_rs2(ref_io_rs2)
  );

  // Instantiate DUT
  frontend dut_u (
    .clock(clock),
    .reset(reset),
    .io_redirect(io_redirect),
    .io_inst(io_inst),
    .io_pc(dut_io_pc),
    .io_ifuredirect_target(io_ifuredirect_target),
    .io_ifuredirect_valid(io_ifuredirect_valid),
    .io_to_exu_ready(io_to_exu_ready),
    .io_to_exu_valid(dut_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(dut_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(dut_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(dut_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(dut_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(dut_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(dut_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuSrc1Type(dut_io_to_exu_bits_ctrl_fuSrc1Type),
    .io_to_exu_bits_ctrl_fuSrc2Type(dut_io_to_exu_bits_ctrl_fuSrc2Type),
    .io_to_exu_bits_ctrl_fuType(dut_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(dut_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rs1(dut_io_to_exu_bits_ctrl_rs1),
    .io_to_exu_bits_ctrl_rs2(dut_io_to_exu_bits_ctrl_rs2),
    .io_to_exu_bits_ctrl_rfWen(dut_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(dut_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(dut_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(dut_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(dut_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_Alu0Res_ready(dut_io_to_exu_bits_data_Alu0Res_ready),
    .io_to_exu_bits_data_Alu0Res_valid(dut_io_to_exu_bits_data_Alu0Res_valid),
    .io_to_exu_bits_data_Alu0Res_bits(dut_io_to_exu_bits_data_Alu0Res_bits),
    .io_to_exu_bits_data_data_from_mem(dut_io_to_exu_bits_data_data_from_mem),
    .io_to_exu_bits_data_csrRdata(dut_io_to_exu_bits_data_csrRdata),
    .io_to_exu_bits_data_rfSrc1(dut_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(dut_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(io_wb_rd),
    .io_wb_Res(io_wb_Res),
    .io_wb_RegWrite(io_wb_RegWrite),
    .io_rfSrc1(io_rfSrc1),
    .io_rfSrc2(io_rfSrc2),
    .io_rs1(dut_io_rs1),
    .io_rs2(dut_io_rs2)
  );

  // Clock generation
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  // Test sequence
  initial begin
    test_count = 0;
    pass_count = 0;
    fail_count = 0;
    fail_index = 0;
    test_start_time = $time;

    // Reset
    reset = 1;
    #20;
    reset = 0;
    #10;

    // Test loop
    repeat (1000) begin
      @(negedge clock);
      // Randomize inputs
      io_redirect           = $random;
      io_inst               = $random;
      io_ifuredirect_target = $random;
      io_ifuredirect_valid  = $random;
      io_to_exu_ready       = $random;
      io_wb_rd              = $random;
      io_wb_Res             = $random;
      io_wb_RegWrite        = $random;
      io_rfSrc1             = $random;
      io_rfSrc2             = $random;

      @(posedge clock);
      #1; // Wait for outputs to settle

      // Check all outputs
      if (
        (dut_io_pc                        !== ref_io_pc                       ) ||
        (dut_io_to_exu_valid              !== ref_io_to_exu_valid             ) ||
        (dut_io_to_exu_bits_cf_inst       !== ref_io_to_exu_bits_cf_inst      ) ||
        (dut_io_to_exu_bits_cf_pc         !== ref_io_to_exu_bits_cf_pc        ) ||
        (dut_io_to_exu_bits_cf_next_pc    !== ref_io_to_exu_bits_cf_next_pc   ) ||
        (dut_io_to_exu_bits_cf_isBranch   !== ref_io_to_exu_bits_cf_isBranch  ) ||
        (dut_io_to_exu_bits_ctrl_MemWrite !== ref_io_to_exu_bits_ctrl_MemWrite) ||
        (dut_io_to_exu_bits_ctrl_ResSrc   !== ref_io_to_exu_bits_ctrl_ResSrc  ) ||
        (dut_io_to_exu_bits_ctrl_fuSrc1Type !== ref_io_to_exu_bits_ctrl_fuSrc1Type) ||
        (dut_io_to_exu_bits_ctrl_fuSrc2Type !== ref_io_to_exu_bits_ctrl_fuSrc2Type) ||
        (dut_io_to_exu_bits_ctrl_fuType   !== ref_io_to_exu_bits_ctrl_fuType  ) ||
        (dut_io_to_exu_bits_ctrl_fuOpType !== ref_io_to_exu_bits_ctrl_fuOpType) ||
        (dut_io_to_exu_bits_ctrl_rs1      !== ref_io_to_exu_bits_ctrl_rs1     ) ||
        (dut_io_to_exu_bits_ctrl_rs2      !== ref_io_to_exu_bits_ctrl_rs2     ) ||
        (dut_io_to_exu_bits_ctrl_rfWen    !== ref_io_to_exu_bits_ctrl_rfWen   ) ||
        (dut_io_to_exu_bits_ctrl_rd       !== ref_io_to_exu_bits_ctrl_rd      ) ||
        (dut_io_to_exu_bits_data_fuSrc1   !== ref_io_to_exu_bits_data_fuSrc1  ) ||
        (dut_io_to_exu_bits_data_fuSrc2   !== ref_io_to_exu_bits_data_fuSrc2  ) ||
        (dut_io_to_exu_bits_data_imm      !== ref_io_to_exu_bits_data_imm     ) ||
        (dut_io_to_exu_bits_data_Alu0Res_ready !== ref_io_to_exu_bits_data_Alu0Res_ready) ||
        (dut_io_to_exu_bits_data_Alu0Res_valid !== ref_io_to_exu_bits_data_Alu0Res_valid) ||
        (dut_io_to_exu_bits_data_Alu0Res_bits !== ref_io_to_exu_bits_data_Alu0Res_bits) ||
        (dut_io_to_exu_bits_data_data_from_mem !== ref_io_to_exu_bits_data_data_from_mem) ||
        (dut_io_to_exu_bits_data_csrRdata !== ref_io_to_exu_bits_data_csrRdata) ||
        (dut_io_to_exu_bits_data_rfSrc1   !== ref_io_to_exu_bits_data_rfSrc1  ) ||
        (dut_io_to_exu_bits_data_rfSrc2   !== ref_io_to_exu_bits_data_rfSrc2  ) ||
        (dut_io_rs1                       !== ref_io_rs1                      ) ||
        (dut_io_rs2                       !== ref_io_rs2                      )
      ) begin
        fail_count = fail_count + 1;
        fail_cycle[fail_index] = test_count;
        $sformat(fail_msg[fail_index], "Mismatch at cycle %0d", test_count);
        fail_index = fail_index + 1;
      end else begin
        pass_count = pass_count + 1;
      end
      test_count = test_count + 1;
    end

    test_end_time = $time;

    // Report
    $display("Verification Report");
    $display("=======================");
    $display("Test Start Time: %20d", test_start_time);
    $display("");
    $display("Test Summary:");
    $display("Total Tests Run: %d", test_count);
    $display("Tests Passed:   %d", pass_count);
    $display("Tests Failed:   %d", fail_count);
    $display("Failure Rate:   %2.2f%%", 100.0*fail_count/test_count);
    $display("");
    $display("Test End Time: %20d", test_end_time);
    $display("");
    if (fail_count > 0) begin
      $display("RESULT: %0d TESTS FAILED!", fail_count);
      for (integer i=0; i<fail_index; i=i+1) begin
        $display("Fail #%0d at test %0d: %s", i, fail_cycle[i], fail_msg[i]);
      end
    end else begin
      $display("RESULT: ALL TESTS PASSED!");
    end
    $finish;
  end

endmodule

module IFU_golden(
  input         clock,
  input         reset,
  input  [31:0] io_inst,
  output [31:0] io_pc,
  input         io_to_idu_ready,
  output [31:0] io_to_idu_bits_inst,
  output [31:0] io_to_idu_bits_pc,
  output [31:0] io_to_idu_bits_next_pc,
  output        io_to_idu_bits_isBranch,
  input  [31:0] io_redirect_target,
  input         io_redirect_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pc; // @[dut.scala 227:21]
  wire [6:0] inInstOp = io_inst[6:0]; // @[dut.scala 232:27]
  wire  isBranch = 7'h63 == inInstOp | (7'h67 == inInstOp | 7'h6f == inInstOp); // @[Mux.scala 81:58]
  wire  isEcall = io_inst == 32'h73; // @[dut.scala 240:26]
  wire  isMret = io_inst == 32'h30200073; // @[dut.scala 241:26]
  wire  needBruRes = isBranch | isEcall | isMret; // @[dut.scala 242:42]
  wire  jalBruRes_valid = inInstOp == 7'h6f; // @[dut.scala 247:33]
  wire [10:0] _jalImmExt_T_2 = io_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] jalImmExt = {_jalImmExt_T_2,io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] jalBruRes_targetPc = pc + jalImmExt; // @[dut.scala 250:30]
  wire [31:0] predictPc = pc + 32'h4; // @[dut.scala 254:19]
  wire [31:0] _next_pc_T_3 = ~jalBruRes_valid ? predictPc : pc; // @[dut.scala 262:24]
  wire [31:0] _next_pc_T_4 = jalBruRes_valid ? jalBruRes_targetPc : _next_pc_T_3; // @[dut.scala 261:24]
  wire [31:0] _next_pc_T_5 = ~needBruRes ? predictPc : _next_pc_T_4; // @[dut.scala 260:24]
  wire [31:0] _next_pc_T_6 = ~io_to_idu_ready ? pc : _next_pc_T_5; // @[dut.scala 259:24]
  assign io_pc = pc; // @[dut.scala 268:11]
  assign io_to_idu_bits_inst = io_inst; // @[dut.scala 269:25]
  assign io_to_idu_bits_pc = pc; // @[dut.scala 267:23]
  assign io_to_idu_bits_next_pc = io_redirect_valid ? io_redirect_target : _next_pc_T_6; // @[dut.scala 258:24]
  assign io_to_idu_bits_isBranch = 7'h63 == inInstOp | (7'h67 == inInstOp | 7'h6f == inInstOp); // @[Mux.scala 81:58]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 227:21]
      pc <= 32'h80000000; // @[dut.scala 227:21]
    end else if (io_redirect_valid) begin // @[dut.scala 258:24]
      pc <= io_redirect_target;
    end else if (!(~io_to_idu_ready)) begin // @[dut.scala 259:24]
      if (~needBruRes) begin // @[dut.scala 260:24]
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
module IDU_golden(
  output        io_from_ifu_ready,
  input         io_from_ifu_valid,
  input  [31:0] io_from_ifu_bits_inst,
  input  [31:0] io_from_ifu_bits_pc,
  input  [31:0] io_from_ifu_bits_next_pc,
  input         io_from_ifu_bits_isBranch,
  input         io_to_isu_ready,
  output        io_to_isu_valid,
  output [31:0] io_to_isu_bits_cf_inst,
  output [31:0] io_to_isu_bits_cf_pc,
  output [31:0] io_to_isu_bits_cf_next_pc,
  output        io_to_isu_bits_cf_isBranch,
  output        io_to_isu_bits_ctrl_MemWrite,
  output [1:0]  io_to_isu_bits_ctrl_ResSrc,
  output [2:0]  io_to_isu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_isu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_isu_bits_ctrl_fuType,
  output [6:0]  io_to_isu_bits_ctrl_fuOpType,
  output [4:0]  io_to_isu_bits_ctrl_rs1,
  output [4:0]  io_to_isu_bits_ctrl_rs2,
  output        io_to_isu_bits_ctrl_rfWen,
  output [4:0]  io_to_isu_bits_ctrl_rd,
  output [31:0] io_to_isu_bits_data_imm
);
  wire  _io_from_ifu_ready_T_1 = io_to_isu_ready & io_to_isu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _decodelist_T = io_from_ifu_bits_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _decodelist_T_1 = 32'h13 == _decodelist_T; // @[Lookup.scala 31:38]
  wire [31:0] _decodelist_T_2 = io_from_ifu_bits_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _decodelist_T_3 = 32'h1013 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_5 = 32'h2013 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_7 = 32'h3013 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_9 = 32'h4013 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_11 = 32'h5013 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_13 = 32'h6013 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_15 = 32'h7013 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_17 = 32'h40005013 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_19 = 32'h33 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_21 = 32'h1033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_23 = 32'h2033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_25 = 32'h3033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_27 = 32'h4033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_29 = 32'h5033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_31 = 32'h6033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_33 = 32'h7033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_35 = 32'h40000033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire  _decodelist_T_37 = 32'h40005033 == _decodelist_T_2; // @[Lookup.scala 31:38]
  wire [31:0] _decodelist_T_38 = io_from_ifu_bits_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _decodelist_T_39 = 32'h17 == _decodelist_T_38; // @[Lookup.scala 31:38]
  wire  _decodelist_T_41 = 32'h37 == _decodelist_T_38; // @[Lookup.scala 31:38]
  wire  _decodelist_T_43 = 32'h6f == _decodelist_T_38; // @[Lookup.scala 31:38]
  wire  _decodelist_T_45 = 32'h67 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_47 = 32'h63 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_49 = 32'h1063 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_51 = 32'h4063 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_53 = 32'h5063 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_55 = 32'h6063 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_57 = 32'h7063 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_59 = 32'h23 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_61 = 32'h1023 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_63 = 32'h2023 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_65 = 32'h3 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_67 = 32'h1003 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_69 = 32'h2003 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_71 = 32'h4003 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_73 = 32'h5003 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_75 = 32'h1073 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_77 = 32'h2073 == _decodelist_T; // @[Lookup.scala 31:38]
  wire  _decodelist_T_79 = 32'h73 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire  _decodelist_T_81 = 32'h100073 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire  _decodelist_T_83 = 32'h30200073 == io_from_ifu_bits_inst; // @[Lookup.scala 31:38]
  wire [2:0] _decodelist_T_84 = _decodelist_T_83 ? 3'h5 : 3'h0; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_85 = _decodelist_T_81 ? 3'h4 : _decodelist_T_84; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_86 = _decodelist_T_79 ? 3'h4 : _decodelist_T_85; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_87 = _decodelist_T_77 ? 3'h4 : _decodelist_T_86; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_88 = _decodelist_T_75 ? 3'h4 : _decodelist_T_87; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_89 = _decodelist_T_73 ? 3'h4 : _decodelist_T_88; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_90 = _decodelist_T_71 ? 3'h4 : _decodelist_T_89; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_91 = _decodelist_T_69 ? 3'h4 : _decodelist_T_90; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_92 = _decodelist_T_67 ? 3'h4 : _decodelist_T_91; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_93 = _decodelist_T_65 ? 3'h4 : _decodelist_T_92; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_94 = _decodelist_T_63 ? 3'h2 : _decodelist_T_93; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_95 = _decodelist_T_61 ? 3'h2 : _decodelist_T_94; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_96 = _decodelist_T_59 ? 3'h2 : _decodelist_T_95; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_97 = _decodelist_T_57 ? 3'h1 : _decodelist_T_96; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_98 = _decodelist_T_55 ? 3'h1 : _decodelist_T_97; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_99 = _decodelist_T_53 ? 3'h1 : _decodelist_T_98; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_100 = _decodelist_T_51 ? 3'h1 : _decodelist_T_99; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_101 = _decodelist_T_49 ? 3'h1 : _decodelist_T_100; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_102 = _decodelist_T_47 ? 3'h1 : _decodelist_T_101; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_103 = _decodelist_T_45 ? 3'h4 : _decodelist_T_102; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_104 = _decodelist_T_43 ? 3'h7 : _decodelist_T_103; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_105 = _decodelist_T_41 ? 3'h6 : _decodelist_T_104; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_106 = _decodelist_T_39 ? 3'h6 : _decodelist_T_105; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_107 = _decodelist_T_37 ? 3'h5 : _decodelist_T_106; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_108 = _decodelist_T_35 ? 3'h5 : _decodelist_T_107; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_109 = _decodelist_T_33 ? 3'h5 : _decodelist_T_108; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_110 = _decodelist_T_31 ? 3'h5 : _decodelist_T_109; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_111 = _decodelist_T_29 ? 3'h5 : _decodelist_T_110; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_112 = _decodelist_T_27 ? 3'h5 : _decodelist_T_111; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_113 = _decodelist_T_25 ? 3'h5 : _decodelist_T_112; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_114 = _decodelist_T_23 ? 3'h5 : _decodelist_T_113; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_115 = _decodelist_T_21 ? 3'h5 : _decodelist_T_114; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_116 = _decodelist_T_19 ? 3'h5 : _decodelist_T_115; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_117 = _decodelist_T_17 ? 3'h4 : _decodelist_T_116; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_118 = _decodelist_T_15 ? 3'h4 : _decodelist_T_117; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_119 = _decodelist_T_13 ? 3'h4 : _decodelist_T_118; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_120 = _decodelist_T_11 ? 3'h4 : _decodelist_T_119; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_121 = _decodelist_T_9 ? 3'h4 : _decodelist_T_120; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_122 = _decodelist_T_7 ? 3'h4 : _decodelist_T_121; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_123 = _decodelist_T_5 ? 3'h4 : _decodelist_T_122; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_124 = _decodelist_T_3 ? 3'h4 : _decodelist_T_123; // @[Lookup.scala 34:39]
  wire [2:0] decodelist_0 = _decodelist_T_1 ? 3'h4 : _decodelist_T_124; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_125 = _decodelist_T_83 ? 2'h3 : 2'h0; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_126 = _decodelist_T_81 ? 2'h3 : _decodelist_T_125; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_127 = _decodelist_T_79 ? 2'h3 : _decodelist_T_126; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_128 = _decodelist_T_77 ? 2'h3 : _decodelist_T_127; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_129 = _decodelist_T_75 ? 2'h3 : _decodelist_T_128; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_130 = _decodelist_T_73 ? 2'h1 : _decodelist_T_129; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_131 = _decodelist_T_71 ? 2'h1 : _decodelist_T_130; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_132 = _decodelist_T_69 ? 2'h1 : _decodelist_T_131; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_133 = _decodelist_T_67 ? 2'h1 : _decodelist_T_132; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_134 = _decodelist_T_65 ? 2'h1 : _decodelist_T_133; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_135 = _decodelist_T_63 ? 2'h1 : _decodelist_T_134; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_136 = _decodelist_T_61 ? 2'h1 : _decodelist_T_135; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_137 = _decodelist_T_59 ? 2'h1 : _decodelist_T_136; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_138 = _decodelist_T_57 ? 2'h0 : _decodelist_T_137; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_139 = _decodelist_T_55 ? 2'h0 : _decodelist_T_138; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_140 = _decodelist_T_53 ? 2'h0 : _decodelist_T_139; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_141 = _decodelist_T_51 ? 2'h0 : _decodelist_T_140; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_142 = _decodelist_T_49 ? 2'h0 : _decodelist_T_141; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_143 = _decodelist_T_47 ? 2'h0 : _decodelist_T_142; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_144 = _decodelist_T_45 ? 2'h0 : _decodelist_T_143; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_145 = _decodelist_T_43 ? 2'h0 : _decodelist_T_144; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_146 = _decodelist_T_41 ? 2'h0 : _decodelist_T_145; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_147 = _decodelist_T_39 ? 2'h0 : _decodelist_T_146; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_148 = _decodelist_T_37 ? 2'h0 : _decodelist_T_147; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_149 = _decodelist_T_35 ? 2'h0 : _decodelist_T_148; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_150 = _decodelist_T_33 ? 2'h0 : _decodelist_T_149; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_151 = _decodelist_T_31 ? 2'h0 : _decodelist_T_150; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_152 = _decodelist_T_29 ? 2'h0 : _decodelist_T_151; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_153 = _decodelist_T_27 ? 2'h0 : _decodelist_T_152; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_154 = _decodelist_T_25 ? 2'h0 : _decodelist_T_153; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_155 = _decodelist_T_23 ? 2'h0 : _decodelist_T_154; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_156 = _decodelist_T_21 ? 2'h0 : _decodelist_T_155; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_157 = _decodelist_T_19 ? 2'h0 : _decodelist_T_156; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_158 = _decodelist_T_17 ? 2'h0 : _decodelist_T_157; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_159 = _decodelist_T_15 ? 2'h0 : _decodelist_T_158; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_160 = _decodelist_T_13 ? 2'h0 : _decodelist_T_159; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_161 = _decodelist_T_11 ? 2'h0 : _decodelist_T_160; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_162 = _decodelist_T_9 ? 2'h0 : _decodelist_T_161; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_163 = _decodelist_T_7 ? 2'h0 : _decodelist_T_162; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_164 = _decodelist_T_5 ? 2'h0 : _decodelist_T_163; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_165 = _decodelist_T_3 ? 2'h0 : _decodelist_T_164; // @[Lookup.scala 34:39]
  wire [1:0] decodelist_1 = _decodelist_T_1 ? 2'h0 : _decodelist_T_165; // @[Lookup.scala 34:39]
  wire  _decodelist_T_166 = _decodelist_T_83 ? 1'h0 : 1'h1; // @[Lookup.scala 34:39]
  wire  _decodelist_T_167 = _decodelist_T_81 ? 1'h0 : _decodelist_T_166; // @[Lookup.scala 34:39]
  wire  _decodelist_T_168 = _decodelist_T_79 ? 1'h0 : _decodelist_T_167; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_169 = _decodelist_T_77 ? 2'h2 : {{1'd0}, _decodelist_T_168}; // @[Lookup.scala 34:39]
  wire [1:0] _decodelist_T_170 = _decodelist_T_75 ? 2'h1 : _decodelist_T_169; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_171 = _decodelist_T_73 ? 3'h5 : {{1'd0}, _decodelist_T_170}; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_172 = _decodelist_T_71 ? 3'h4 : _decodelist_T_171; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_173 = _decodelist_T_69 ? 3'h2 : _decodelist_T_172; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_174 = _decodelist_T_67 ? 3'h1 : _decodelist_T_173; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_175 = _decodelist_T_65 ? 3'h0 : _decodelist_T_174; // @[Lookup.scala 34:39]
  wire [3:0] _decodelist_T_176 = _decodelist_T_63 ? 4'ha : {{1'd0}, _decodelist_T_175}; // @[Lookup.scala 34:39]
  wire [3:0] _decodelist_T_177 = _decodelist_T_61 ? 4'h9 : _decodelist_T_176; // @[Lookup.scala 34:39]
  wire [3:0] _decodelist_T_178 = _decodelist_T_59 ? 4'h8 : _decodelist_T_177; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_179 = _decodelist_T_57 ? 5'h17 : {{1'd0}, _decodelist_T_178}; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_180 = _decodelist_T_55 ? 5'h16 : _decodelist_T_179; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_181 = _decodelist_T_53 ? 5'h15 : _decodelist_T_180; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_182 = _decodelist_T_51 ? 5'h14 : _decodelist_T_181; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_183 = _decodelist_T_49 ? 5'h11 : _decodelist_T_182; // @[Lookup.scala 34:39]
  wire [4:0] _decodelist_T_184 = _decodelist_T_47 ? 5'h10 : _decodelist_T_183; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_185 = _decodelist_T_45 ? 7'h40 : {{2'd0}, _decodelist_T_184}; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_186 = _decodelist_T_43 ? 7'h40 : _decodelist_T_185; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_187 = _decodelist_T_41 ? 7'h40 : _decodelist_T_186; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_188 = _decodelist_T_39 ? 7'h40 : _decodelist_T_187; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_189 = _decodelist_T_37 ? 7'hd : _decodelist_T_188; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_190 = _decodelist_T_35 ? 7'h8 : _decodelist_T_189; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_191 = _decodelist_T_33 ? 7'h7 : _decodelist_T_190; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_192 = _decodelist_T_31 ? 7'h6 : _decodelist_T_191; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_193 = _decodelist_T_29 ? 7'h5 : _decodelist_T_192; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_194 = _decodelist_T_27 ? 7'h4 : _decodelist_T_193; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_195 = _decodelist_T_25 ? 7'h3 : _decodelist_T_194; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_196 = _decodelist_T_23 ? 7'h2 : _decodelist_T_195; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_197 = _decodelist_T_21 ? 7'h1 : _decodelist_T_196; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_198 = _decodelist_T_19 ? 7'h40 : _decodelist_T_197; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_199 = _decodelist_T_17 ? 7'hd : _decodelist_T_198; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_200 = _decodelist_T_15 ? 7'h7 : _decodelist_T_199; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_201 = _decodelist_T_13 ? 7'h6 : _decodelist_T_200; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_202 = _decodelist_T_11 ? 7'h5 : _decodelist_T_201; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_203 = _decodelist_T_9 ? 7'h4 : _decodelist_T_202; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_204 = _decodelist_T_7 ? 7'h3 : _decodelist_T_203; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_205 = _decodelist_T_5 ? 7'h2 : _decodelist_T_204; // @[Lookup.scala 34:39]
  wire [6:0] _decodelist_T_206 = _decodelist_T_3 ? 7'h1 : _decodelist_T_205; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_207 = _decodelist_T_83 ? 3'h0 : 3'h4; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_208 = _decodelist_T_81 ? 3'h0 : _decodelist_T_207; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_209 = _decodelist_T_79 ? 3'h0 : _decodelist_T_208; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_210 = _decodelist_T_77 ? 3'h0 : _decodelist_T_209; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_211 = _decodelist_T_75 ? 3'h0 : _decodelist_T_210; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_212 = _decodelist_T_73 ? 3'h0 : _decodelist_T_211; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_213 = _decodelist_T_71 ? 3'h0 : _decodelist_T_212; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_214 = _decodelist_T_69 ? 3'h0 : _decodelist_T_213; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_215 = _decodelist_T_67 ? 3'h0 : _decodelist_T_214; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_216 = _decodelist_T_65 ? 3'h0 : _decodelist_T_215; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_217 = _decodelist_T_63 ? 3'h0 : _decodelist_T_216; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_218 = _decodelist_T_61 ? 3'h0 : _decodelist_T_217; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_219 = _decodelist_T_59 ? 3'h0 : _decodelist_T_218; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_220 = _decodelist_T_57 ? 3'h0 : _decodelist_T_219; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_221 = _decodelist_T_55 ? 3'h0 : _decodelist_T_220; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_222 = _decodelist_T_53 ? 3'h0 : _decodelist_T_221; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_223 = _decodelist_T_51 ? 3'h0 : _decodelist_T_222; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_224 = _decodelist_T_49 ? 3'h0 : _decodelist_T_223; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_225 = _decodelist_T_47 ? 3'h0 : _decodelist_T_224; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_226 = _decodelist_T_45 ? 3'h2 : _decodelist_T_225; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_227 = _decodelist_T_43 ? 3'h2 : _decodelist_T_226; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_228 = _decodelist_T_41 ? 3'h4 : _decodelist_T_227; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_229 = _decodelist_T_39 ? 3'h2 : _decodelist_T_228; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_230 = _decodelist_T_37 ? 3'h0 : _decodelist_T_229; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_231 = _decodelist_T_35 ? 3'h0 : _decodelist_T_230; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_232 = _decodelist_T_33 ? 3'h0 : _decodelist_T_231; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_233 = _decodelist_T_31 ? 3'h0 : _decodelist_T_232; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_234 = _decodelist_T_29 ? 3'h0 : _decodelist_T_233; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_235 = _decodelist_T_27 ? 3'h0 : _decodelist_T_234; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_236 = _decodelist_T_25 ? 3'h0 : _decodelist_T_235; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_237 = _decodelist_T_23 ? 3'h0 : _decodelist_T_236; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_238 = _decodelist_T_21 ? 3'h0 : _decodelist_T_237; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_239 = _decodelist_T_19 ? 3'h0 : _decodelist_T_238; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_240 = _decodelist_T_17 ? 3'h0 : _decodelist_T_239; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_241 = _decodelist_T_15 ? 3'h0 : _decodelist_T_240; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_242 = _decodelist_T_13 ? 3'h0 : _decodelist_T_241; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_243 = _decodelist_T_11 ? 3'h0 : _decodelist_T_242; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_244 = _decodelist_T_9 ? 3'h0 : _decodelist_T_243; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_245 = _decodelist_T_7 ? 3'h0 : _decodelist_T_244; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_246 = _decodelist_T_5 ? 3'h0 : _decodelist_T_245; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_247 = _decodelist_T_3 ? 3'h0 : _decodelist_T_246; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_248 = _decodelist_T_83 ? 3'h1 : 3'h4; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_249 = _decodelist_T_81 ? 3'h3 : _decodelist_T_248; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_250 = _decodelist_T_79 ? 3'h3 : _decodelist_T_249; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_251 = _decodelist_T_77 ? 3'h3 : _decodelist_T_250; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_252 = _decodelist_T_75 ? 3'h3 : _decodelist_T_251; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_253 = _decodelist_T_73 ? 3'h3 : _decodelist_T_252; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_254 = _decodelist_T_71 ? 3'h3 : _decodelist_T_253; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_255 = _decodelist_T_69 ? 3'h3 : _decodelist_T_254; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_256 = _decodelist_T_67 ? 3'h3 : _decodelist_T_255; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_257 = _decodelist_T_65 ? 3'h3 : _decodelist_T_256; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_258 = _decodelist_T_63 ? 3'h3 : _decodelist_T_257; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_259 = _decodelist_T_61 ? 3'h3 : _decodelist_T_258; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_260 = _decodelist_T_59 ? 3'h3 : _decodelist_T_259; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_261 = _decodelist_T_57 ? 3'h1 : _decodelist_T_260; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_262 = _decodelist_T_55 ? 3'h1 : _decodelist_T_261; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_263 = _decodelist_T_53 ? 3'h1 : _decodelist_T_262; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_264 = _decodelist_T_51 ? 3'h1 : _decodelist_T_263; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_265 = _decodelist_T_49 ? 3'h1 : _decodelist_T_264; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_266 = _decodelist_T_47 ? 3'h1 : _decodelist_T_265; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_267 = _decodelist_T_45 ? 3'h5 : _decodelist_T_266; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_268 = _decodelist_T_43 ? 3'h5 : _decodelist_T_267; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_269 = _decodelist_T_41 ? 3'h3 : _decodelist_T_268; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_270 = _decodelist_T_39 ? 3'h3 : _decodelist_T_269; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_271 = _decodelist_T_37 ? 3'h1 : _decodelist_T_270; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_272 = _decodelist_T_35 ? 3'h1 : _decodelist_T_271; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_273 = _decodelist_T_33 ? 3'h1 : _decodelist_T_272; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_274 = _decodelist_T_31 ? 3'h1 : _decodelist_T_273; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_275 = _decodelist_T_29 ? 3'h1 : _decodelist_T_274; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_276 = _decodelist_T_27 ? 3'h1 : _decodelist_T_275; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_277 = _decodelist_T_25 ? 3'h1 : _decodelist_T_276; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_278 = _decodelist_T_23 ? 3'h1 : _decodelist_T_277; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_279 = _decodelist_T_21 ? 3'h1 : _decodelist_T_278; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_280 = _decodelist_T_19 ? 3'h1 : _decodelist_T_279; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_281 = _decodelist_T_17 ? 3'h3 : _decodelist_T_280; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_282 = _decodelist_T_15 ? 3'h3 : _decodelist_T_281; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_283 = _decodelist_T_13 ? 3'h3 : _decodelist_T_282; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_284 = _decodelist_T_11 ? 3'h3 : _decodelist_T_283; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_285 = _decodelist_T_9 ? 3'h3 : _decodelist_T_284; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_286 = _decodelist_T_7 ? 3'h3 : _decodelist_T_285; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_287 = _decodelist_T_5 ? 3'h3 : _decodelist_T_286; // @[Lookup.scala 34:39]
  wire [2:0] _decodelist_T_288 = _decodelist_T_3 ? 3'h3 : _decodelist_T_287; // @[Lookup.scala 34:39]
  wire  _ResSrc_T_1 = io_from_ifu_bits_inst[6:0] == 7'h3; // @[dut.scala 579:20]
  wire  _ResSrc_T_3 = io_from_ifu_bits_inst[6:0] == 7'h73; // @[dut.scala 580:20]
  wire [1:0] _ResSrc_T_4 = _ResSrc_T_3 ? 2'h2 : 2'h0; // @[Mux.scala 101:16]
  wire [19:0] _ImmExt_T_2 = io_from_ifu_bits_inst[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _ImmExt_T_4 = {_ImmExt_T_2,io_from_ifu_bits_inst[31:20]}; // @[Cat.scala 33:92]
  wire [11:0] _ImmExt_T_7 = io_from_ifu_bits_inst[31] ? 12'hfff : 12'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _ImmExt_T_9 = {_ImmExt_T_7,io_from_ifu_bits_inst[31:12]}; // @[Cat.scala 33:92]
  wire [43:0] _ImmExt_T_10 = {_ImmExt_T_9, 12'h0}; // @[dut.scala 587:65]
  wire [10:0] _ImmExt_T_14 = io_from_ifu_bits_inst[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _ImmExt_T_19 = {_ImmExt_T_14,io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[19:12],io_from_ifu_bits_inst[
    20],io_from_ifu_bits_inst[30:21],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] _ImmExt_T_25 = {_ImmExt_T_2,io_from_ifu_bits_inst[31:25],io_from_ifu_bits_inst[11:7]}; // @[Cat.scala 33:92]
  wire [12:0] _ImmExt_T_30 = {io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[7],io_from_ifu_bits_inst[30:25],
    io_from_ifu_bits_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire  ImmExt_signBit = _ImmExt_T_30[12]; // @[dut.scala 182:20]
  wire [18:0] _ImmExt_T_32 = ImmExt_signBit ? 19'h7ffff : 19'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _ImmExt_T_33 = {_ImmExt_T_32,io_from_ifu_bits_inst[31],io_from_ifu_bits_inst[7],io_from_ifu_bits_inst[30:
    25],io_from_ifu_bits_inst[11:8],1'h0}; // @[Cat.scala 33:92]
  wire [31:0] _ImmExt_T_35 = 3'h4 == decodelist_0 ? _ImmExt_T_4 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _ImmExt_T_37 = 3'h6 == decodelist_0 ? _ImmExt_T_10[31:0] : _ImmExt_T_35; // @[Mux.scala 81:58]
  wire [31:0] _ImmExt_T_39 = 3'h7 == decodelist_0 ? _ImmExt_T_19 : _ImmExt_T_37; // @[Mux.scala 81:58]
  wire [31:0] _ImmExt_T_41 = 3'h2 == decodelist_0 ? _ImmExt_T_25 : _ImmExt_T_39; // @[Mux.scala 81:58]
  assign io_from_ifu_ready = ~io_from_ifu_valid | _io_from_ifu_ready_T_1; // @[dut.scala 67:56]
  assign io_to_isu_valid = io_from_ifu_valid; // @[dut.scala 68:40]
  assign io_to_isu_bits_cf_inst = io_from_ifu_bits_inst; // @[dut.scala 560:8]
  assign io_to_isu_bits_cf_pc = io_from_ifu_bits_pc; // @[dut.scala 560:8]
  assign io_to_isu_bits_cf_next_pc = io_from_ifu_bits_next_pc; // @[dut.scala 560:8]
  assign io_to_isu_bits_cf_isBranch = io_from_ifu_bits_isBranch; // @[dut.scala 560:8]
  assign io_to_isu_bits_ctrl_MemWrite = decodelist_0 == 3'h2; // @[dut.scala 575:19]
  assign io_to_isu_bits_ctrl_ResSrc = _ResSrc_T_1 ? 2'h1 : _ResSrc_T_4; // @[Mux.scala 101:16]
  assign io_to_isu_bits_ctrl_fuSrc1Type = _decodelist_T_1 ? 3'h0 : _decodelist_T_247; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_fuSrc2Type = _decodelist_T_1 ? 3'h3 : _decodelist_T_288; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_fuType = {{1'd0}, decodelist_1}; // @[dut.scala 569:17]
  assign io_to_isu_bits_ctrl_fuOpType = _decodelist_T_1 ? 7'h40 : _decodelist_T_206; // @[Lookup.scala 34:39]
  assign io_to_isu_bits_ctrl_rs1 = io_from_ifu_bits_inst[19:15]; // @[dut.scala 555:21]
  assign io_to_isu_bits_ctrl_rs2 = io_from_ifu_bits_inst[24:20]; // @[dut.scala 556:21]
  assign io_to_isu_bits_ctrl_rfWen = decodelist_0[2]; // @[dut.scala 289:54]
  assign io_to_isu_bits_ctrl_rd = io_from_ifu_bits_inst[11:7]; // @[dut.scala 554:20]
  assign io_to_isu_bits_data_imm = 3'h1 == decodelist_0 ? _ImmExt_T_33 : _ImmExt_T_41; // @[Mux.scala 81:58]
endmodule
module ISU_golden(
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
  output [2:0]  io_to_exu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_exu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
  output [4:0]  io_to_exu_bits_ctrl_rs1,
  output [4:0]  io_to_exu_bits_ctrl_rs2,
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
  reg [1:0] busy_1; // @[dut.scala 611:23]
  reg [1:0] busy_2; // @[dut.scala 611:23]
  reg [1:0] busy_3; // @[dut.scala 611:23]
  reg [1:0] busy_4; // @[dut.scala 611:23]
  reg [1:0] busy_5; // @[dut.scala 611:23]
  reg [1:0] busy_6; // @[dut.scala 611:23]
  reg [1:0] busy_7; // @[dut.scala 611:23]
  reg [1:0] busy_8; // @[dut.scala 611:23]
  reg [1:0] busy_9; // @[dut.scala 611:23]
  reg [1:0] busy_10; // @[dut.scala 611:23]
  reg [1:0] busy_11; // @[dut.scala 611:23]
  reg [1:0] busy_12; // @[dut.scala 611:23]
  reg [1:0] busy_13; // @[dut.scala 611:23]
  reg [1:0] busy_14; // @[dut.scala 611:23]
  reg [1:0] busy_15; // @[dut.scala 611:23]
  wire [1:0] _GEN_1 = 4'h1 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_1 : 2'h0; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_2 = 4'h2 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_2 : _GEN_1; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_3 = 4'h3 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_3 : _GEN_2; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_4 = 4'h4 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_4 : _GEN_3; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_5 = 4'h5 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_5 : _GEN_4; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_6 = 4'h6 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_6 : _GEN_5; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_7 = 4'h7 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_7 : _GEN_6; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_8 = 4'h8 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_8 : _GEN_7; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_9 = 4'h9 == io_from_idu_bits_ctrl_rs1[3:0] ? busy_9 : _GEN_8; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_10 = 4'ha == io_from_idu_bits_ctrl_rs1[3:0] ? busy_10 : _GEN_9; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_11 = 4'hb == io_from_idu_bits_ctrl_rs1[3:0] ? busy_11 : _GEN_10; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_12 = 4'hc == io_from_idu_bits_ctrl_rs1[3:0] ? busy_12 : _GEN_11; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_13 = 4'hd == io_from_idu_bits_ctrl_rs1[3:0] ? busy_13 : _GEN_12; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_14 = 4'he == io_from_idu_bits_ctrl_rs1[3:0] ? busy_14 : _GEN_13; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_15 = 4'hf == io_from_idu_bits_ctrl_rs1[3:0] ? busy_15 : _GEN_14; // @[dut.scala 612:{47,47}]
  wire  src1Busy = _GEN_15 != 2'h0; // @[dut.scala 612:47]
  wire [1:0] _GEN_17 = 4'h1 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_1 : 2'h0; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_18 = 4'h2 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_2 : _GEN_17; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_19 = 4'h3 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_3 : _GEN_18; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_20 = 4'h4 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_4 : _GEN_19; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_21 = 4'h5 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_5 : _GEN_20; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_22 = 4'h6 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_6 : _GEN_21; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_23 = 4'h7 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_7 : _GEN_22; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_24 = 4'h8 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_8 : _GEN_23; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_25 = 4'h9 == io_from_idu_bits_ctrl_rs2[3:0] ? busy_9 : _GEN_24; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_26 = 4'ha == io_from_idu_bits_ctrl_rs2[3:0] ? busy_10 : _GEN_25; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_27 = 4'hb == io_from_idu_bits_ctrl_rs2[3:0] ? busy_11 : _GEN_26; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_28 = 4'hc == io_from_idu_bits_ctrl_rs2[3:0] ? busy_12 : _GEN_27; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_29 = 4'hd == io_from_idu_bits_ctrl_rs2[3:0] ? busy_13 : _GEN_28; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_30 = 4'he == io_from_idu_bits_ctrl_rs2[3:0] ? busy_14 : _GEN_29; // @[dut.scala 612:{47,47}]
  wire [1:0] _GEN_31 = 4'hf == io_from_idu_bits_ctrl_rs2[3:0] ? busy_15 : _GEN_30; // @[dut.scala 612:{47,47}]
  wire  src2Busy = _GEN_31 != 2'h0; // @[dut.scala 612:47]
  wire  AnyInvalidCondition = src1Busy | src2Busy; // @[dut.scala 649:32]
  wire  _io_from_idu_ready_T_1 = io_to_exu_ready & io_to_exu_valid; // @[Decoupled.scala 51:35]
  wire [31:0] _io_to_exu_bits_data_fuSrc1_T_1 = 3'h0 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_reg_rfSrc1 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_to_exu_bits_data_fuSrc1_T_3 = 3'h2 == io_from_idu_bits_ctrl_fuSrc1Type ? io_from_idu_bits_cf_pc :
    _io_to_exu_bits_data_fuSrc1_T_1; // @[Mux.scala 81:58]
  wire [31:0] _io_to_exu_bits_data_fuSrc2_T_1 = 3'h1 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_reg_rfSrc2 : 32'h0; // @[Mux.scala 81:58]
  wire [31:0] _io_to_exu_bits_data_fuSrc2_T_3 = 3'h3 == io_from_idu_bits_ctrl_fuSrc2Type ? io_from_idu_bits_data_imm :
    _io_to_exu_bits_data_fuSrc2_T_1; // @[Mux.scala 81:58]
  wire [46:0] _wbuClearMask_T = 47'h1 << io_wb_rd; // @[dut.scala 613:50]
  wire [15:0] wbuClearMask = io_wb_RegWrite ? _wbuClearMask_T[15:0] : 16'h0; // @[dut.scala 687:28]
  wire [46:0] _isFireSetMask_T_2 = 47'h1 << io_from_idu_bits_ctrl_rd; // @[dut.scala 613:50]
  wire [15:0] isFireSetMask = io_from_idu_bits_ctrl_rfWen & _io_from_idu_ready_T_1 ? _isFireSetMask_T_2[15:0] : 16'h0; // @[dut.scala 688:28]
  wire [1:0] _busy_1_T_2 = busy_1 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_1_T_6 = busy_1 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_1_T_7 = busy_1 == 2'h0 ? 2'h0 : _busy_1_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_2_T_2 = busy_2 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_2_T_6 = busy_2 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_2_T_7 = busy_2 == 2'h0 ? 2'h0 : _busy_2_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_3_T_2 = busy_3 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_3_T_6 = busy_3 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_3_T_7 = busy_3 == 2'h0 ? 2'h0 : _busy_3_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_4_T_2 = busy_4 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_4_T_6 = busy_4 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_4_T_7 = busy_4 == 2'h0 ? 2'h0 : _busy_4_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_5_T_2 = busy_5 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_5_T_6 = busy_5 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_5_T_7 = busy_5 == 2'h0 ? 2'h0 : _busy_5_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_6_T_2 = busy_6 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_6_T_6 = busy_6 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_6_T_7 = busy_6 == 2'h0 ? 2'h0 : _busy_6_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_7_T_2 = busy_7 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_7_T_6 = busy_7 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_7_T_7 = busy_7 == 2'h0 ? 2'h0 : _busy_7_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_8_T_2 = busy_8 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_8_T_6 = busy_8 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_8_T_7 = busy_8 == 2'h0 ? 2'h0 : _busy_8_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_9_T_2 = busy_9 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_9_T_6 = busy_9 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_9_T_7 = busy_9 == 2'h0 ? 2'h0 : _busy_9_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_10_T_2 = busy_10 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_10_T_6 = busy_10 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_10_T_7 = busy_10 == 2'h0 ? 2'h0 : _busy_10_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_11_T_2 = busy_11 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_11_T_6 = busy_11 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_11_T_7 = busy_11 == 2'h0 ? 2'h0 : _busy_11_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_12_T_2 = busy_12 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_12_T_6 = busy_12 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_12_T_7 = busy_12 == 2'h0 ? 2'h0 : _busy_12_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_13_T_2 = busy_13 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_13_T_6 = busy_13 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_13_T_7 = busy_13 == 2'h0 ? 2'h0 : _busy_13_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_14_T_2 = busy_14 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_14_T_6 = busy_14 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_14_T_7 = busy_14 == 2'h0 ? 2'h0 : _busy_14_T_6; // @[dut.scala 622:33]
  wire [1:0] _busy_15_T_2 = busy_15 + 2'h1; // @[dut.scala 620:82]
  wire [1:0] _busy_15_T_6 = busy_15 - 2'h1; // @[dut.scala 622:68]
  wire [1:0] _busy_15_T_7 = busy_15 == 2'h0 ? 2'h0 : _busy_15_T_6; // @[dut.scala 622:33]
  assign io_from_idu_ready = ~io_from_idu_valid | _io_from_idu_ready_T_1; // @[dut.scala 67:56]
  assign io_to_exu_valid = io_from_idu_valid & ~AnyInvalidCondition; // @[dut.scala 68:40]
  assign io_to_exu_bits_cf_inst = io_from_idu_bits_cf_inst; // @[dut.scala 661:16]
  assign io_to_exu_bits_cf_pc = io_from_idu_bits_cf_pc; // @[dut.scala 661:16]
  assign io_to_exu_bits_cf_next_pc = io_from_idu_bits_cf_next_pc; // @[dut.scala 661:16]
  assign io_to_exu_bits_cf_isBranch = io_from_idu_bits_cf_isBranch; // @[dut.scala 661:16]
  assign io_to_exu_bits_ctrl_MemWrite = io_from_idu_bits_ctrl_MemWrite; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_ResSrc = io_from_idu_bits_ctrl_ResSrc; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_fuSrc1Type = io_from_idu_bits_ctrl_fuSrc1Type; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_fuSrc2Type = io_from_idu_bits_ctrl_fuSrc2Type; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_fuType = io_from_idu_bits_ctrl_fuType; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_fuOpType = io_from_idu_bits_ctrl_fuOpType; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_rs1 = io_from_idu_bits_ctrl_rs1; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_rs2 = io_from_idu_bits_ctrl_rs2; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_rfWen = io_from_idu_bits_ctrl_rfWen; // @[dut.scala 662:18]
  assign io_to_exu_bits_ctrl_rd = io_from_idu_bits_ctrl_rd; // @[dut.scala 662:18]
  assign io_to_exu_bits_data_fuSrc1 = 3'h4 == io_from_idu_bits_ctrl_fuSrc1Type ? 32'h0 : _io_to_exu_bits_data_fuSrc1_T_3
    ; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_fuSrc2 = 3'h5 == io_from_idu_bits_ctrl_fuSrc2Type ? 32'h4 : _io_to_exu_bits_data_fuSrc2_T_3
    ; // @[Mux.scala 81:58]
  assign io_to_exu_bits_data_imm = io_from_idu_bits_data_imm; // @[dut.scala 664:18]
  assign io_to_exu_bits_data_rfSrc1 = io_from_reg_rfSrc1; // @[dut.scala 667:25]
  assign io_to_exu_bits_data_rfSrc2 = io_from_reg_rfSrc2; // @[dut.scala 668:25]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 611:23]
      busy_1 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[1] & wbuClearMask[1])) begin // @[dut.scala 617:50]
      if (isFireSetMask[1]) begin // @[dut.scala 619:38]
        if (busy_1 == 2'h3) begin // @[dut.scala 620:33]
          busy_1 <= 2'h3;
        end else begin
          busy_1 <= _busy_1_T_2;
        end
      end else if (wbuClearMask[1]) begin // @[dut.scala 621:40]
        busy_1 <= _busy_1_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_2 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[2] & wbuClearMask[2])) begin // @[dut.scala 617:50]
      if (isFireSetMask[2]) begin // @[dut.scala 619:38]
        if (busy_2 == 2'h3) begin // @[dut.scala 620:33]
          busy_2 <= 2'h3;
        end else begin
          busy_2 <= _busy_2_T_2;
        end
      end else if (wbuClearMask[2]) begin // @[dut.scala 621:40]
        busy_2 <= _busy_2_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_3 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[3] & wbuClearMask[3])) begin // @[dut.scala 617:50]
      if (isFireSetMask[3]) begin // @[dut.scala 619:38]
        if (busy_3 == 2'h3) begin // @[dut.scala 620:33]
          busy_3 <= 2'h3;
        end else begin
          busy_3 <= _busy_3_T_2;
        end
      end else if (wbuClearMask[3]) begin // @[dut.scala 621:40]
        busy_3 <= _busy_3_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_4 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[4] & wbuClearMask[4])) begin // @[dut.scala 617:50]
      if (isFireSetMask[4]) begin // @[dut.scala 619:38]
        if (busy_4 == 2'h3) begin // @[dut.scala 620:33]
          busy_4 <= 2'h3;
        end else begin
          busy_4 <= _busy_4_T_2;
        end
      end else if (wbuClearMask[4]) begin // @[dut.scala 621:40]
        busy_4 <= _busy_4_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_5 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[5] & wbuClearMask[5])) begin // @[dut.scala 617:50]
      if (isFireSetMask[5]) begin // @[dut.scala 619:38]
        if (busy_5 == 2'h3) begin // @[dut.scala 620:33]
          busy_5 <= 2'h3;
        end else begin
          busy_5 <= _busy_5_T_2;
        end
      end else if (wbuClearMask[5]) begin // @[dut.scala 621:40]
        busy_5 <= _busy_5_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_6 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[6] & wbuClearMask[6])) begin // @[dut.scala 617:50]
      if (isFireSetMask[6]) begin // @[dut.scala 619:38]
        if (busy_6 == 2'h3) begin // @[dut.scala 620:33]
          busy_6 <= 2'h3;
        end else begin
          busy_6 <= _busy_6_T_2;
        end
      end else if (wbuClearMask[6]) begin // @[dut.scala 621:40]
        busy_6 <= _busy_6_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_7 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[7] & wbuClearMask[7])) begin // @[dut.scala 617:50]
      if (isFireSetMask[7]) begin // @[dut.scala 619:38]
        if (busy_7 == 2'h3) begin // @[dut.scala 620:33]
          busy_7 <= 2'h3;
        end else begin
          busy_7 <= _busy_7_T_2;
        end
      end else if (wbuClearMask[7]) begin // @[dut.scala 621:40]
        busy_7 <= _busy_7_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_8 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[8] & wbuClearMask[8])) begin // @[dut.scala 617:50]
      if (isFireSetMask[8]) begin // @[dut.scala 619:38]
        if (busy_8 == 2'h3) begin // @[dut.scala 620:33]
          busy_8 <= 2'h3;
        end else begin
          busy_8 <= _busy_8_T_2;
        end
      end else if (wbuClearMask[8]) begin // @[dut.scala 621:40]
        busy_8 <= _busy_8_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_9 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[9] & wbuClearMask[9])) begin // @[dut.scala 617:50]
      if (isFireSetMask[9]) begin // @[dut.scala 619:38]
        if (busy_9 == 2'h3) begin // @[dut.scala 620:33]
          busy_9 <= 2'h3;
        end else begin
          busy_9 <= _busy_9_T_2;
        end
      end else if (wbuClearMask[9]) begin // @[dut.scala 621:40]
        busy_9 <= _busy_9_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_10 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[10] & wbuClearMask[10])) begin // @[dut.scala 617:50]
      if (isFireSetMask[10]) begin // @[dut.scala 619:38]
        if (busy_10 == 2'h3) begin // @[dut.scala 620:33]
          busy_10 <= 2'h3;
        end else begin
          busy_10 <= _busy_10_T_2;
        end
      end else if (wbuClearMask[10]) begin // @[dut.scala 621:40]
        busy_10 <= _busy_10_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_11 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[11] & wbuClearMask[11])) begin // @[dut.scala 617:50]
      if (isFireSetMask[11]) begin // @[dut.scala 619:38]
        if (busy_11 == 2'h3) begin // @[dut.scala 620:33]
          busy_11 <= 2'h3;
        end else begin
          busy_11 <= _busy_11_T_2;
        end
      end else if (wbuClearMask[11]) begin // @[dut.scala 621:40]
        busy_11 <= _busy_11_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_12 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[12] & wbuClearMask[12])) begin // @[dut.scala 617:50]
      if (isFireSetMask[12]) begin // @[dut.scala 619:38]
        if (busy_12 == 2'h3) begin // @[dut.scala 620:33]
          busy_12 <= 2'h3;
        end else begin
          busy_12 <= _busy_12_T_2;
        end
      end else if (wbuClearMask[12]) begin // @[dut.scala 621:40]
        busy_12 <= _busy_12_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_13 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[13] & wbuClearMask[13])) begin // @[dut.scala 617:50]
      if (isFireSetMask[13]) begin // @[dut.scala 619:38]
        if (busy_13 == 2'h3) begin // @[dut.scala 620:33]
          busy_13 <= 2'h3;
        end else begin
          busy_13 <= _busy_13_T_2;
        end
      end else if (wbuClearMask[13]) begin // @[dut.scala 621:40]
        busy_13 <= _busy_13_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_14 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[14] & wbuClearMask[14])) begin // @[dut.scala 617:50]
      if (isFireSetMask[14]) begin // @[dut.scala 619:38]
        if (busy_14 == 2'h3) begin // @[dut.scala 620:33]
          busy_14 <= 2'h3;
        end else begin
          busy_14 <= _busy_14_T_2;
        end
      end else if (wbuClearMask[14]) begin // @[dut.scala 621:40]
        busy_14 <= _busy_14_T_7; // @[dut.scala 622:27]
      end
    end
    if (reset) begin // @[dut.scala 611:23]
      busy_15 <= 2'h0; // @[dut.scala 611:23]
    end else if (!(isFireSetMask[15] & wbuClearMask[15])) begin // @[dut.scala 617:50]
      if (isFireSetMask[15]) begin // @[dut.scala 619:38]
        if (busy_15 == 2'h3) begin // @[dut.scala 620:33]
          busy_15 <= 2'h3;
        end else begin
          busy_15 <= _busy_15_T_2;
        end
      end else if (wbuClearMask[15]) begin // @[dut.scala 621:40]
        busy_15 <= _busy_15_T_7; // @[dut.scala 622:27]
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
module frontend_golden(
  input         clock,
  input         reset,
  input         io_redirect,
  input  [31:0] io_inst,
  output [31:0] io_pc,
  input  [31:0] io_ifuredirect_target,
  input         io_ifuredirect_valid,
  input         io_to_exu_ready,
  output        io_to_exu_valid,
  output [31:0] io_to_exu_bits_cf_inst,
  output [31:0] io_to_exu_bits_cf_pc,
  output [31:0] io_to_exu_bits_cf_next_pc,
  output        io_to_exu_bits_cf_isBranch,
  output        io_to_exu_bits_ctrl_MemWrite,
  output [1:0]  io_to_exu_bits_ctrl_ResSrc,
  output [2:0]  io_to_exu_bits_ctrl_fuSrc1Type,
  output [2:0]  io_to_exu_bits_ctrl_fuSrc2Type,
  output [2:0]  io_to_exu_bits_ctrl_fuType,
  output [6:0]  io_to_exu_bits_ctrl_fuOpType,
  output [4:0]  io_to_exu_bits_ctrl_rs1,
  output [4:0]  io_to_exu_bits_ctrl_rs2,
  output        io_to_exu_bits_ctrl_rfWen,
  output [4:0]  io_to_exu_bits_ctrl_rd,
  output [31:0] io_to_exu_bits_data_fuSrc1,
  output [31:0] io_to_exu_bits_data_fuSrc2,
  output [31:0] io_to_exu_bits_data_imm,
  output        io_to_exu_bits_data_Alu0Res_ready,
  output        io_to_exu_bits_data_Alu0Res_valid,
  output [31:0] io_to_exu_bits_data_Alu0Res_bits,
  output [31:0] io_to_exu_bits_data_data_from_mem,
  output [31:0] io_to_exu_bits_data_csrRdata,
  output [31:0] io_to_exu_bits_data_rfSrc1,
  output [31:0] io_to_exu_bits_data_rfSrc2,
  input  [4:0]  io_wb_rd,
  input  [31:0] io_wb_Res,
  input         io_wb_RegWrite,
  input  [31:0] io_rfSrc1,
  input  [31:0] io_rfSrc2,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2
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
`endif // RANDOMIZE_REG_INIT
  wire  ifu_clock; // @[dut.scala 712:21]
  wire  ifu_reset; // @[dut.scala 712:21]
  wire [31:0] ifu_io_inst; // @[dut.scala 712:21]
  wire [31:0] ifu_io_pc; // @[dut.scala 712:21]
  wire  ifu_io_to_idu_ready; // @[dut.scala 712:21]
  wire [31:0] ifu_io_to_idu_bits_inst; // @[dut.scala 712:21]
  wire [31:0] ifu_io_to_idu_bits_pc; // @[dut.scala 712:21]
  wire [31:0] ifu_io_to_idu_bits_next_pc; // @[dut.scala 712:21]
  wire  ifu_io_to_idu_bits_isBranch; // @[dut.scala 712:21]
  wire [31:0] ifu_io_redirect_target; // @[dut.scala 712:21]
  wire  ifu_io_redirect_valid; // @[dut.scala 712:21]
  wire  idu_io_from_ifu_ready; // @[dut.scala 713:21]
  wire  idu_io_from_ifu_valid; // @[dut.scala 713:21]
  wire [31:0] idu_io_from_ifu_bits_inst; // @[dut.scala 713:21]
  wire [31:0] idu_io_from_ifu_bits_pc; // @[dut.scala 713:21]
  wire [31:0] idu_io_from_ifu_bits_next_pc; // @[dut.scala 713:21]
  wire  idu_io_from_ifu_bits_isBranch; // @[dut.scala 713:21]
  wire  idu_io_to_isu_ready; // @[dut.scala 713:21]
  wire  idu_io_to_isu_valid; // @[dut.scala 713:21]
  wire [31:0] idu_io_to_isu_bits_cf_inst; // @[dut.scala 713:21]
  wire [31:0] idu_io_to_isu_bits_cf_pc; // @[dut.scala 713:21]
  wire [31:0] idu_io_to_isu_bits_cf_next_pc; // @[dut.scala 713:21]
  wire  idu_io_to_isu_bits_cf_isBranch; // @[dut.scala 713:21]
  wire  idu_io_to_isu_bits_ctrl_MemWrite; // @[dut.scala 713:21]
  wire [1:0] idu_io_to_isu_bits_ctrl_ResSrc; // @[dut.scala 713:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[dut.scala 713:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[dut.scala 713:21]
  wire [2:0] idu_io_to_isu_bits_ctrl_fuType; // @[dut.scala 713:21]
  wire [6:0] idu_io_to_isu_bits_ctrl_fuOpType; // @[dut.scala 713:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs1; // @[dut.scala 713:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rs2; // @[dut.scala 713:21]
  wire  idu_io_to_isu_bits_ctrl_rfWen; // @[dut.scala 713:21]
  wire [4:0] idu_io_to_isu_bits_ctrl_rd; // @[dut.scala 713:21]
  wire [31:0] idu_io_to_isu_bits_data_imm; // @[dut.scala 713:21]
  wire  isu_clock; // @[dut.scala 714:21]
  wire  isu_reset; // @[dut.scala 714:21]
  wire  isu_io_from_idu_ready; // @[dut.scala 714:21]
  wire  isu_io_from_idu_valid; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_idu_bits_cf_inst; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_idu_bits_cf_pc; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_idu_bits_cf_next_pc; // @[dut.scala 714:21]
  wire  isu_io_from_idu_bits_cf_isBranch; // @[dut.scala 714:21]
  wire  isu_io_from_idu_bits_ctrl_MemWrite; // @[dut.scala 714:21]
  wire [1:0] isu_io_from_idu_bits_ctrl_ResSrc; // @[dut.scala 714:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc1Type; // @[dut.scala 714:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuSrc2Type; // @[dut.scala 714:21]
  wire [2:0] isu_io_from_idu_bits_ctrl_fuType; // @[dut.scala 714:21]
  wire [6:0] isu_io_from_idu_bits_ctrl_fuOpType; // @[dut.scala 714:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs1; // @[dut.scala 714:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rs2; // @[dut.scala 714:21]
  wire  isu_io_from_idu_bits_ctrl_rfWen; // @[dut.scala 714:21]
  wire [4:0] isu_io_from_idu_bits_ctrl_rd; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_idu_bits_data_imm; // @[dut.scala 714:21]
  wire  isu_io_to_exu_ready; // @[dut.scala 714:21]
  wire  isu_io_to_exu_valid; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_cf_inst; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_cf_pc; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_cf_next_pc; // @[dut.scala 714:21]
  wire  isu_io_to_exu_bits_cf_isBranch; // @[dut.scala 714:21]
  wire  isu_io_to_exu_bits_ctrl_MemWrite; // @[dut.scala 714:21]
  wire [1:0] isu_io_to_exu_bits_ctrl_ResSrc; // @[dut.scala 714:21]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuSrc1Type; // @[dut.scala 714:21]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuSrc2Type; // @[dut.scala 714:21]
  wire [2:0] isu_io_to_exu_bits_ctrl_fuType; // @[dut.scala 714:21]
  wire [6:0] isu_io_to_exu_bits_ctrl_fuOpType; // @[dut.scala 714:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rs1; // @[dut.scala 714:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rs2; // @[dut.scala 714:21]
  wire  isu_io_to_exu_bits_ctrl_rfWen; // @[dut.scala 714:21]
  wire [4:0] isu_io_to_exu_bits_ctrl_rd; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc1; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_data_fuSrc2; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_data_imm; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc1; // @[dut.scala 714:21]
  wire [31:0] isu_io_to_exu_bits_data_rfSrc2; // @[dut.scala 714:21]
  wire [4:0] isu_io_wb_rd; // @[dut.scala 714:21]
  wire  isu_io_wb_RegWrite; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_reg_rfSrc1; // @[dut.scala 714:21]
  wire [31:0] isu_io_from_reg_rfSrc2; // @[dut.scala 714:21]
  wire  _T = idu_io_to_isu_ready & idu_io_to_isu_valid; // @[Decoupled.scala 51:35]
  reg  valid; // @[dut.scala 49:26]
  wire  _T_1 = idu_io_from_ifu_ready; // @[dut.scala 51:29]
  wire  _GEN_0 = _T ? 1'h0 : valid; // @[dut.scala 52:{38,45} 53:25]
  wire  _GEN_1 = idu_io_from_ifu_ready | _GEN_0; // @[dut.scala 51:{44,51}]
  reg [31:0] idu_io_from_ifu_bits_r_inst; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_pc; // @[Reg.scala 19:16]
  reg [31:0] idu_io_from_ifu_bits_r_next_pc; // @[Reg.scala 19:16]
  reg  idu_io_from_ifu_bits_r_isBranch; // @[Reg.scala 19:16]
  wire  _T_2 = isu_io_to_exu_ready & isu_io_to_exu_valid; // @[Decoupled.scala 51:35]
  reg  valid_1; // @[dut.scala 49:26]
  wire  _isu_io_from_idu_bits_T = idu_io_to_isu_valid & isu_io_from_idu_ready; // @[dut.scala 58:53]
  reg [31:0] isu_io_from_idu_bits_r_cf_inst; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_pc; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_cf_next_pc; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_cf_isBranch; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_MemWrite; // @[Reg.scala 19:16]
  reg [1:0] isu_io_from_idu_bits_r_ctrl_ResSrc; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[Reg.scala 19:16]
  reg [2:0] isu_io_from_idu_bits_r_ctrl_fuType; // @[Reg.scala 19:16]
  reg [6:0] isu_io_from_idu_bits_r_ctrl_fuOpType; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs1; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rs2; // @[Reg.scala 19:16]
  reg  isu_io_from_idu_bits_r_ctrl_rfWen; // @[Reg.scala 19:16]
  reg [4:0] isu_io_from_idu_bits_r_ctrl_rd; // @[Reg.scala 19:16]
  reg [31:0] isu_io_from_idu_bits_r_data_imm; // @[Reg.scala 19:16]
  IFU_golden ifu ( // @[dut.scala 712:21]
    .clock(ifu_clock),
    .reset(ifu_reset),
    .io_inst(ifu_io_inst),
    .io_pc(ifu_io_pc),
    .io_to_idu_ready(ifu_io_to_idu_ready),
    .io_to_idu_bits_inst(ifu_io_to_idu_bits_inst),
    .io_to_idu_bits_pc(ifu_io_to_idu_bits_pc),
    .io_to_idu_bits_next_pc(ifu_io_to_idu_bits_next_pc),
    .io_to_idu_bits_isBranch(ifu_io_to_idu_bits_isBranch),
    .io_redirect_target(ifu_io_redirect_target),
    .io_redirect_valid(ifu_io_redirect_valid)
  );
  IDU_golden idu ( // @[dut.scala 713:21]
    .io_from_ifu_ready(idu_io_from_ifu_ready),
    .io_from_ifu_valid(idu_io_from_ifu_valid),
    .io_from_ifu_bits_inst(idu_io_from_ifu_bits_inst),
    .io_from_ifu_bits_pc(idu_io_from_ifu_bits_pc),
    .io_from_ifu_bits_next_pc(idu_io_from_ifu_bits_next_pc),
    .io_from_ifu_bits_isBranch(idu_io_from_ifu_bits_isBranch),
    .io_to_isu_ready(idu_io_to_isu_ready),
    .io_to_isu_valid(idu_io_to_isu_valid),
    .io_to_isu_bits_cf_inst(idu_io_to_isu_bits_cf_inst),
    .io_to_isu_bits_cf_pc(idu_io_to_isu_bits_cf_pc),
    .io_to_isu_bits_cf_next_pc(idu_io_to_isu_bits_cf_next_pc),
    .io_to_isu_bits_cf_isBranch(idu_io_to_isu_bits_cf_isBranch),
    .io_to_isu_bits_ctrl_MemWrite(idu_io_to_isu_bits_ctrl_MemWrite),
    .io_to_isu_bits_ctrl_ResSrc(idu_io_to_isu_bits_ctrl_ResSrc),
    .io_to_isu_bits_ctrl_fuSrc1Type(idu_io_to_isu_bits_ctrl_fuSrc1Type),
    .io_to_isu_bits_ctrl_fuSrc2Type(idu_io_to_isu_bits_ctrl_fuSrc2Type),
    .io_to_isu_bits_ctrl_fuType(idu_io_to_isu_bits_ctrl_fuType),
    .io_to_isu_bits_ctrl_fuOpType(idu_io_to_isu_bits_ctrl_fuOpType),
    .io_to_isu_bits_ctrl_rs1(idu_io_to_isu_bits_ctrl_rs1),
    .io_to_isu_bits_ctrl_rs2(idu_io_to_isu_bits_ctrl_rs2),
    .io_to_isu_bits_ctrl_rfWen(idu_io_to_isu_bits_ctrl_rfWen),
    .io_to_isu_bits_ctrl_rd(idu_io_to_isu_bits_ctrl_rd),
    .io_to_isu_bits_data_imm(idu_io_to_isu_bits_data_imm)
  );
  ISU_golden isu ( // @[dut.scala 714:21]
    .clock(isu_clock),
    .reset(isu_reset),
    .io_from_idu_ready(isu_io_from_idu_ready),
    .io_from_idu_valid(isu_io_from_idu_valid),
    .io_from_idu_bits_cf_inst(isu_io_from_idu_bits_cf_inst),
    .io_from_idu_bits_cf_pc(isu_io_from_idu_bits_cf_pc),
    .io_from_idu_bits_cf_next_pc(isu_io_from_idu_bits_cf_next_pc),
    .io_from_idu_bits_cf_isBranch(isu_io_from_idu_bits_cf_isBranch),
    .io_from_idu_bits_ctrl_MemWrite(isu_io_from_idu_bits_ctrl_MemWrite),
    .io_from_idu_bits_ctrl_ResSrc(isu_io_from_idu_bits_ctrl_ResSrc),
    .io_from_idu_bits_ctrl_fuSrc1Type(isu_io_from_idu_bits_ctrl_fuSrc1Type),
    .io_from_idu_bits_ctrl_fuSrc2Type(isu_io_from_idu_bits_ctrl_fuSrc2Type),
    .io_from_idu_bits_ctrl_fuType(isu_io_from_idu_bits_ctrl_fuType),
    .io_from_idu_bits_ctrl_fuOpType(isu_io_from_idu_bits_ctrl_fuOpType),
    .io_from_idu_bits_ctrl_rs1(isu_io_from_idu_bits_ctrl_rs1),
    .io_from_idu_bits_ctrl_rs2(isu_io_from_idu_bits_ctrl_rs2),
    .io_from_idu_bits_ctrl_rfWen(isu_io_from_idu_bits_ctrl_rfWen),
    .io_from_idu_bits_ctrl_rd(isu_io_from_idu_bits_ctrl_rd),
    .io_from_idu_bits_data_imm(isu_io_from_idu_bits_data_imm),
    .io_to_exu_ready(isu_io_to_exu_ready),
    .io_to_exu_valid(isu_io_to_exu_valid),
    .io_to_exu_bits_cf_inst(isu_io_to_exu_bits_cf_inst),
    .io_to_exu_bits_cf_pc(isu_io_to_exu_bits_cf_pc),
    .io_to_exu_bits_cf_next_pc(isu_io_to_exu_bits_cf_next_pc),
    .io_to_exu_bits_cf_isBranch(isu_io_to_exu_bits_cf_isBranch),
    .io_to_exu_bits_ctrl_MemWrite(isu_io_to_exu_bits_ctrl_MemWrite),
    .io_to_exu_bits_ctrl_ResSrc(isu_io_to_exu_bits_ctrl_ResSrc),
    .io_to_exu_bits_ctrl_fuSrc1Type(isu_io_to_exu_bits_ctrl_fuSrc1Type),
    .io_to_exu_bits_ctrl_fuSrc2Type(isu_io_to_exu_bits_ctrl_fuSrc2Type),
    .io_to_exu_bits_ctrl_fuType(isu_io_to_exu_bits_ctrl_fuType),
    .io_to_exu_bits_ctrl_fuOpType(isu_io_to_exu_bits_ctrl_fuOpType),
    .io_to_exu_bits_ctrl_rs1(isu_io_to_exu_bits_ctrl_rs1),
    .io_to_exu_bits_ctrl_rs2(isu_io_to_exu_bits_ctrl_rs2),
    .io_to_exu_bits_ctrl_rfWen(isu_io_to_exu_bits_ctrl_rfWen),
    .io_to_exu_bits_ctrl_rd(isu_io_to_exu_bits_ctrl_rd),
    .io_to_exu_bits_data_fuSrc1(isu_io_to_exu_bits_data_fuSrc1),
    .io_to_exu_bits_data_fuSrc2(isu_io_to_exu_bits_data_fuSrc2),
    .io_to_exu_bits_data_imm(isu_io_to_exu_bits_data_imm),
    .io_to_exu_bits_data_rfSrc1(isu_io_to_exu_bits_data_rfSrc1),
    .io_to_exu_bits_data_rfSrc2(isu_io_to_exu_bits_data_rfSrc2),
    .io_wb_rd(isu_io_wb_rd),
    .io_wb_RegWrite(isu_io_wb_RegWrite),
    .io_from_reg_rfSrc1(isu_io_from_reg_rfSrc1),
    .io_from_reg_rfSrc2(isu_io_from_reg_rfSrc2)
  );
  assign io_pc = ifu_io_pc; // @[dut.scala 717:17]
  assign io_to_exu_valid = isu_io_to_exu_valid; // @[dut.scala 719:17]
  assign io_to_exu_bits_cf_inst = isu_io_to_exu_bits_cf_inst; // @[dut.scala 719:17]
  assign io_to_exu_bits_cf_pc = isu_io_to_exu_bits_cf_pc; // @[dut.scala 719:17]
  assign io_to_exu_bits_cf_next_pc = isu_io_to_exu_bits_cf_next_pc; // @[dut.scala 719:17]
  assign io_to_exu_bits_cf_isBranch = isu_io_to_exu_bits_cf_isBranch; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_MemWrite = isu_io_to_exu_bits_ctrl_MemWrite; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_ResSrc = isu_io_to_exu_bits_ctrl_ResSrc; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_fuSrc1Type = isu_io_to_exu_bits_ctrl_fuSrc1Type; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_fuSrc2Type = isu_io_to_exu_bits_ctrl_fuSrc2Type; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_fuType = isu_io_to_exu_bits_ctrl_fuType; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_fuOpType = isu_io_to_exu_bits_ctrl_fuOpType; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_rs1 = isu_io_to_exu_bits_ctrl_rs1; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_rs2 = isu_io_to_exu_bits_ctrl_rs2; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_rfWen = isu_io_to_exu_bits_ctrl_rfWen; // @[dut.scala 719:17]
  assign io_to_exu_bits_ctrl_rd = isu_io_to_exu_bits_ctrl_rd; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_fuSrc1 = isu_io_to_exu_bits_data_fuSrc1; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_fuSrc2 = isu_io_to_exu_bits_data_fuSrc2; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_imm = isu_io_to_exu_bits_data_imm; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_Alu0Res_ready = 1'h0; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_Alu0Res_valid = 1'h0; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_Alu0Res_bits = 32'h0; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_data_from_mem = 32'h0; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_csrRdata = 32'h0; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_rfSrc1 = isu_io_to_exu_bits_data_rfSrc1; // @[dut.scala 719:17]
  assign io_to_exu_bits_data_rfSrc2 = isu_io_to_exu_bits_data_rfSrc2; // @[dut.scala 719:17]
  assign io_rs1 = isu_io_to_exu_bits_ctrl_rs1; // @[dut.scala 722:12]
  assign io_rs2 = isu_io_to_exu_bits_ctrl_rs2; // @[dut.scala 723:12]
  assign ifu_clock = clock;
  assign ifu_reset = reset;
  assign ifu_io_inst = io_inst; // @[dut.scala 716:17]
  assign ifu_io_to_idu_ready = idu_io_from_ifu_ready; // @[dut.scala 56:18]
  assign ifu_io_redirect_target = io_ifuredirect_target; // @[dut.scala 718:21]
  assign ifu_io_redirect_valid = io_ifuredirect_valid; // @[dut.scala 718:21]
  assign idu_io_from_ifu_valid = valid; // @[dut.scala 55:19]
  assign idu_io_from_ifu_bits_inst = idu_io_from_ifu_bits_r_inst; // @[dut.scala 58:18]
  assign idu_io_from_ifu_bits_pc = idu_io_from_ifu_bits_r_pc; // @[dut.scala 58:18]
  assign idu_io_from_ifu_bits_next_pc = idu_io_from_ifu_bits_r_next_pc; // @[dut.scala 58:18]
  assign idu_io_from_ifu_bits_isBranch = idu_io_from_ifu_bits_r_isBranch; // @[dut.scala 58:18]
  assign idu_io_to_isu_ready = isu_io_from_idu_ready; // @[dut.scala 56:18]
  assign isu_clock = clock;
  assign isu_reset = reset;
  assign isu_io_from_idu_valid = valid_1; // @[dut.scala 55:19]
  assign isu_io_from_idu_bits_cf_inst = isu_io_from_idu_bits_r_cf_inst; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_cf_pc = isu_io_from_idu_bits_r_cf_pc; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_cf_next_pc = isu_io_from_idu_bits_r_cf_next_pc; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_cf_isBranch = isu_io_from_idu_bits_r_cf_isBranch; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_MemWrite = isu_io_from_idu_bits_r_ctrl_MemWrite; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_ResSrc = isu_io_from_idu_bits_r_ctrl_ResSrc; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc1Type = isu_io_from_idu_bits_r_ctrl_fuSrc1Type; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_fuSrc2Type = isu_io_from_idu_bits_r_ctrl_fuSrc2Type; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_fuType = isu_io_from_idu_bits_r_ctrl_fuType; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_fuOpType = isu_io_from_idu_bits_r_ctrl_fuOpType; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_rs1 = isu_io_from_idu_bits_r_ctrl_rs1; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_rs2 = isu_io_from_idu_bits_r_ctrl_rs2; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_rfWen = isu_io_from_idu_bits_r_ctrl_rfWen; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_ctrl_rd = isu_io_from_idu_bits_r_ctrl_rd; // @[dut.scala 58:18]
  assign isu_io_from_idu_bits_data_imm = isu_io_from_idu_bits_r_data_imm; // @[dut.scala 58:18]
  assign isu_io_to_exu_ready = io_to_exu_ready; // @[dut.scala 719:17]
  assign isu_io_wb_rd = io_wb_rd; // @[dut.scala 720:17]
  assign isu_io_wb_RegWrite = io_wb_RegWrite; // @[dut.scala 720:17]
  assign isu_io_from_reg_rfSrc1 = io_rfSrc1; // @[dut.scala 655:32]
  assign isu_io_from_reg_rfSrc2 = io_rfSrc2; // @[dut.scala 656:32]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 49:26]
      valid <= 1'h0; // @[dut.scala 49:26]
    end else if (io_redirect) begin // @[dut.scala 50:21]
      valid <= 1'h0; // @[dut.scala 50:28]
    end else begin
      valid <= _GEN_1;
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_inst <= ifu_io_to_idu_bits_inst; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_pc <= ifu_io_to_idu_bits_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_next_pc <= ifu_io_to_idu_bits_next_pc; // @[Reg.scala 20:22]
    end
    if (_T_1) begin // @[Reg.scala 20:18]
      idu_io_from_ifu_bits_r_isBranch <= ifu_io_to_idu_bits_isBranch; // @[Reg.scala 20:22]
    end
    if (reset) begin // @[dut.scala 49:26]
      valid_1 <= 1'h0; // @[dut.scala 49:26]
    end else if (io_redirect) begin // @[dut.scala 50:21]
      valid_1 <= 1'h0; // @[dut.scala 50:28]
    end else if (isu_io_from_idu_ready & idu_io_to_isu_valid) begin // @[dut.scala 51:44]
      valid_1 <= idu_io_to_isu_valid; // @[dut.scala 51:51]
    end else if (_T_2) begin // @[dut.scala 52:38]
      valid_1 <= 1'h0; // @[dut.scala 52:45]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_inst <= idu_io_to_isu_bits_cf_inst; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_pc <= idu_io_to_isu_bits_cf_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_next_pc <= idu_io_to_isu_bits_cf_next_pc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_cf_isBranch <= idu_io_to_isu_bits_cf_isBranch; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_MemWrite <= idu_io_to_isu_bits_ctrl_MemWrite; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_ResSrc <= idu_io_to_isu_bits_ctrl_ResSrc; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc1Type <= idu_io_to_isu_bits_ctrl_fuSrc1Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuSrc2Type <= idu_io_to_isu_bits_ctrl_fuSrc2Type; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuType <= idu_io_to_isu_bits_ctrl_fuType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_fuOpType <= idu_io_to_isu_bits_ctrl_fuOpType; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs1 <= idu_io_to_isu_bits_ctrl_rs1; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rs2 <= idu_io_to_isu_bits_ctrl_rs2; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rfWen <= idu_io_to_isu_bits_ctrl_rfWen; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_ctrl_rd <= idu_io_to_isu_bits_ctrl_rd; // @[Reg.scala 20:22]
    end
    if (_isu_io_from_idu_bits_T) begin // @[Reg.scala 20:18]
      isu_io_from_idu_bits_r_data_imm <= idu_io_to_isu_bits_data_imm; // @[Reg.scala 20:22]
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
  valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_inst = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_next_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  idu_io_from_ifu_bits_r_isBranch = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  valid_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_inst = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_pc = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_next_pc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_cf_isBranch = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_MemWrite = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_ResSrc = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc1Type = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuSrc2Type = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuType = _RAND_14[2:0];
  _RAND_15 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_fuOpType = _RAND_15[6:0];
  _RAND_16 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs1 = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rs2 = _RAND_17[4:0];
  _RAND_18 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rfWen = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_ctrl_rd = _RAND_19[4:0];
  _RAND_20 = {1{`RANDOM}};
  isu_io_from_idu_bits_r_data_imm = _RAND_20[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule


