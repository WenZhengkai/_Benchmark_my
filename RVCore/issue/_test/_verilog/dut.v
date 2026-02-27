
module issue_golden #(
  parameter int XLEN       = 32,
  parameter bit CONFIG_RVE = 1,
  parameter int NR_GPR     = (CONFIG_RVE ? 16 : 32),
  parameter int MAXSCORE   = 3
)(
  input  logic              clock,
  input  logic              reset,

  // -------- from_idu: Decoupled(DecodeIO) (Flipped) --------
  input  logic              from_idu_valid,
  output logic              from_idu_ready,

  input  logic [31:0]       from_idu_cf_inst,
  input  logic [XLEN-1:0]   from_idu_cf_pc,
  input  logic [XLEN-1:0]   from_idu_cf_next_pc,
  input  logic              from_idu_cf_isBranch,

  input  logic              from_idu_ctrl_MemWrite,
  input  logic [3:0]        from_idu_ctrl_ResSrc,
  input  logic [2:0]        from_idu_ctrl_fuSrc1Type,
  input  logic [2:0]        from_idu_ctrl_fuSrc2Type,
  input  logic [2:0]        from_idu_ctrl_fuType,      // width in Chisel is log2Up(5)=3
  input  logic [6:0]        from_idu_ctrl_fuOpType,
  input  logic [4:0]        from_idu_ctrl_rs1,
  input  logic [4:0]        from_idu_ctrl_rs2,
  input  logic              from_idu_ctrl_rfWen,
  input  logic [4:0]        from_idu_ctrl_rd,

  input  logic [XLEN-1:0]   from_idu_data_imm,
  // The rest of inBits.data are passed through as well, but some are overwritten below.
  input  logic [XLEN-1:0]   from_idu_data_fuSrc1,
  input  logic [XLEN-1:0]   from_idu_data_fuSrc2,
  input  logic [XLEN-1:0]   from_idu_data_data_from_mem,
  input  logic [XLEN-1:0]   from_idu_data_csrRdata,
  input  logic [XLEN-1:0]   from_idu_data_rfSrc1,
  input  logic [XLEN-1:0]   from_idu_data_rfSrc2,
  // NOTE: Alu0Res is Decoupled in Chisel; omitted here since it isn't used by issue_golden.

  // -------- to_exu: Decoupled(DecodeIO) --------
  output logic              to_exu_valid,
  input  logic              to_exu_ready,

  output logic [31:0]       to_exu_cf_inst,
  output logic [XLEN-1:0]   to_exu_cf_pc,
  output logic [XLEN-1:0]   to_exu_cf_next_pc,
  output logic              to_exu_cf_isBranch,

  output logic              to_exu_ctrl_MemWrite,
  output logic [3:0]        to_exu_ctrl_ResSrc,
  output logic [2:0]        to_exu_ctrl_fuSrc1Type,
  output logic [2:0]        to_exu_ctrl_fuSrc2Type,
  output logic [2:0]        to_exu_ctrl_fuType,
  output logic [6:0]        to_exu_ctrl_fuOpType,
  output logic [4:0]        to_exu_ctrl_rs1,
  output logic [4:0]        to_exu_ctrl_rs2,
  output logic              to_exu_ctrl_rfWen,
  output logic [4:0]        to_exu_ctrl_rd,

  output logic [XLEN-1:0]   to_exu_data_imm,
  output logic [XLEN-1:0]   to_exu_data_fuSrc1,
  output logic [XLEN-1:0]   to_exu_data_fuSrc2,
  output logic [XLEN-1:0]   to_exu_data_data_from_mem,
  output logic [XLEN-1:0]   to_exu_data_csrRdata,
  output logic [XLEN-1:0]   to_exu_data_rfSrc1,
  output logic [XLEN-1:0]   to_exu_data_rfSrc2,

  // -------- wb: WbuToRegIO --------
  input  logic [4:0]        wb_rd,
  input  logic [XLEN-1:0]   wb_Res,
  input  logic              wb_RegWrite,

  // -------- from_reg --------
  input  logic [XLEN-1:0]   from_reg_rfSrc1,
  input  logic [XLEN-1:0]   from_reg_rfSrc2
);

  // -------------------------------
  // Constants for FuSrcType encoding
  // Must match your Chisel constants:
  // rfSrc1=000 rfSrc2=001 pc=010 imm=011 zero=100 four=101
  // -------------------------------
  localparam logic [2:0] FUSRC_RF1  = 3'b000;
  localparam logic [2:0] FUSRC_RF2  = 3'b001;
  localparam logic [2:0] FUSRC_PC   = 3'b010;
  localparam logic [2:0] FUSRC_IMM  = 3'b011;
  localparam logic [2:0] FUSRC_ZERO = 3'b100;
  localparam logic [2:0] FUSRC_FOUR = 3'b101;

  // -------------------------------
  // Scoreboard storage: busy[idx] is a small counter
  // width = log2Ceil(MAXSCORE) in Chisel
  // For MAXSCORE=3 => log2Ceil(3)=2 bits
  // -------------------------------
  localparam int BUSY_W = (MAXSCORE <= 2) ? 1 :
                          (MAXSCORE <= 4) ? 2 :
                          (MAXSCORE <= 8) ? 3 : 4;

  logic [BUSY_W-1:0] busy [NR_GPR-1:0];

  // Helpers: mask generation
  logic [NR_GPR-1:0] setMask, clearMask;

  // isBusy for rs1/rs2
  logic src1Busy, src2Busy, dataHazard;

  // Fire condition on output Decoupled
  logic out_fire;

  assign out_fire = to_exu_valid && to_exu_ready;

  // -------------------------------
  // Hazard detection
  // -------------------------------
  always_comb begin
    // busy[0] is always treated as 0 in Chisel update; still safe here.
    src1Busy   = (busy[from_idu_ctrl_rs1] != '0);
    src2Busy   = (busy[from_idu_ctrl_rs2] != '0);
    dataHazard = src1Busy || src2Busy;
  end

  // AnyStopCondition not used (default false in Chisel)
  // HandShakeDeal:
  // consumer.ready := ((!consumer.valid) || producer.fire) && !stop
  // producer.valid := consumer.valid && !invalid
  always_comb begin
    to_exu_valid   = from_idu_valid && !dataHazard;
    from_idu_ready = ((!from_idu_valid) || out_fire);
  end

  // -------------------------------
  // Pass-through fields to output bits
  // (Chisel does outBits.cf <> inBits.cf, outBits.ctrl <> inBits.ctrl, outBits.data <> inBits.data,
  // then overrides rfSrc1/rfSrc2 and fuSrc1/fuSrc2)
  // -------------------------------
  always_comb begin
    // default pass-through
    to_exu_cf_inst     = from_idu_cf_inst;
    to_exu_cf_pc       = from_idu_cf_pc;
    to_exu_cf_next_pc  = from_idu_cf_next_pc;
    to_exu_cf_isBranch = from_idu_cf_isBranch;

    to_exu_ctrl_MemWrite    = from_idu_ctrl_MemWrite;
    to_exu_ctrl_ResSrc      = from_idu_ctrl_ResSrc;
    to_exu_ctrl_fuSrc1Type  = from_idu_ctrl_fuSrc1Type;
    to_exu_ctrl_fuSrc2Type  = from_idu_ctrl_fuSrc2Type;
    to_exu_ctrl_fuType      = from_idu_ctrl_fuType;
    to_exu_ctrl_fuOpType    = from_idu_ctrl_fuOpType;
    to_exu_ctrl_rs1         = from_idu_ctrl_rs1;
    to_exu_ctrl_rs2         = from_idu_ctrl_rs2;
    to_exu_ctrl_rfWen       = from_idu_ctrl_rfWen;
    to_exu_ctrl_rd          = from_idu_ctrl_rd;

    to_exu_data_imm           = from_idu_data_imm;
    to_exu_data_data_from_mem = from_idu_data_data_from_mem;
    to_exu_data_csrRdata      = from_idu_data_csrRdata;

    // overwritten in Chisel:
    to_exu_data_rfSrc1 = from_reg_rfSrc1;
    to_exu_data_rfSrc2 = from_reg_rfSrc2;

    // fuSrc1 selection
    unique case (from_idu_ctrl_fuSrc1Type)
      FUSRC_RF1:  to_exu_data_fuSrc1 = from_reg_rfSrc1;
      FUSRC_PC:   to_exu_data_fuSrc1 = from_idu_cf_pc;
      FUSRC_ZERO: to_exu_data_fuSrc1 = '0;
      default:    to_exu_data_fuSrc1 = '0;
    endcase

    // fuSrc2 selection
    unique case (from_idu_ctrl_fuSrc2Type)
      FUSRC_RF2:  to_exu_data_fuSrc2 = from_reg_rfSrc2;
      FUSRC_IMM:  to_exu_data_fuSrc2 = from_idu_data_imm;
      FUSRC_FOUR: to_exu_data_fuSrc2 = {{(XLEN-3){1'b0}}, 3'd4};
      default:    to_exu_data_fuSrc2 = '0;
    endcase
  end

  // -------------------------------
  // Masks for scoreboard update
  // Chisel:
  // wbuClearMask  = Mux(wb.RegWrite, mask(wb.rd), 0.U)
  // isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, mask(inBits.ctrl.rd), 0.U)
  // -------------------------------
  always_comb begin
    setMask   = '0;
    clearMask = '0;

    if (wb_RegWrite) begin
      clearMask = ({{(NR_GPR){1'b0}}} | ({{(NR_GPR){1'b0}}} + 1'b1)) << wb_rd; // safe shift
    end

    if (from_idu_ctrl_rfWen && out_fire) begin
      setMask = ({{(NR_GPR){1'b0}}} | ({{(NR_GPR){1'b0}}} + 1'b1)) << from_idu_ctrl_rd;
    end

    // ensure x0 not used (like busy(0):=0 in update)
    clearMask[0] = 1'b0;
    setMask[0]   = 1'b0;
  end

  // -------------------------------
  // Scoreboard update (sequential)
  // Mirrors Chisel logic:
  // when(set && clear) hold
  // elsewhen(set) busy = min(maxScore, busy+1)
  // elsewhen(clear) busy = max(0, busy-1)
  // -------------------------------
  integer i;
  always_ff @(posedge clock) begin
    if (reset) begin
      for (i = 0; i < NR_GPR; i++) begin
        busy[i] <= '0;
      end
    end else begin
      busy[0] <= '0;
      for (i = 1; i < NR_GPR; i++) begin
        unique case ({setMask[i], clearMask[i]})
          2'b11: busy[i] <= busy[i]; // hold
          2'b10: begin
            if (busy[i] == BUSY_W'(MAXSCORE)) busy[i] <= BUSY_W'(MAXSCORE);
            else                              busy[i] <= busy[i] + BUSY_W'(1);
          end
          2'b01: begin
            if (busy[i] == '0) busy[i] <= '0;
            else               busy[i] <= busy[i] - BUSY_W'(1);
          end
          default: busy[i] <= busy[i];
        endcase
      end
    end
  end

endmodule
