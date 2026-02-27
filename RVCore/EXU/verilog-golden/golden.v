
`timescale 1ns/1ps

// ================================================================
// Utility functions: sign/zero extend (Verilog-2001 style via funcs)
// ================================================================
module exu_golden #(
  parameter XLEN = 32
)(
  input  wire                 clock,
  input  wire                 reset,

  // ---------------- from_isu (Decoupled DecodeIO, flattened) ----------------
  input  wire                 from_isu_valid,
  output wire                 from_isu_ready,

  // CtrlFlow
  input  wire [31:0]          from_isu_cf_inst,
  input  wire [XLEN-1:0]      from_isu_cf_pc,
  input  wire [XLEN-1:0]      from_isu_cf_next_pc,
  input  wire                 from_isu_cf_isBranch,

  // CtrlSignal
  input  wire                 from_isu_ctrl_MemWrite,
  input  wire [2:0]           from_isu_ctrl_ResSrc,
  input  wire [2:0]           from_isu_ctrl_fuSrc1Type,
  input  wire [2:0]           from_isu_ctrl_fuSrc2Type,
  input  wire [2:0]           from_isu_ctrl_fuType,      // FuType: alu=0, lsu=1, mdu=2, csr=3, mou=4 (as in your object)
  input  wire [6:0]           from_isu_ctrl_fuOpType,
  input  wire [4:0]           from_isu_ctrl_rs1,
  input  wire [4:0]           from_isu_ctrl_rs2,
  input  wire                 from_isu_ctrl_rfWen,
  input  wire [4:0]           from_isu_ctrl_rd,

  // DataSrc
  input  wire [XLEN-1:0]      from_isu_data_fuSrc1,
  input  wire [XLEN-1:0]      from_isu_data_fuSrc2,
  input  wire [XLEN-1:0]      from_isu_data_imm,
  input  wire [XLEN-1:0]      from_isu_data_rfSrc1,
  input  wire [XLEN-1:0]      from_isu_data_rfSrc2,

  // ---------------- to_wbu (Decoupled ExuToWbuIO, flattened) ----------------
  output wire                 to_wbu_valid,
  input  wire                 to_wbu_ready,

  // CtrlFlow out
  output wire [31:0]          to_wbu_cf_inst,
  output wire [XLEN-1:0]      to_wbu_cf_pc,
  output wire [XLEN-1:0]      to_wbu_cf_next_pc,
  output wire                 to_wbu_cf_isBranch,

  // CtrlSignal out (pass-through)
  output wire                 to_wbu_ctrl_MemWrite,
  output wire [2:0]           to_wbu_ctrl_ResSrc,
  output wire [2:0]           to_wbu_ctrl_fuSrc1Type,
  output wire [2:0]           to_wbu_ctrl_fuSrc2Type,
  output wire [2:0]           to_wbu_ctrl_fuType,
  output wire [6:0]           to_wbu_ctrl_fuOpType,
  output wire [4:0]           to_wbu_ctrl_rs1,
  output wire [4:0]           to_wbu_ctrl_rs2,
  output wire                 to_wbu_ctrl_rfWen,
  output wire [4:0]           to_wbu_ctrl_rd,

  // DataSrc out (pass-through + computed fields)
  output wire [XLEN-1:0]      to_wbu_data_fuSrc1,
  output wire [XLEN-1:0]      to_wbu_data_fuSrc2,
  output wire [XLEN-1:0]      to_wbu_data_imm,
  output wire [XLEN-1:0]      to_wbu_data_rfSrc1,
  output wire [XLEN-1:0]      to_wbu_data_rfSrc2,
  output wire [XLEN-1:0]      to_wbu_data_Alu0Res_bits,
  output wire [XLEN-1:0]      to_wbu_data_data_from_mem,
  output wire [XLEN-1:0]      to_wbu_data_csrRdata,

  // ---------------- memory interface ----------------
  output wire [XLEN-1:0]      to_mem_data,
  output wire [XLEN-1:0]      to_mem_addr,
  output wire [7:0]           to_mem_Wmask,
  output wire                 to_mem_MemWrite,

  input  wire [XLEN-1:0]      from_mem_data,

  // ---------------- redirect ----------------
  output wire                 redirect_valid,
  output wire [XLEN-1:0]      redirect_target
);

  // ============================================================
  // Localparams matching your FuType object (with IndependentBru=false)
  // ============================================================
  localparam [2:0] FUTYPE_ALU = 3'b000;
  localparam [2:0] FUTYPE_LSU = 3'b001;
  localparam [2:0] FUTYPE_MDU = 3'b010;
  localparam [2:0] FUTYPE_CSR = 3'b011;
  localparam [2:0] FUTYPE_MOU = 3'b100;

  // ============================================================
  // Instantiate ALU
  // ============================================================
  wire alu_in_valid  = from_isu_valid && (from_isu_ctrl_fuType == FUTYPE_ALU);
  wire alu_in_ready;
  wire alu_out_valid;
  wire alu_out_ready = to_wbu_ready;  // as in Chisel: alu0.io.out.ready := out.ready
  wire [XLEN-1:0] alu_out_bits;
  wire alu_taken;

  alu_golden #(.XLEN(XLEN)) u_alu (
    .clock(clock),
    .reset(reset),
    .in_valid(alu_in_valid),
    .in_ready(alu_in_ready),
    .in_srca(from_isu_data_fuSrc1),
    .in_srcb(from_isu_data_fuSrc2),
    .in_fuOpType(from_isu_ctrl_fuOpType),
    .out_valid(alu_out_valid),
    .out_ready(alu_out_ready),
    .out_bits(alu_out_bits),
    .taken(alu_taken)
  );

  // ============================================================
  // Instantiate LSU
  // ============================================================
  wire lsu_in_valid  = from_isu_valid && (from_isu_ctrl_fuType == FUTYPE_LSU);
  wire lsu_in_ready;
  wire lsu_out_valid;
  wire lsu_out_ready = to_wbu_ready;
  wire [XLEN-1:0] lsu_out_bits;

  lsu_golden #(.XLEN(XLEN)) u_lsu (
    .clock(clock),
    .reset(reset),
    .in_valid(lsu_in_valid),
    .in_ready(lsu_in_ready),
    .in_srca(from_isu_data_fuSrc1),
    .in_srcb(from_isu_data_fuSrc2),
    .in_fuOpType(from_isu_ctrl_fuOpType),

    .ctrl_MemWrite(from_isu_ctrl_MemWrite),
    .data_rfSrc2(from_isu_data_rfSrc2),

    .from_mem_data(from_mem_data),

    .out_valid(lsu_out_valid),
    .out_ready(lsu_out_ready),
    .out_bits(lsu_out_bits),

    .to_mem_data(to_mem_data),
    .to_mem_addr(to_mem_addr),
    .to_mem_Wmask(to_mem_Wmask),
    .to_mem_MemWrite(to_mem_MemWrite)
  );

  // ============================================================
  // Instantiate CSR
  // ============================================================
  // In Chisel, csr0.access(valid && fuType==csr, ...) drives internal io.in fields.
  wire csr_access_valid = from_isu_valid && (from_isu_ctrl_fuType == FUTYPE_CSR);

  wire [XLEN-1:0] csr_out_bits;
  wire csr_jmp;

  csr_golden #(.XLEN(XLEN)) u_csr (
    .clock(clock),
    .reset(reset),

    .access_valid(csr_access_valid),
    .srca(from_isu_data_fuSrc1),
    .srcb(from_isu_data_fuSrc2),         // csrIndex comes from srcb in your CSR_golden
    .fuOpType(from_isu_ctrl_fuOpType),

    .cf_inst(from_isu_cf_inst),
    .cf_pc(from_isu_cf_pc),

    .jmp(csr_jmp),
    .out_bits(csr_out_bits)
  );

  // ============================================================
  // Branch/redirect logic (matches your EXU_golden)
  // ============================================================
  wire is_jalr = (from_isu_cf_inst[6:0] == 7'b1100111);
  wire is_b    = (from_isu_cf_inst[6:0] == 7'b1100011);

  wire jalrBru_valid = from_isu_valid && from_isu_cf_isBranch && is_jalr;
  wire [XLEN-1:0] jalrBru_target =
      (from_isu_data_rfSrc1 + from_isu_data_imm) & (~{{(XLEN-1){1'b0}},1'b1});

  wire typebBru_valid = from_isu_valid && from_isu_cf_isBranch && is_b;
  wire [XLEN-1:0] pcIfBranch = from_isu_cf_pc + from_isu_data_imm;
  wire [XLEN-1:0] typebBru_target = alu_taken ? pcIfBranch : (from_isu_cf_pc + {{(XLEN-3){1'b0}},3'b100});

  wire csrBru_valid = from_isu_valid && csr_jmp;
  wire [XLEN-1:0] csrBru_target = csr_out_bits;

  wire bru_valid = jalrBru_valid | typebBru_valid | csrBru_valid;
  wire [XLEN-1:0] bru_target =
      jalrBru_valid ? jalrBru_target :
      typebBru_valid ? typebBru_target :
      csrBru_valid ? csrBru_target :
      {XLEN{1'b0}};

  wire predict_error = (bru_target != from_isu_cf_next_pc);

  assign redirect_valid  = from_isu_valid && bru_valid && predict_error;
  assign redirect_target = bru_target;

  wire [XLEN-1:0] cf_next_pc_fixed = bru_valid ? bru_target : from_isu_cf_next_pc;

  // ============================================================
  // HandShakeDeal equivalent:
  // consumer.ready := ((!consumer.valid) || producer.fire) && !stop
  // producer.valid := consumer.valid && !invalid
  //
  // Here: consumer=from_isu, producer=to_wbu
  // AnyInvalidCondition=false
  // AnyStopCondition = isRedirect && in.valid
  // ============================================================
  wire any_stop = redirect_valid && from_isu_valid;

  assign to_wbu_valid   = from_isu_valid && !1'b0;
  assign from_isu_ready = ((!from_isu_valid) || (to_wbu_valid && to_wbu_ready)) && (!any_stop);

  // ============================================================
  // Output bundle wiring (pass-through + computed)
  // ============================================================
  assign to_wbu_cf_inst     = from_isu_cf_inst;
  assign to_wbu_cf_pc       = from_isu_cf_pc;
  assign to_wbu_cf_next_pc  = cf_next_pc_fixed;
  assign to_wbu_cf_isBranch = from_isu_cf_isBranch;

  assign to_wbu_ctrl_MemWrite   = from_isu_ctrl_MemWrite;
  assign to_wbu_ctrl_ResSrc     = from_isu_ctrl_ResSrc;
  assign to_wbu_ctrl_fuSrc1Type = from_isu_ctrl_fuSrc1Type;
  assign to_wbu_ctrl_fuSrc2Type = from_isu_ctrl_fuSrc2Type;
  assign to_wbu_ctrl_fuType     = from_isu_ctrl_fuType;
  assign to_wbu_ctrl_fuOpType   = from_isu_ctrl_fuOpType;
  assign to_wbu_ctrl_rs1        = from_isu_ctrl_rs1;
  assign to_wbu_ctrl_rs2        = from_isu_ctrl_rs2;
  assign to_wbu_ctrl_rfWen      = from_isu_ctrl_rfWen;
  assign to_wbu_ctrl_rd         = from_isu_ctrl_rd;

  assign to_wbu_data_fuSrc1 = from_isu_data_fuSrc1;
  assign to_wbu_data_fuSrc2 = from_isu_data_fuSrc2;
  assign to_wbu_data_imm    = from_isu_data_imm;
  assign to_wbu_data_rfSrc1 = from_isu_data_rfSrc1;
  assign to_wbu_data_rfSrc2 = from_isu_data_rfSrc2;

  // Matches your code: out.bits.data.Alu0Res.bits := alu0.io.out.bits
  assign to_wbu_data_Alu0Res_bits = alu_out_bits;

  // Matches your code: out.bits.data.data_from_mem := lsu0.io.out.bits
  assign to_wbu_data_data_from_mem = lsu_out_bits;

  // Matches your code: out.bits.data.csrRdata := csr0Out
  assign to_wbu_data_csrRdata = csr_out_bits;

endmodule

// ============================================================================
// ALU_golden (from your Chisel; XLEN assumed 32 here; word-op handling kept)
// ============================================================================
module alu_golden #(
  parameter XLEN = 32
)(
  input  wire                 clock,
  input  wire                 reset,

  input  wire                 in_valid,
  output wire                 in_ready,
  input  wire [XLEN-1:0]      in_srca,
  input  wire [XLEN-1:0]      in_srcb,
  input  wire [6:0]           in_fuOpType,

  output wire                 out_valid,
  input  wire                 out_ready,
  output wire [XLEN-1:0]      out_bits,

  output wire                 taken
);
  // In Chisel: io.in.ready := true.B; io.out.valid := io.in.valid
  assign in_ready  = 1'b1;
  assign out_valid = in_valid;

  // ALUOpType helpers (bitfields match your Scala)
  wire isAdd    = in_fuOpType[6];
  wire isWordOp = in_fuOpType[5];
  wire isBranchInvert = in_fuOpType[0];
  wire [1:0] branchType = in_fuOpType[2:1];

  wire isAdderSub = ~isAdd;

  wire [XLEN:0] adderRes =
      {1'b0,in_srca} + {1'b0,(in_srcb ^ {XLEN{isAdderSub}})} + {{XLEN{1'b0}},isAdderSub};

  wire [XLEN-1:0] xorRes = in_srca ^ in_srcb;
  wire sltu = ~adderRes[XLEN];
  wire slt  = xorRes[XLEN-1] ^ sltu;

  // shift source adjustments for word ops (as in Chisel; for XLEN=32, mostly no-op)
  wire [XLEN-1:0] shsrc1 = in_srca;

  wire [4:0] shamt = in_srcb[4:0];

  // Main op mux
  reg [XLEN-1:0] res;
  always @(*) begin
    // default: adderRes low XLEN bits
    res = adderRes[XLEN-1:0];
    case (in_fuOpType)
      7'b0000001: res = (shsrc1 << shamt);
      7'b0000010: res = {{(XLEN-1){1'b0}}, slt};
      7'b0000011: res = {{(XLEN-1){1'b0}}, sltu};
      7'b0000100: res = xorRes;
      7'b0000101: res = (shsrc1 >> shamt);
      7'b0000110: res = (in_srca | in_srcb);
      7'b0000111: res = (in_srca & in_srcb);
      7'b0001101: res = $signed(shsrc1) >>> shamt;
      default:    res = adderRes[XLEN-1:0];
    endcase
  end

  // Word-op sign-extend behavior in your Chisel uses 64-bit hardcode; for XLEN=32 it is just res.
  assign out_bits = res;

  // Branch taken logic (matches your Chisel table)
  // beq branchType == getBranchType(beq)=00 : !xorRes.orR
  // blt branchType == 10 : slt
  // bltu branchType==11 : sltu
  reg base_taken;
  always @(*) begin
    base_taken = 1'b0;
    case (branchType)
      2'b00: base_taken = ~(|xorRes);
      2'b10: base_taken = slt;
      2'b11: base_taken = sltu;
      default: base_taken = 1'b0;
    endcase
  end

  assign taken = base_taken ^ isBranchInvert;

endmodule

// ============================================================================
// LSU_golden
// ============================================================================
module lsu_golden #(
  parameter XLEN = 32
)(
  input  wire                 clock,
  input  wire                 reset,

  input  wire                 in_valid,
  output wire                 in_ready,
  input  wire [XLEN-1:0]      in_srca,
  input  wire [XLEN-1:0]      in_srcb,
  input  wire [6:0]           in_fuOpType,

  input  wire                 ctrl_MemWrite,
  input  wire [XLEN-1:0]      data_rfSrc2,

  input  wire [XLEN-1:0]      from_mem_data,

  output wire                 out_valid,
  input  wire                 out_ready,
  output reg  [XLEN-1:0]      out_bits,

  output wire [XLEN-1:0]      to_mem_data,
  output wire [XLEN-1:0]      to_mem_addr,
  output reg  [7:0]           to_mem_Wmask,
  output wire                 to_mem_MemWrite
);
  assign in_ready  = 1'b1;
  assign out_valid = in_valid;

  assign to_mem_data = data_rfSrc2;
  assign to_mem_addr = in_srca + in_srcb;

  always @(*) begin
    to_mem_Wmask = 8'h00;
    case (in_fuOpType)
      7'b0001000: to_mem_Wmask = 8'h01; // sb
      7'b0001001: to_mem_Wmask = 8'h03; // sh
      7'b0001010: to_mem_Wmask = 8'h0f; // sw
      7'b0001011: to_mem_Wmask = 8'hff; // sd (unused for XLEN=32)
      default:    to_mem_Wmask = 8'h00;
    endcase
  end

  assign to_mem_MemWrite = ctrl_MemWrite;

  // Load data formatting
  always @(*) begin
    out_bits = {XLEN{1'b0}};
    case (in_fuOpType)
      7'b0000000: out_bits = {{(XLEN-8){from_mem_data[7]}},  from_mem_data[7:0]};   // lb
      7'b0000001: out_bits = {{(XLEN-16){from_mem_data[15]}}, from_mem_data[15:0]};  // lh
      7'b0000010: out_bits = {{(XLEN-32){from_mem_data[31]}}, from_mem_data[31:0]};  // lw
      7'b0000100: out_bits = {{(XLEN-8){1'b0}},  from_mem_data[7:0]};                // lbu
      7'b0000101: out_bits = {{(XLEN-16){1'b0}}, from_mem_data[15:0]};               // lhu
      7'b0000110: out_bits = {{(XLEN-32){1'b0}}, from_mem_data[31:0]};               // lwu
      default:    out_bits = {XLEN{1'b0}};
    endcase
  end

endmodule

// ============================================================================
// CSR_golden
// Notes:
// - Implements only mtvec/mcause/mepc/mstatus as in your code
// - csrIndex := srcb (full XLEN), only low 12 bits are meaningful
// - ecall/mret/ebreak decode matches your bitstrings
// ============================================================================
module csr_golden #(
  parameter XLEN = 32
)(
  input  wire                 clock,
  input  wire                 reset,

  input  wire                 access_valid,
  input  wire [XLEN-1:0]      srca,
  input  wire [XLEN-1:0]      srcb,
  input  wire [6:0]           fuOpType,

  input  wire [31:0]          cf_inst,
  input  wire [XLEN-1:0]      cf_pc,

  output wire                 jmp,
  output reg  [XLEN-1:0]      out_bits
);

  // CSR addresses
  localparam [11:0] MTVEC   = 12'h305;
  localparam [11:0] MCAUSE  = 12'h342;
  localparam [11:0] MEPC    = 12'h341;
  localparam [11:0] MSTATUS = 12'h300;

  // CSROpType
  localparam [2:0] CSROP_JMP = 3'b000;
  localparam [2:0] CSROP_WRT = 3'b001;
  localparam [2:0] CSROP_SET = 3'b010;
  localparam [2:0] CSROP_CLR = 3'b011;

  // Exception codes used
  localparam [XLEN-1:0] ECALL_M = 11;

  reg [XLEN-1:0] mtvec, mcause, mepc, mstatus;

  wire [11:0] csrIndex = srcb[11:0];

  wire isEcall  = (cf_inst == 32'b000000000000_00000_000_00000_1110011);
  wire isMret   = (cf_inst == 32'b0011000_00010_00000_000_00000_1110011);
  wire isEbreak = (cf_inst == 32'b000000000001_00000_000_00000_1110011);

  // Read mux
  reg [XLEN-1:0] csr_rdata;
  always @(*) begin
    csr_rdata = {XLEN{1'b0}};
    case (csrIndex)
      MTVEC:   csr_rdata = mtvec;
      MCAUSE:  csr_rdata = mcause;
      MEPC:    csr_rdata = mepc;
      MSTATUS: csr_rdata = mstatus;
      default: csr_rdata = {XLEN{1'b0}};
    endcase
  end

  // Write data mux
  reg [XLEN-1:0] csr_update;
  always @(*) begin
    csr_update = {XLEN{1'b0}};
    case (fuOpType[2:0])
      CSROP_WRT: csr_update = srca;
      CSROP_SET: csr_update = (srca | csr_rdata);
      CSROP_CLR: csr_update = ((~srca) & csr_rdata);
      default:   csr_update = {XLEN{1'b0}};
    endcase
  end

  wire csrWen = access_valid && (fuOpType[2:0] != CSROP_JMP);

  always @(posedge clock) begin
    if (reset) begin
      mtvec   <= {XLEN{1'b0}};
      mcause  <= {XLEN{1'b0}};
      mepc    <= {XLEN{1'b0}};
      // Chisel init: if XLEN==64 "ha00001800" else "h00001800"
      mstatus <= (XLEN==64) ? 64'ha00001800 : 32'h00001800;
    end else begin
      if (csrWen) begin
        if (csrIndex == MTVEC)   mtvec   <= csr_update;
        if (csrIndex == MCAUSE)  mcause  <= csr_update;
        if (csrIndex == MEPC)    mepc    <= csr_update;
        if (csrIndex == MSTATUS) mstatus <= csr_update;
      end

      // ecall behavior in your code:
      // when(csrWen === false.B && valid === true.B && isEcall ) { mcause:=ecallM; mepc:=pc }
      if (!csrWen && access_valid && isEcall) begin
        mcause <= ECALL_M;
        mepc   <= cf_pc;
      end
    end
  end

  assign jmp = access_valid && (fuOpType[2:0] == CSROP_JMP) && !isEbreak;

  // Output selection in your code:
  // io.out.bits := MuxCase(csr, Array((isEcall)->mtvec, (isMret)->mepc))
  always @(*) begin
    out_bits = csr_rdata;
    if (isEcall) out_bits = mtvec;
    if (isMret)  out_bits = mepc;
  end

endmodule

