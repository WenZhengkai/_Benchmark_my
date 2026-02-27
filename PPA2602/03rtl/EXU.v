Below is a **straightforward (non-pipelined) Verilog** implementation that matches the *functional intent* of your Chisel `EXU_golden` + `ALU_golden` + `LSU_golden` + `CSR_golden` (single-cycle style, always-ready, `out.valid` follows `in.valid`, memory assumed “combinational response” via `from_mem.data` like your LSU code).

Important notes (matching your Chisel behavior):
- `from_isu.ready` is forced like your design effectively does (`true` unless redirect-stop). Here I implement the same “stop on redirect” behavior.
- `to_wbu.valid` is `from_isu.valid` (but forced low when redirect-stop is active, similar to `HandShakeDeal` with `AnyStopCondition`).
- `redirect.valid` asserted when a *valid* branch/jalr/csr-jump target differs from `cf.next_pc`.
- LSU uses `from_mem.data` directly and does sign/zero extend based on `fuOpType`.
- CSR supports `mtvec/mcause/mepc/mstatus`, ecall, mret, and CSR wrt/set/clr; `jmp` outputs mtvec on ecall, mepc on mret, csr read otherwise. `io.jmp` true when `fuOpType==CSROpType.jmp` and not ebreak.

Because your Chisel bundles are large, I’m expressing the top module ports as **flattened signals** (common for Verilog). If you want a SystemVerilog `struct`-based port style, tell me.

---

## Verilog: EXU_golden top + submodules

```verilog
// ============================================================
// Minimal Verilog translation of Chisel EXU_golden + ALU/LSU/CSR
// Assumptions:
// - XLEN = 32
// - LSU memory response is immediate via from_mem_data
// - Decoupled semantics simplified (single-cycle style)
// ============================================================

module ALU_golden #(
  parameter XLEN = 32
)(
  input  wire              in_valid,
  output wire              in_ready,
  input  wire [XLEN-1:0]   srca,
  input  wire [XLEN-1:0]   srcb,
  input  wire [6:0]        fuOpType,   // ALUOpType encoding as in Chisel
  output wire              out_valid,
  input  wire              out_ready,
  output wire [XLEN-1:0]   out_bits,
  output wire              taken
);

  assign in_ready  = 1'b1;
  assign out_valid = in_valid;

  // helpers from Chisel
  wire isAdd      = fuOpType[6];
  wire isWordOp   = fuOpType[5];

  // adder/sub
  wire isSub = ~isAdd;
  wire [XLEN-1:0] srcb_xor = srcb ^ {XLEN{isSub}};
  wire [XLEN:0]   adderRes = {1'b0, srca} + {1'b0, srcb_xor} + {{XLEN{1'b0}}, isSub};

  wire [XLEN-1:0] xorRes = srca ^ srcb;
  wire sltu = ~adderRes[XLEN]; // !carry/borrow in this style, matches Chisel
  wire slt  = xorRes[XLEN-1] ^ sltu;

  // shift source adjustments (only used for word ops in 64-bit in Chisel; XLEN=32 here)
  wire [XLEN-1:0] shsrc1 = srca;

  wire [4:0] shamt = srcb[4:0];

  // main op select (MuxLookup)
  reg [XLEN-1:0] res;
  always @(*) begin
    res = adderRes[XLEN-1:0];
    case (fuOpType)
      7'b0000001: res = (shsrc1 << shamt);                         // sll
      7'b0000010: res = {{(XLEN-1){1'b0}}, slt};                   // slt
      7'b0000011: res = {{(XLEN-1){1'b0}}, sltu};                  // sltu
      7'b0000100: res = xorRes;                                    // xor
      7'b0000101: res = (shsrc1 >> shamt);                         // srl
      7'b0000110: res = (srca | srcb);                             // or
      7'b0000111: res = (srca & srcb);                             // and
      7'b0001101: res = ($signed(shsrc1) >>> shamt);               // sra
      default:    res = adderRes[XLEN-1:0];
    endcase
  end

  // WordOp sign extension (Chisel sign-extends res(31,0) to 64 when XLEN=64).
  // Here XLEN=32, so unchanged.
  assign out_bits = res;

  // Branch taken logic (Chisel uses branchType = fuOpType[2:1], invert = fuOpType[0], isBranch = !fuOpType[3])
  wire isBranch    = ~fuOpType[3];
  wire [1:0] brTyp = fuOpType[2:1];
  wire brInv       = fuOpType[0];

  reg brBase;
  always @(*) begin
    brBase = 1'b0;
    case (brTyp)
      2'b00: brBase = ~(|xorRes); // beq
      2'b10: brBase = slt;        // blt
      2'b11: brBase = sltu;       // bltu
      default: brBase = 1'b0;
    endcase
  end

  assign taken = (isBranch ? (brBase ^ brInv) : 1'b0);

endmodule


module LSU_golden #(
  parameter XLEN = 32
)(
  input  wire              in_valid,
  output wire              in_ready,
  input  wire [XLEN-1:0]   srca,
  input  wire [XLEN-1:0]   srcb,
  input  wire [6:0]        fuOpType,      // LSUOpType encoding subset used
  input  wire              ctrl_MemWrite,
  input  wire [XLEN-1:0]   data_rfSrc2,    // store data

  // memory interface
  output wire [XLEN-1:0]   to_mem_data,
  output wire [XLEN-1:0]   to_mem_addr,
  output wire [7:0]        to_mem_Wmask,
  output wire              to_mem_MemWrite,
  input  wire [XLEN-1:0]   from_mem_data,

  // output (load result)
  output wire              out_valid,
  input  wire              out_ready,
  output wire [XLEN-1:0]   out_bits
);

  assign in_ready  = 1'b1;
  assign out_valid = in_valid;

  assign to_mem_data     = data_rfSrc2;
  assign to_mem_addr     = srca + srcb;
  assign to_mem_MemWrite = ctrl_MemWrite;

  // Wmask (sb/sh/sw/sd)
  reg [7:0] wmask;
  always @(*) begin
    wmask = 8'h00;
    case (fuOpType)
      7'b0001000: wmask = 8'h01; // sb
      7'b0001001: wmask = 8'h03; // sh
      7'b0001010: wmask = 8'h0f; // sw
      7'b0001011: wmask = 8'hff; // sd (unused in XLEN=32 but kept)
      default:    wmask = 8'h00;
    endcase
  end
  assign to_mem_Wmask = wmask;

  // load sign/zero extend
  function [XLEN-1:0] sext8(input [7:0] v);  begin sext8  = {{(XLEN-8){v[7]}},  v}; end endfunction
  function [XLEN-1:0] sext16(input [15:0] v);begin sext16 = {{(XLEN-16){v[15]}}, v}; end endfunction
  function [XLEN-1:0] sext32(input [31:0] v);begin sext32 = v[31:0]; end endfunction

  function [XLEN-1:0] zext8(input [7:0] v);  begin zext8  = {{(XLEN-8){1'b0}},  v}; end endfunction
  function [XLEN-1:0] zext16(input [15:0] v);begin zext16 = {{(XLEN-16){1'b0}}, v}; end endfunction
  function [XLEN-1:0] zext32(input [31:0] v);begin zext32 = v[31:0]; end endfunction

  reg [XLEN-1:0] loadRes;
  always @(*) begin
    loadRes = {XLEN{1'b0}};
    case (fuOpType)
      7'b0000000: loadRes = sext8(from_mem_data[7:0]);      // lb
      7'b0000001: loadRes = sext16(from_mem_data[15:0]);    // lh
      7'b0000010: loadRes = sext32(from_mem_data[31:0]);    // lw
      7'b0000100: loadRes = zext8(from_mem_data[7:0]);      // lbu
      7'b0000101: loadRes = zext16(from_mem_data[15:0]);    // lhu
      7'b0000110: loadRes = zext32(from_mem_data[31:0]);    // lwu
      default:    loadRes = {XLEN{1'b0}};
    endcase
  end

  assign out_bits = loadRes;

endmodule


module CSR_golden #(
  parameter XLEN = 32
)(
  input  wire              clk,
  input  wire              rst_n,

  input  wire              in_valid,
  output wire              in_ready,
  input  wire [XLEN-1:0]   srca,
  input  wire [XLEN-1:0]   srcb,        // csrIndex in your Chisel
  input  wire [6:0]        fuOpType,     // uses CSROpType values in low 3 bits; kept 7 wide for simplicity

  input  wire [31:0]       cf_inst,
  input  wire [XLEN-1:0]   cf_pc,

  output wire              out_valid,
  input  wire              out_ready,
  output wire [XLEN-1:0]   out_bits,
  output wire              jmp
);

  // CSR constants used
  localparam [11:0] MTVEC   = 12'h305;
  localparam [11:0] MCAUSE  = 12'h342;
  localparam [11:0] MEPC    = 12'h341;
  localparam [11:0] MSTATUS = 12'h300;

  // CSROpType (3-bit)
  localparam [2:0] CSROP_JMP = 3'b000;
  localparam [2:0] CSROP_WRT = 3'b001;
  localparam [2:0] CSROP_SET = 3'b010;
  localparam [2:0] CSROP_CLR = 3'b011;

  // Exception encodings used
  localparam [XLEN-1:0] ECALL_M = 32'd11;

  assign in_ready  = 1'b1;
  assign out_valid = in_valid;

  // registers
  reg [XLEN-1:0] mtvec, mcause, mepc, mstatus;

  // init
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      mtvec   <= {XLEN{1'b0}};
      mcause  <= {XLEN{1'b0}};
      mepc    <= {XLEN{1'b0}};
      mstatus <= 32'h00001800;
    end else begin
      // decode special inst
      wire isEcall   = (cf_inst == 32'b000000000000_00000_000_00000_1110011);
      wire isMret    = (cf_inst == 32'b0011000_00010_00000_000_00000_1110011);
      wire isEbreak  = (cf_inst == 32'b000000000001_00000_000_00000_1110011);

      // csr index
      wire [11:0] csrIndex = srcb[11:0];

      // current csr read
      reg [XLEN-1:0] csrR;
      always @(*) begin
        csrR = {XLEN{1'b0}};
        case (csrIndex)
          MTVEC:   csrR = mtvec;
          MCAUSE:  csrR = mcause;
          MEPC:    csrR = mepc;
          MSTATUS: csrR = mstatus;
          default: csrR = {XLEN{1'b0}};
        endcase
      end

      // update value
      reg [XLEN-1:0] csrUpdate;
      always @(*) begin
        csrUpdate = {XLEN{1'b0}};
        case (fuOpType[2:0])
          CSROP_WRT: csrUpdate = srca;
          CSROP_SET: csrUpdate = (srca | csrR);
          CSROP_CLR: csrUpdate = (~srca & csrR);
          default:   csrUpdate = {XLEN{1'b0}};
        endcase
      end

      wire csrWen = in_valid && (fuOpType[2:0] != CSROP_JMP);

      if (csrWen) begin
        if (csrIndex == MTVEC)   mtvec   <= csrUpdate;
        if (csrIndex == MCAUSE)  mcause  <= csrUpdate;
        if (csrIndex == MEPC)    mepc    <= csrUpdate;
        if (csrIndex == MSTATUS) mstatus <= csrUpdate;
      end

      // ecall side effects when csrWen == false and valid and isEcall
      if (!csrWen && in_valid && isEcall) begin
        mcause <= ECALL_M;
        mepc   <= cf_pc;
      end
    end
  end

  // combinational outputs
  wire isEcall  = (cf_inst == 32'b000000000000_00000_000_00000_1110011);
  wire isMret   = (cf_inst == 32'b0011000_00010_00000_000_00000_1110011);
  wire isEbreak = (cf_inst == 32'b000000000001_00000_000_00000_1110011);

  wire [11:0] csrIndex_c = srcb[11:0];

  reg [XLEN-1:0] csrRead_c;
  always @(*) begin
    csrRead_c = {XLEN{1'b0}};
    case (csrIndex_c)
      MTVEC:   csrRead_c = mtvec;
      MCAUSE:  csrRead_c = mcause;
      MEPC:    csrRead_c = mepc;
      MSTATUS: csrRead_c = mstatus;
      default: csrRead_c = {XLEN{1'b0}};
    endcase
  end

  assign jmp = in_valid && (fuOpType[2:0] == CSROP_JMP) && !isEbreak;

  // out.bits := MuxCase(csr, Array((isEcall)->mtvec, (isMret)->mepc))
  assign out_bits = (isEcall) ? mtvec :
                    (isMret)  ? mepc  :
                               csrRead_c;

endmodule


module EXU_golden #(
  parameter XLEN = 32
)(
  input  wire              clk,
  input  wire              rst_n,

  // -------------------------
  // from_isu (Decoupled DecodeIO) flattened
  // -------------------------
  input  wire              from_isu_valid,
  output wire              from_isu_ready,

  input  wire [31:0]       isu_cf_inst,
  input  wire [XLEN-1:0]   isu_cf_pc,
  input  wire [XLEN-1:0]   isu_cf_next_pc,
  input  wire              isu_cf_isBranch,

  input  wire              isu_ctrl_MemWrite,
  input  wire [2:0]        isu_ctrl_ResSrc,      // unused here
  input  wire [2:0]        isu_ctrl_fuSrc1Type,  // unused here
  input  wire [2:0]        isu_ctrl_fuSrc2Type,  // unused here
  input  wire [2:0]        isu_ctrl_fuType,      // FuType: alu=0, lsu=1, csr=3 (per your def)
  input  wire [6:0]        isu_ctrl_fuOpType,
  input  wire [4:0]        isu_ctrl_rs1,         // unused here
  input  wire [4:0]        isu_ctrl_rs2,         // unused here
  input  wire              isu_ctrl_rfWen,       // unused here
  input  wire [4:0]        isu_ctrl_rd,          // unused here

  input  wire [XLEN-1:0]   isu_data_fuSrc1,
  input  wire [XLEN-1:0]   isu_data_fuSrc2,
  input  wire [XLEN-1:0]   isu_data_imm,
  input  wire [XLEN-1:0]   isu_data_rfSrc1,
  input  wire [XLEN-1:0]   isu_data_rfSrc2,

  // memory response
  input  wire [XLEN-1:0]   from_mem_data,

  // -------------------------
  // to_wbu (Decoupled ExuToWbuIO) flattened
  // -------------------------
  output wire              to_wbu_valid,
  input  wire              to_wbu_ready,

  output wire [31:0]       wbu_cf_inst,
  output wire [XLEN-1:0]   wbu_cf_pc,
  output wire [XLEN-1:0]   wbu_cf_next_pc,
  output wire              wbu_cf_isBranch,

  output wire              wbu_ctrl_MemWrite,
  output wire [2:0]        wbu_ctrl_ResSrc,
  output wire [2:0]        wbu_ctrl_fuSrc1Type,
  output wire [2:0]        wbu_ctrl_fuSrc2Type,
  output wire [2:0]        wbu_ctrl_fuType,
  output wire [6:0]        wbu_ctrl_fuOpType,
  output wire [4:0]        wbu_ctrl_rs1,
  output wire [4:0]        wbu_ctrl_rs2,
  output wire              wbu_ctrl_rfWen,
  output wire [4:0]        wbu_ctrl_rd,

  output wire [XLEN-1:0]   wbu_data_fuSrc1,
  output wire [XLEN-1:0]   wbu_data_fuSrc2,
  output wire [XLEN-1:0]   wbu_data_imm,
  output wire [XLEN-1:0]   wbu_data_rfSrc1,
  output wire [XLEN-1:0]   wbu_data_rfSrc2,
  output wire [XLEN-1:0]   wbu_data_alu0Res_bits,
  output wire [XLEN-1:0]   wbu_data_data_from_mem,
  output wire [XLEN-1:0]   wbu_data_csrRdata,

  // -------------------------
  // to_mem (ToMem)
  // -------------------------
  output wire [XLEN-1:0]   to_mem_data,
  output wire [XLEN-1:0]   to_mem_addr,
  output wire [7:0]        to_mem_Wmask,
  output wire              to_mem_MemWrite,

  // redirect
  output wire              redirect_valid,
  output wire [XLEN-1:0]   redirect_target
);

  // pass-through fields to WBU (like your `out.bits.cf <> MicroOp.cf` etc.)
  assign wbu_cf_inst     = isu_cf_inst;
  assign wbu_cf_pc       = isu_cf_pc;
  assign wbu_cf_isBranch = isu_cf_isBranch;

  assign wbu_ctrl_MemWrite   = isu_ctrl_MemWrite;
  assign wbu_ctrl_ResSrc     = isu_ctrl_ResSrc;
  assign wbu_ctrl_fuSrc1Type = isu_ctrl_fuSrc1Type;
  assign wbu_ctrl_fuSrc2Type = isu_ctrl_fuSrc2Type;
  assign wbu_ctrl_fuType     = isu_ctrl_fuType;
  assign wbu_ctrl_fuOpType   = isu_ctrl_fuOpType;
  assign wbu_ctrl_rs1        = isu_ctrl_rs1;
  assign wbu_ctrl_rs2        = isu_ctrl_rs2;
  assign wbu_ctrl_rfWen      = isu_ctrl_rfWen;
  assign wbu_ctrl_rd         = isu_ctrl_rd;

  assign wbu_data_fuSrc1 = isu_data_fuSrc1;
  assign wbu_data_fuSrc2 = isu_data_fuSrc2;
  assign wbu_data_imm    = isu_data_imm;
  assign wbu_data_rfSrc1 = isu_data_rfSrc1;
  assign wbu_data_rfSrc2 = isu_data_rfSrc2;

  // --------------------------------
  // ALU instance
  // --------------------------------
  wire alu_in_valid  = from_isu_valid && (isu_ctrl_fuType == 3'b000); // FuType.alu = 0
  wire [XLEN-1:0] alu_out_bits;
  wire alu_taken;

  ALU_golden #(.XLEN(XLEN)) u_alu (
    .in_valid   (alu_in_valid),
    .in_ready   (),
    .srca       (isu_data_fuSrc1),
    .srcb       (isu_data_fuSrc2),
    .fuOpType   (isu_ctrl_fuOpType),
    .out_valid  (),
    .out_ready  (to_wbu_ready),
    .out_bits   (alu_out_bits),
    .taken      (alu_taken)
  );

  assign wbu_data_alu0Res_bits = alu_out_bits;

  // --------------------------------
  // LSU instance
  // --------------------------------
  wire lsu_in_valid = from_isu_valid && (isu_ctrl_fuType == 3'b001); // FuType.lsu = 1
  wire [XLEN-1:0] lsu_out_bits;

  LSU_golden #(.XLEN(XLEN)) u_lsu (
    .in_valid       (lsu_in_valid),
    .in_ready       (),
    .srca           (isu_data_fuSrc1),
    .srcb           (isu_data_fuSrc2),
    .fuOpType       (isu_ctrl_fuOpType),
    .ctrl_MemWrite  (isu_ctrl_MemWrite),
    .data_rfSrc2    (isu_data_rfSrc2),

    .to_mem_data    (to_mem_data),
    .to_mem_addr    (to_mem_addr),
    .to_mem_Wmask   (to_mem_Wmask),
    .to_mem_MemWrite(to_mem_MemWrite),
    .from_mem_data  (from_mem_data),

    .out_valid      (),
    .out_ready      (to_wbu_ready),
    .out_bits       (lsu_out_bits)
  );

  assign wbu_data_data_from_mem = lsu_out_bits;

  // --------------------------------
  // CSR instance
  // --------------------------------
  wire csr_in_valid = from_isu_valid && (isu_ctrl_fuType == 3'b011); // FuType.csr = 3
  wire [XLEN-1:0] csr_out_bits;
  wire csr_jmp;

  CSR_golden #(.XLEN(XLEN)) u_csr (
    .clk        (clk),
    .rst_n      (rst_n),

    .in_valid   (csr_in_valid),
    .in_ready   (),
    .srca       (isu_data_fuSrc1),
    .srcb       (isu_data_fuSrc2),   // matches your Chisel: csrIndex = srcb
    .fuOpType   (isu_ctrl_fuOpType),

    .cf_inst    (isu_cf_inst),
    .cf_pc      (isu_cf_pc),

    .out_valid  (),
    .out_ready  (to_wbu_ready),
    .out_bits   (csr_out_bits),
    .jmp        (csr_jmp)
  );

  assign wbu_data_csrRdata = csr_out_bits;

  // --------------------------------
  // Branch / redirect logic (matches your Chisel structure)
  // --------------------------------
  wire is_jalr = (isu_cf_inst[6:0] == 7'b1100111);
  wire is_b    = (isu_cf_inst[6:0] == 7'b1100011);

  wire jalr_valid = from_isu_valid && isu_cf_isBranch && is_jalr;
  wire [XLEN-1:0] jalr_target = (isu_data_rfSrc1 + isu_data_imm) & ~({{(XLEN-1){1'b0}},1'b1});

  wire typeb_valid = from_isu_valid && isu_cf_isBranch && is_b;
  wire [XLEN-1:0] pcIfBranch = isu_cf_pc + isu_data_imm;
  wire [XLEN-1:0] typeb_target = alu_taken ? pcIfBranch : (isu_cf_pc + 32'd4);

  wire csr_valid = from_isu_valid && csr_jmp;
  wire [XLEN-1:0] csr_target = csr_out_bits;

  reg bru_valid;
  reg [XLEN-1:0] bru_target;
  always @(*) begin
    bru_valid  = 1'b0;
    bru_target = {XLEN{1'b0}};
    if (jalr_valid) begin
      bru_valid  = 1'b1;
      bru_target = jalr_target;
    end else if (typeb_valid) begin
      bru_valid  = 1'b1;
      bru_target = typeb_target;
    end else if (csr_valid) begin
      bru_valid  = 1'b1;
      bru_target = csr_target;
    end
  end

  wire predict_error = (bru_target != isu_cf_next_pc);
  assign redirect_valid  = from_isu_valid && bru_valid && predict_error;
  assign redirect_target = bru_target;

  // next_pc to WBU is corrected if bru_valid else original
  assign wbu_cf_next_pc = bru_valid ? bru_target : isu_cf_next_pc;

  // --------------------------------
  // HandshakeDeal equivalent:
  // consumer = from_isu, producer = to_wbu
  // AnyStopCondition = isRedirect && in.valid
  // consumer.ready := (!consumer.valid || producer.fire) && !stop
  // producer.valid := consumer.valid && !invalid
  // --------------------------------
  wire stop = redirect_valid && from_isu_valid;

  // producer.fire = to_wbu_valid && to_wbu_ready
  wire producer_fire;

  assign to_wbu_valid  = from_isu_valid && !stop;
  assign producer_fire = to_wbu_valid && to_wbu_ready;

  assign from_isu_ready = ((!from_isu_valid) || producer_fire) && (!stop);

endmodule
