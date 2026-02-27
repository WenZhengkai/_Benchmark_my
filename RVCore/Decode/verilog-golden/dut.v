module Decode_golden (
  input  wire         clock,
  input  wire         reset,

  // from_ifu: Decoupled(CtrlFlow)
  input  wire         from_ifu_valid,
  output wire         from_ifu_ready,
  input  wire [31:0]  from_ifu_bits_inst,
  input  wire [31:0]  from_ifu_bits_pc,
  input  wire [31:0]  from_ifu_bits_next_pc,
  input  wire         from_ifu_bits_isBranch,

  // to_isu: Decoupled(DecodeIO)
  output wire         to_isu_valid,
  input  wire         to_isu_ready,

  // to_isu.bits.cf
  output wire [31:0]  to_isu_bits_cf_inst,
  output wire [31:0]  to_isu_bits_cf_pc,
  output wire [31:0]  to_isu_bits_cf_next_pc,
  output wire         to_isu_bits_cf_isBranch,

  // to_isu.bits.ctrl
  output wire         to_isu_bits_ctrl_MemWrite,
  output wire [31:0]  to_isu_bits_ctrl_ResSrc,     // matches Chisel UInt() (unsized). Using 32.
  output wire [2:0]   to_isu_bits_ctrl_fuSrc1Type,
  output wire [2:0]   to_isu_bits_ctrl_fuSrc2Type,
  output wire [2:0]   to_isu_bits_ctrl_fuType,
  output wire [6:0]   to_isu_bits_ctrl_fuOpType,
  output wire [4:0]   to_isu_bits_ctrl_rs1,
  output wire [4:0]   to_isu_bits_ctrl_rs2,
  output wire         to_isu_bits_ctrl_rfWen,
  output wire [4:0]   to_isu_bits_ctrl_rd,

  // to_isu.bits.data
  output wire [31:0]  to_isu_bits_data_fuSrc1,
  output wire [31:0]  to_isu_bits_data_fuSrc2,
  output wire [31:0]  to_isu_bits_data_imm,
  output wire [31:0]  to_isu_bits_data_rfSrc1,
  output wire [31:0]  to_isu_bits_data_rfSrc2,
  output wire         to_isu_bits_data_Alu0Res_valid,
  input  wire         to_isu_bits_data_Alu0Res_ready,
  output wire [31:0]  to_isu_bits_data_Alu0Res_bits,
  output wire [31:0]  to_isu_bits_data_data_from_mem,
  output wire [31:0]  to_isu_bits_data_csrRdata
);

  localparam int XLEN = 32;

  // =========================
  // Handshake (HandShakeDeal)
  // =========================
  wire AnyInvalidCondition = 1'b0;
  wire AnyStopCondition    = 1'b0;

  // producer.fire == to_isu_valid && to_isu_ready
  assign to_isu_valid   = from_ifu_valid && !AnyInvalidCondition;
  assign from_ifu_ready = ((!from_ifu_valid) || (to_isu_valid && to_isu_ready)) && !AnyStopCondition;

  // Pass-through CtrlFlow
  assign to_isu_bits_cf_inst     = from_ifu_bits_inst;
  assign to_isu_bits_cf_pc       = from_ifu_bits_pc;
  assign to_isu_bits_cf_next_pc  = from_ifu_bits_next_pc;
  assign to_isu_bits_cf_isBranch = from_ifu_bits_isBranch;

  // =========================
  // Encodings from your Chisel
  // =========================
  // TYPE_INST
  localparam [3:0] TYPE_N = 4'b0000;
  localparam [3:0] TYPE_I = 4'b0100;
  localparam [3:0] TYPE_R = 4'b0101;
  localparam [3:0] TYPE_S = 4'b0010;
  localparam [3:0] TYPE_B = 4'b0001;
  localparam [3:0] TYPE_U = 4'b0110;
  localparam [3:0] TYPE_J = 4'b0111;

  // FuType (IndependentBru=false => bru == alu)
  localparam [2:0] FUT_ALU = 3'b000;
  localparam [2:0] FUT_LSU = 3'b001;
  localparam [2:0] FUT_MDU = 3'b010;
  localparam [2:0] FUT_CSR = 3'b011;
  localparam [2:0] FUT_MOU = 3'b100;
  localparam [2:0] FUT_BRU = FUT_ALU;

  // FuSrcType
  localparam [2:0] SRC_RF1  = 3'b000;
  localparam [2:0] SRC_RF2  = 3'b001;
  localparam [2:0] SRC_PC   = 3'b010;
  localparam [2:0] SRC_IMM  = 3'b011;
  localparam [2:0] SRC_ZERO = 3'b100;
  localparam [2:0] SRC_FOUR = 3'b101;

  // ALUOpType (subset used here)
  localparam [6:0] ALU_ADD  = 7'b1000000;
  localparam [6:0] ALU_SLL  = 7'b0000001;
  localparam [6:0] ALU_SLT  = 7'b0000010;
  localparam [6:0] ALU_SLTU = 7'b0000011;
  localparam [6:0] ALU_XOR  = 7'b0000100;
  localparam [6:0] ALU_SRL  = 7'b0000101;
  localparam [6:0] ALU_OR   = 7'b0000110;
  localparam [6:0] ALU_AND  = 7'b0000111;
  localparam [6:0] ALU_SUB  = 7'b0001000;
  localparam [6:0] ALU_SRA  = 7'b0001101;

  localparam [6:0] ALU_BEQ  = 7'b0010000;
  localparam [6:0] ALU_BNE  = 7'b0010001;
  localparam [6:0] ALU_BLT  = 7'b0010100;
  localparam [6:0] ALU_BGE  = 7'b0010101;
  localparam [6:0] ALU_BLTU = 7'b0010110;
  localparam [6:0] ALU_BGEU = 7'b0010111;

  // LSUOpType (subset)
  localparam [6:0] LSU_LB  = 7'b0000000;
  localparam [6:0] LSU_LH  = 7'b0000001;
  localparam [6:0] LSU_LW  = 7'b0000010;
  localparam [6:0] LSU_LBU = 7'b0000100;
  localparam [6:0] LSU_LHU = 7'b0000101;
  localparam [6:0] LSU_SB  = 7'b0001000;
  localparam [6:0] LSU_SH  = 7'b0001001;
  localparam [6:0] LSU_SW  = 7'b0001010;

  // CSROpType used
  localparam [6:0] CSR_JMP = 7'b0000000; // we pack to 7b for fuOpType bus
  localparam [6:0] CSR_WRT = 7'b0000001;
  localparam [6:0] CSR_SET = 7'b0000010;

  // ==============
  // Field extracts
  // ==============
  wire [31:0] inst = from_ifu_bits_inst;
  wire [6:0]  opcode = inst[6:0];
  wire [2:0]  funct3 = inst[14:12];
  wire [6:0]  funct7 = inst[31:25];

  assign to_isu_bits_ctrl_rd  = inst[11:7];
  assign to_isu_bits_ctrl_rs1 = inst[19:15];
  assign to_isu_bits_ctrl_rs2 = inst[24:20];

  // =========================
  // Decode (ListLookup/table)
  // =========================
  reg [3:0] instType;
  reg [2:0] fuType;
  reg [6:0] fuOpType;
  reg [2:0] fuSrc1Type;
  reg [2:0] fuSrc2Type;

  always @(*) begin
    // Defaults = Instructions.DecodeDefault
    instType   = TYPE_N;
    fuType     = FUT_ALU;
    fuOpType   = ALU_SLL;
    fuSrc1Type = SRC_ZERO;
    fuSrc2Type = SRC_ZERO;

    // ---- RV32I ALU immediate (0010011) ----
    if (opcode == 7'b0010011) begin
      instType   = TYPE_I;
      fuType     = FUT_ALU;
      fuSrc1Type = SRC_RF1;
      fuSrc2Type = SRC_IMM;
      case (funct3)
        3'b000: fuOpType = ALU_ADD; // ADDI
        3'b001: fuOpType = ALU_SLL; // SLLI (ignoring funct7 check like typical decode)
        3'b010: fuOpType = ALU_SLT; // SLTI
        3'b011: fuOpType = ALU_SLTU;// SLTIU
        3'b100: fuOpType = ALU_XOR; // XORI
        3'b101: fuOpType = (funct7 == 7'b0100000) ? ALU_SRA : ALU_SRL; // SRAI/SRLI
        3'b110: fuOpType = ALU_OR;  // ORI
        3'b111: fuOpType = ALU_AND; // ANDI
        default: ;
      endcase
    end

    // ---- RV32I ALU reg-reg (0110011) ----
    else if (opcode == 7'b0110011) begin
      instType   = TYPE_R;
      fuType     = FUT_ALU;
      fuSrc1Type = SRC_RF1;
      fuSrc2Type = SRC_RF2;
      case (funct3)
        3'b000: fuOpType = (funct7 == 7'b0100000) ? ALU_SUB : ALU_ADD; // SUB/ADD
        3'b001: fuOpType = ALU_SLL;
        3'b010: fuOpType = ALU_SLT;
        3'b011: fuOpType = ALU_SLTU;
        3'b100: fuOpType = ALU_XOR;
        3'b101: fuOpType = (funct7 == 7'b0100000) ? ALU_SRA : ALU_SRL;
        3'b110: fuOpType = ALU_OR;
        3'b111: fuOpType = ALU_AND;
        default: ;
      endcase
    end

    // ---- LUI (0110111) ----
    else if (opcode == 7'b0110111) begin
      instType   = TYPE_U;
      fuType     = FUT_ALU;
      fuOpType   = ALU_ADD;
      fuSrc1Type = SRC_ZERO;
      fuSrc2Type = SRC_IMM;
    end

    // ---- AUIPC (0010111) ----
    else if (opcode == 7'b0010111) begin
      instType   = TYPE_U;
      fuType     = FUT_ALU;
      fuOpType   = ALU_ADD;
      fuSrc1Type = SRC_PC;
      fuSrc2Type = SRC_IMM;
    end

    // ---- Branches (1100011) ----
    else if (opcode == 7'b1100011) begin
      instType   = TYPE_B;
      fuType     = FUT_BRU;
      fuSrc1Type = SRC_RF1;
      fuSrc2Type = SRC_RF2;
      case (funct3)
        3'b000: fuOpType = ALU_BEQ;
        3'b001: fuOpType = ALU_BNE;
        3'b100: fuOpType = ALU_BLT;
        3'b101: fuOpType = ALU_BGE;
        3'b110: fuOpType = ALU_BLTU;
        3'b111: fuOpType = ALU_BGEU;
        default: ;
      endcase
    end

    // ---- JAL (1101111) ----
    else if (opcode == 7'b1101111) begin
      instType   = TYPE_J;
      fuType     = FUT_ALU;
      fuOpType   = ALU_ADD;
      fuSrc1Type = SRC_PC;
      fuSrc2Type = SRC_FOUR;
    end

    // ---- JALR (1100111) ----
    else if (opcode == 7'b1100111 && funct3 == 3'b000) begin
      instType   = TYPE_I;
      fuType     = FUT_ALU;
      fuOpType   = ALU_ADD;
      fuSrc1Type = SRC_PC;
      fuSrc2Type = SRC_FOUR;
    end

    // ---- Loads (0000011) ----
    else if (opcode == 7'b0000011) begin
      instType   = TYPE_I;
      fuType     = FUT_LSU;
      fuSrc1Type = SRC_RF1;
      fuSrc2Type = SRC_IMM;
      case (funct3)
        3'b000: fuOpType = LSU_LB;
        3'b001: fuOpType = LSU_LH;
        3'b010: fuOpType = LSU_LW;
        3'b100: fuOpType = LSU_LBU;
        3'b101: fuOpType = LSU_LHU;
        default: ;
      endcase
    end

    // ---- Stores (0100011) ----
    else if (opcode == 7'b0100011) begin
      instType   = TYPE_S;
      fuType     = FUT_LSU;
      fuSrc1Type = SRC_RF1;
      fuSrc2Type = SRC_IMM;
      case (funct3)
        3'b000: fuOpType = LSU_SB;
        3'b001: fuOpType = LSU_SH;
        3'b010: fuOpType = LSU_SW;
        default: ;
      endcase
    end

    // ---- Zicsr / Privileged subset (1110011) ----
    else if (opcode == 7'b1110011) begin
      // Privileged exact patterns: ECALL/EBREAK/MRET -> jmp
      if (inst == 32'h00000073 || inst == 32'h00100073 || inst == 32'h30200073) begin
        instType   = (inst == 32'h30200073) ? TYPE_R : TYPE_I;
        fuType     = FUT_CSR;
        fuOpType   = CSR_JMP;
        fuSrc1Type = SRC_RF1;
        fuSrc2Type = (inst == 32'h30200073) ? SRC_RF2 : SRC_IMM;
      end
      else begin
        // CSR ops (only CSRRW, CSRRS included like your table)
        if (funct3 == 3'b001) begin // CSRRW
          instType   = TYPE_I;
          fuType     = FUT_CSR;
          fuOpType   = CSR_WRT;
          fuSrc1Type = SRC_RF1;
          fuSrc2Type = SRC_IMM;
        end else if (funct3 == 3'b010) begin // CSRRS
          instType   = TYPE_I;
          fuType     = FUT_CSR;
          fuOpType   = CSR_SET;
          fuSrc1Type = SRC_RF1;
          fuSrc2Type = SRC_IMM;
        end
      end
    end
  end

  // Drive ctrl outputs
  assign to_isu_bits_ctrl_fuOpType   = fuOpType;
  assign to_isu_bits_ctrl_fuType     = fuType;
  assign to_isu_bits_ctrl_fuSrc1Type = fuSrc1Type;
  assign to_isu_bits_ctrl_fuSrc2Type = fuSrc2Type;

  // RegWrite := isRegWrite(instType) where isRegWrite = instType(2)==1
  assign to_isu_bits_ctrl_rfWen = instType[2];

  // MemWrite := (instType == TYPE_S)
  assign to_isu_bits_ctrl_MemWrite = (instType == TYPE_S);

  // ResSrc := load ? 1 : csr ? 2 : 0
  wire [31:0] ResSrc =
      (opcode == 7'b0000011) ? 32'd1 :
      (opcode == 7'b1110011) ? 32'd2 :
                              32'd0;
  assign to_isu_bits_ctrl_ResSrc = ResSrc;

  // =========================
  // Immediate extension (ImmExt)
  // =========================
  reg [31:0] immExt;
  always @(*) begin
    immExt = 32'b0;
    case (instType)
      TYPE_I: immExt = {{20{inst[31]}}, inst[31:20]};
      TYPE_U: immExt = {inst[31:12], 12'b0};
      TYPE_J: immExt = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
      TYPE_S: immExt = {{20{inst[31]}}, inst[31:25], inst[11:7]};
      TYPE_B: immExt = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
      default: immExt = 32'b0;
    endcase
  end

  // Drive data outputs (Chisel sets most to DontCare)
  assign to_isu_bits_data_imm          = immExt;
  assign to_isu_bits_data_fuSrc1       = 32'b0;
  assign to_isu_bits_data_fuSrc2       = 32'b0;
  assign to_isu_bits_data_rfSrc1       = 32'b0;
  assign to_isu_bits_data_rfSrc2       = 32'b0;
  assign to_isu_bits_data_Alu0Res_valid= 1'b0;
  assign to_isu_bits_data_Alu0Res_bits = 32'b0;
  assign to_isu_bits_data_data_from_mem= 32'b0;
  assign to_isu_bits_data_csrRdata     = 32'b0;

endmodule