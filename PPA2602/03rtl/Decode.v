module Decode_golden (
  input  wire         clock,
  input  wire         reset,

  // from_ifu: Decoupled(CtrlFlow)
  input  wire         from_ifu_valid,
  output wire         from_ifu_ready,
  input  wire [31:0]  from_ifu_inst,
  input  wire [31:0]  from_ifu_pc,
  input  wire [31:0]  from_ifu_next_pc,
  input  wire         from_ifu_isBranch,

  // to_isu: Decoupled(DecodeIO)
  output wire         to_isu_valid,
  input  wire         to_isu_ready,

  // to_isu.bits.cf
  output wire [31:0]  to_isu_cf_inst,
  output wire [31:0]  to_isu_cf_pc,
  output wire [31:0]  to_isu_cf_next_pc,
  output wire         to_isu_cf_isBranch,

  // to_isu.bits.ctrl
  output reg          to_isu_ctrl_MemWrite,
  output reg  [1:0]   to_isu_ctrl_ResSrc,     // 0=ALU, 1=MEM(load), 2=CSR
  output reg  [2:0]   to_isu_ctrl_fuSrc1Type,
  output reg  [2:0]   to_isu_ctrl_fuSrc2Type,
  output reg  [2:0]   to_isu_ctrl_fuType,
  output reg  [6:0]   to_isu_ctrl_fuOpType,
  output wire [4:0]   to_isu_ctrl_rs1,
  output wire [4:0]   to_isu_ctrl_rs2,
  output reg          to_isu_ctrl_rfWen,
  output wire [4:0]   to_isu_ctrl_rd,

  // to_isu.bits.data
  output reg  [31:0]  to_isu_data_fuSrc1,
  output reg  [31:0]  to_isu_data_fuSrc2,
  output reg  [31:0]  to_isu_data_imm,
  output reg  [31:0]  to_isu_data_data_from_mem,
  output reg  [31:0]  to_isu_data_csrRdata,
  output reg  [31:0]  to_isu_data_rfSrc1,
  output reg  [31:0]  to_isu_data_rfSrc2
);

  // ----------------------------
  // HandShakeDeal equivalent
  // AnyInvalidCondition=false, AnyStopCondition=false
  // consumer = from_ifu, producer = to_isu
  // consumer.ready := (!consumer.valid || producer.fire)
  // producer.valid := consumer.valid && !AnyInvalidCondition
  // ----------------------------
  wire producer_fire = to_isu_valid & to_isu_ready;

  assign from_ifu_ready = (~from_ifu_valid) | producer_fire;
  assign to_isu_valid   = from_ifu_valid;

  // pass-through CtrlFlow
  assign to_isu_cf_inst     = from_ifu_inst;
  assign to_isu_cf_pc       = from_ifu_pc;
  assign to_isu_cf_next_pc  = from_ifu_next_pc;
  assign to_isu_cf_isBranch = from_ifu_isBranch;

  // ----------------------------
  // Common fields
  // ----------------------------
  wire [31:0] inst = from_ifu_inst;

  assign to_isu_ctrl_rd  = inst[11:7];
  assign to_isu_ctrl_rs1 = inst[19:15];
  assign to_isu_ctrl_rs2 = inst[24:20];

  wire [6:0] opcode = inst[6:0];
  wire [2:0] funct3 = inst[14:12];
  wire [6:0] funct7 = inst[31:25];

  // ----------------------------
  // Encodings copied from Chisel objects (as numeric constants)
  // ----------------------------
  // TYPE_INST (4-bit in Chisel; we keep 4-bit)
  localparam [3:0] TYPE_N = 4'b0000;
  localparam [3:0] TYPE_B = 4'b0001;
  localparam [3:0] TYPE_S = 4'b0010;
  localparam [3:0] TYPE_I = 4'b0100;
  localparam [3:0] TYPE_R = 4'b0101;
  localparam [3:0] TYPE_U = 4'b0110;
  localparam [3:0] TYPE_J = 4'b0111;

  // FuType
  localparam [2:0] FUT_ALU = 3'b000;
  localparam [2:0] FUT_LSU = 3'b001;
  localparam [2:0] FUT_MDU = 3'b010;
  localparam [2:0] FUT_CSR = 3'b011;
  localparam [2:0] FUT_MOU = 3'b100;
  // IndependentBru=false => bru = alu
  localparam [2:0] FUT_BRU = FUT_ALU;

  // FuSrcType
  localparam [2:0] FS_RF1  = 3'b000;
  localparam [2:0] FS_RF2  = 3'b001;
  localparam [2:0] FS_PC   = 3'b010;
  localparam [2:0] FS_IMM  = 3'b011;
  localparam [2:0] FS_ZERO = 3'b100;
  localparam [2:0] FS_FOUR = 3'b101;

  // ALUOpType (7-bit)
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

  // LSUOpType (7-bit)
  localparam [6:0] LSU_LB  = 7'b0000000;
  localparam [6:0] LSU_LH  = 7'b0000001;
  localparam [6:0] LSU_LW  = 7'b0000010;
  localparam [6:0] LSU_LBU = 7'b0000100;
  localparam [6:0] LSU_LHU = 7'b0000101;
  localparam [6:0] LSU_SB  = 7'b0001000;
  localparam [6:0] LSU_SH  = 7'b0001001;
  localparam [6:0] LSU_SW  = 7'b0001010;

  // CSROpType (3-bit in Chisel, but FuOpType is 7-bit; we zero-extend)
  localparam [6:0] CSR_JMP = 7'b0000000; // "b000"
  localparam [6:0] CSR_WRT = 7'b0000001; // "b001"
  localparam [6:0] CSR_SET = 7'b0000010; // "b010"

  // ----------------------------
  // Default decode (Instructions.DecodeDefault)
  // List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  // ----------------------------
  reg [3:0] instType;

  always @(*) begin
    // defaults
    instType               = TYPE_N;
    to_isu_ctrl_fuType     = FUT_ALU;
    to_isu_ctrl_fuOpType   = ALU_SLL;
    to_isu_ctrl_fuSrc1Type = FS_ZERO;
    to_isu_ctrl_fuSrc2Type = FS_ZERO;

    // ----------------------------
    // Decode RV32I ALU immediate (0010011)
    // ----------------------------
    if (opcode == 7'b0010011) begin
      instType               = TYPE_I;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuSrc1Type = FS_RF1;
      to_isu_ctrl_fuSrc2Type = FS_IMM;
      case (funct3)
        3'b000: to_isu_ctrl_fuOpType = ALU_ADD; // ADDI
        3'b001: to_isu_ctrl_fuOpType = ALU_SLL; // SLLI (funct7 should be 0000000)
        3'b010: to_isu_ctrl_fuOpType = ALU_SLT; // SLTI
        3'b011: to_isu_ctrl_fuOpType = ALU_SLTU;// SLTIU
        3'b100: to_isu_ctrl_fuOpType = ALU_XOR; // XORI
        3'b101: begin
          if (funct7 == 7'b0100000) to_isu_ctrl_fuOpType = ALU_SRA; // SRAI
          else                      to_isu_ctrl_fuOpType = ALU_SRL; // SRLI (assume 0000000)
        end
        3'b110: to_isu_ctrl_fuOpType = ALU_OR;  // ORI
        3'b111: to_isu_ctrl_fuOpType = ALU_AND; // ANDI
        default: ;
      endcase
    end

    // ----------------------------
    // Decode RV32I ALU reg-reg (0110011)
    // ----------------------------
    else if (opcode == 7'b0110011) begin
      instType               = TYPE_R;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuSrc1Type = FS_RF1;
      to_isu_ctrl_fuSrc2Type = FS_RF2;
      case (funct3)
        3'b000: begin
          if (funct7 == 7'b0100000) to_isu_ctrl_fuOpType = ALU_SUB;
          else                      to_isu_ctrl_fuOpType = ALU_ADD;
        end
        3'b001: to_isu_ctrl_fuOpType = ALU_SLL;
        3'b010: to_isu_ctrl_fuOpType = ALU_SLT;
        3'b011: to_isu_ctrl_fuOpType = ALU_SLTU;
        3'b100: to_isu_ctrl_fuOpType = ALU_XOR;
        3'b101: begin
          if (funct7 == 7'b0100000) to_isu_ctrl_fuOpType = ALU_SRA;
          else                      to_isu_ctrl_fuOpType = ALU_SRL;
        end
        3'b110: to_isu_ctrl_fuOpType = ALU_OR;
        3'b111: to_isu_ctrl_fuOpType = ALU_AND;
        default: ;
      endcase
    end

    // ----------------------------
    // AUIPC (0010111) / LUI (0110111)
    // ----------------------------
    else if (opcode == 7'b0010111) begin // AUIPC
      instType               = TYPE_U;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuOpType   = ALU_ADD;
      to_isu_ctrl_fuSrc1Type = FS_PC;
      to_isu_ctrl_fuSrc2Type = FS_IMM;
    end
    else if (opcode == 7'b0110111) begin // LUI
      instType               = TYPE_U;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuOpType   = ALU_ADD;
      to_isu_ctrl_fuSrc1Type = FS_ZERO;
      to_isu_ctrl_fuSrc2Type = FS_IMM;
    end

    // ----------------------------
    // JAL (1101111), JALR (1100111)
    // Table uses ALU add with pc + four
    // ----------------------------
    else if (opcode == 7'b1101111) begin // JAL
      instType               = TYPE_J;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuOpType   = ALU_ADD;
      to_isu_ctrl_fuSrc1Type = FS_PC;
      to_isu_ctrl_fuSrc2Type = FS_FOUR;
    end
    else if (opcode == 7'b1100111 && funct3 == 3'b000) begin // JALR
      instType               = TYPE_I;
      to_isu_ctrl_fuType     = FUT_ALU;
      to_isu_ctrl_fuOpType   = ALU_ADD;
      to_isu_ctrl_fuSrc1Type = FS_PC;
      to_isu_ctrl_fuSrc2Type = FS_FOUR;
    end

    // ----------------------------
    // Branches (1100011)
    // ----------------------------
    else if (opcode == 7'b1100011) begin
      instType               = TYPE_B;
      to_isu_ctrl_fuType     = FUT_BRU;
      to_isu_ctrl_fuSrc1Type = FS_RF1;
      to_isu_ctrl_fuSrc2Type = FS_RF2;
      case (funct3)
        3'b000: to_isu_ctrl_fuOpType = ALU_BEQ;
        3'b001: to_isu_ctrl_fuOpType = ALU_BNE;
        3'b100: to_isu_ctrl_fuOpType = ALU_BLT;
        3'b101: to_isu_ctrl_fuOpType = ALU_BGE;
        3'b110: to_isu_ctrl_fuOpType = ALU_BLTU;
        3'b111: to_isu_ctrl_fuOpType = ALU_BGEU;
        default: ;
      endcase
    end

    // ----------------------------
    // Loads (0000011)
    // ----------------------------
    else if (opcode == 7'b0000011) begin
      instType               = TYPE_I;
      to_isu_ctrl_fuType     = FUT_LSU;
      to_isu_ctrl_fuSrc1Type = FS_RF1;
      to_isu_ctrl_fuSrc2Type = FS_IMM;
      case (funct3)
        3'b000: to_isu_ctrl_fuOpType = LSU_LB;
        3'b001: to_isu_ctrl_fuOpType = LSU_LH;
        3'b010: to_isu_ctrl_fuOpType = LSU_LW;
        3'b100: to_isu_ctrl_fuOpType = LSU_LBU;
        3'b101: to_isu_ctrl_fuOpType = LSU_LHU;
        default: to_isu_ctrl_fuOpType = LSU_LW;
      endcase
    end

    // ----------------------------
    // Stores (0100011)
    // ----------------------------
    else if (opcode == 7'b0100011) begin
      instType               = TYPE_S;
      to_isu_ctrl_fuType     = FUT_LSU;
      to_isu_ctrl_fuSrc1Type = FS_RF1;
      to_isu_ctrl_fuSrc2Type = FS_IMM;
      case (funct3)
        3'b000: to_isu_ctrl_fuOpType = LSU_SB;
        3'b001: to_isu_ctrl_fuOpType = LSU_SH;
        3'b010: to_isu_ctrl_fuOpType = LSU_SW;
        default: to_isu_ctrl_fuOpType = LSU_SW;
      endcase
    end

    // ----------------------------
    // CSR (1110011): only CSRRW/CSRRS implemented like your table
    // ----------------------------
    else if (opcode == 7'b1110011) begin
      // match privileged exact patterns too, but simplest: check full inst for those
      if (inst == 32'b000000000000_00000_000_00000_1110011) begin // ECALL
        instType             = TYPE_I;
        to_isu_ctrl_fuType   = FUT_CSR;
        to_isu_ctrl_fuOpType = CSR_JMP;
        to_isu_ctrl_fuSrc1Type = FS_RF1;
        to_isu_ctrl_fuSrc2Type = FS_IMM;
      end else if (inst == 32'b000000000001_00000_000_00000_1110011) begin // EBREAK
        instType             = TYPE_I;
        to_isu_ctrl_fuType   = FUT_CSR;
        to_isu_ctrl_fuOpType = CSR_JMP;
        to_isu_ctrl_fuSrc1Type = FS_RF1;
        to_isu_ctrl_fuSrc2Type = FS_IMM;
      end else if (inst == 32'b001100000010_00000_000_00000_1110011) begin // MRET
        instType             = TYPE_R;
        to_isu_ctrl_fuType   = FUT_CSR;
        to_isu_ctrl_fuOpType = CSR_JMP;
        to_isu_ctrl_fuSrc1Type = FS_RF1;
        to_isu_ctrl_fuSrc2Type = FS_RF2;
      end else begin
        // Zicsr subset
        instType             = TYPE_I;
        to_isu_ctrl_fuType   = FUT_CSR;
        to_isu_ctrl_fuSrc1Type = FS_RF1;
        to_isu_ctrl_fuSrc2Type = FS_IMM;
        if (funct3 == 3'b001)      to_isu_ctrl_fuOpType = CSR_WRT; // CSRRW
        else if (funct3 == 3'b010) to_isu_ctrl_fuOpType = CSR_SET; // CSRRS
        else                       to_isu_ctrl_fuOpType = CSR_JMP; // default-ish
      end
    end
  end

  // ----------------------------
  // RegWrite := isRegWrite(instType) where isRegWrite = instType(2) == 1
  // (same as Chisel: instType(2,2) === 1.U)
  // ----------------------------
  always @(*) begin
    to_isu_ctrl_rfWen = instType[2];
  end

  // ----------------------------
  // MemWrite := (instType == TYPE_S)
  // ----------------------------
  always @(*) begin
    to_isu_ctrl_MemWrite = (instType == TYPE_S);
  end

  // ----------------------------
  // ResSrc:
  //  (opcode == 0000011) -> 1 (load)
  //  (opcode == 1110011) -> 2 (csr)
  //  else 0
  // ----------------------------
  always @(*) begin
    to_isu_ctrl_ResSrc = 2'd0;
    if (opcode == 7'b0000011)      to_isu_ctrl_ResSrc = 2'd1;
    else if (opcode == 7'b1110011) to_isu_ctrl_ResSrc = 2'd2;
  end

  // ----------------------------
  // Immediate Extension (same formulas as Chisel)
  // ----------------------------
  wire [31:0] imm_i = {{20{inst[31]}}, inst[31:20]};
  wire [31:0] imm_u = {inst[31:12], 12'b0};
  wire [31:0] imm_j = {{11{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
  wire [31:0] imm_s = {{20{inst[31]}}, inst[31:25], inst[11:7]};
  wire [31:0] imm_b = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};

  always @(*) begin
    case (instType)
      TYPE_I: to_isu_data_imm = imm_i;
      TYPE_U: to_isu_data_imm = imm_u;
      TYPE_J: to_isu_data_imm = imm_j;
      TYPE_S: to_isu_data_imm = imm_s;
      TYPE_B: to_isu_data_imm = imm_b;
      default: to_isu_data_imm = 32'b0;
    endcase
  end

  // ----------------------------
  // DataSrc fields that were DontCare in Chisel
  // ----------------------------
  always @(*) begin
    to_isu_data_fuSrc1         = 32'b0;
    to_isu_data_fuSrc2         = 32'b0;
    to_isu_data_rfSrc1         = 32'b0;
    to_isu_data_rfSrc2         = 32'b0;
    to_isu_data_data_from_mem  = 32'b0;
    to_isu_data_csrRdata       = 32'b0;
  end

endmodule