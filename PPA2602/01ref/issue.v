
module issue_golden #(
  parameter int XLEN       = 32,
  parameter bit CONFIG_RVE = 1,
  parameter int NR_GPR     = (CONFIG_RVE ? 16 : 32),
  parameter int MAXSCORE   = 3
)(
  input  logic clk,
  input  logic rst_n,

  // ----------------------------
  // from_idu: Decoupled(DecodeIO)
  // ----------------------------
  input  logic                 from_idu_valid,
  output logic                 from_idu_ready,

  input  logic [31:0]          from_idu_cf_inst,
  input  logic [XLEN-1:0]      from_idu_cf_pc,
  input  logic [XLEN-1:0]      from_idu_cf_next_pc,
  input  logic                 from_idu_cf_isBranch,

  input  logic                 from_idu_ctrl_MemWrite,
  input  logic [3:0]           from_idu_ctrl_ResSrc,
  input  logic [2:0]           from_idu_ctrl_fuSrc1Type,
  input  logic [2:0]           from_idu_ctrl_fuSrc2Type,
  input  logic [2:0]           from_idu_ctrl_fuType,     // width depends on your FuType.num; using 3 bits here
  input  logic [6:0]           from_idu_ctrl_fuOpType,
  input  logic [4:0]           from_idu_ctrl_rs1,
  input  logic [4:0]           from_idu_ctrl_rs2,
  input  logic                 from_idu_ctrl_rfWen,
  input  logic [4:0]           from_idu_ctrl_rd,

  input  logic [XLEN-1:0]      from_idu_data_imm,
  input  logic [XLEN-1:0]      from_idu_data_Alu0Res_bits,
  input  logic                 from_idu_data_Alu0Res_valid,
  input  logic [XLEN-1:0]      from_idu_data_data_from_mem,
  input  logic [XLEN-1:0]      from_idu_data_csrRdata,
  // rfSrc1/rfSrc2 in incoming bundle are ignored/overridden

  // ----------------------------
  // to_exu: Decoupled(DecodeIO)
  // ----------------------------
  output logic                 to_exu_valid,
  input  logic                 to_exu_ready,

  output logic [31:0]          to_exu_cf_inst,
  output logic [XLEN-1:0]      to_exu_cf_pc,
  output logic [XLEN-1:0]      to_exu_cf_next_pc,
  output logic                 to_exu_cf_isBranch,

  output logic                 to_exu_ctrl_MemWrite,
  output logic [3:0]           to_exu_ctrl_ResSrc,
  output logic [2:0]           to_exu_ctrl_fuSrc1Type,
  output logic [2:0]           to_exu_ctrl_fuSrc2Type,
  output logic [2:0]           to_exu_ctrl_fuType,
  output logic [6:0]           to_exu_ctrl_fuOpType,
  output logic [4:0]           to_exu_ctrl_rs1,
  output logic [4:0]           to_exu_ctrl_rs2,
  output logic                 to_exu_ctrl_rfWen,
  output logic [4:0]           to_exu_ctrl_rd,

  output logic [XLEN-1:0]      to_exu_data_fuSrc1,
  output logic [XLEN-1:0]      to_exu_data_fuSrc2,
  output logic [XLEN-1:0]      to_exu_data_imm,
  output logic [XLEN-1:0]      to_exu_data_Alu0Res_bits,
  output logic                 to_exu_data_Alu0Res_valid,
  output logic [XLEN-1:0]      to_exu_data_data_from_mem,
  output logic [XLEN-1:0]      to_exu_data_csrRdata,
  output logic [XLEN-1:0]      to_exu_data_rfSrc1,
  output logic [XLEN-1:0]      to_exu_data_rfSrc2,

  // ----------------------------
  // wb: writeback clear scoreboard
  // ----------------------------
  input  logic [4:0]           wb_rd,
  input  logic [XLEN-1:0]      wb_Res,
  input  logic                 wb_RegWrite,

  // ----------------------------
  // from_reg: read register file
  // ----------------------------
  input  logic [XLEN-1:0]      from_reg_rfSrc1,
  input  logic [XLEN-1:0]      from_reg_rfSrc2
);

  // ----------------------------
  // Localparams for FuSrcType encoding (match your Chisel)
  // ----------------------------
  localparam logic [2:0] FUSRC_RFSRC1 = 3'b000;
  localparam logic [2:0] FUSRC_RFSRC2 = 3'b001;
  localparam logic [2:0] FUSRC_PC     = 3'b010;
  localparam logic [2:0] FUSRC_IMM    = 3'b011;
  localparam logic [2:0] FUSRC_ZERO   = 3'b100;
  localparam logic [2:0] FUSRC_FOUR   = 3'b101;

  // ----------------------------
  // Handshake signals
  // ----------------------------
  logic anyStopCondition;
  logic anyInvalidCondition;
  logic to_exu_fire;

  assign anyStopCondition   = 1'b0; // your Chisel default AnyStopCondition=false.B
  assign to_exu_fire        = to_exu_valid && to_exu_ready;

  // ----------------------------
  // Scoreboard
  // busy[idx] : count of in-flight writers (saturating up/down)
  // ----------------------------
  localparam int BUSY_W = (MAXSCORE <= 1) ? 1 : $clog2(MAXSCORE + 1);
  logic [BUSY_W-1:0] busy [0:NR_GPR-1];

  function automatic logic isBusy(input logic [4:0] idx);
    if (idx >= NR_GPR) isBusy = 1'b0; // out-of-range reg index treated as not busy
    else               isBusy = (busy[idx] != '0);
  endfunction

  function automatic logic [NR_GPR-1:0] mask(input logic [4:0] idx);
    logic [NR_GPR-1:0] m;
    begin
      m = '0;
      if (idx < NR_GPR) m[idx] = 1'b1;
      mask = m;
    end
  endfunction

  // Hazard detect
  logic src1Busy, src2Busy, dataHazard;
  assign src1Busy = isBusy(from_idu_ctrl_rs1);
  assign src2Busy = isBusy(from_idu_ctrl_rs2);
  assign dataHazard = src1Busy || src2Busy;

  assign anyInvalidCondition = dataHazard;

  // HandShakeDeal (exactly like your Chisel)
  assign from_idu_ready = ((from_idu_valid == 1'b0) || to_exu_fire) && (anyStopCondition == 1'b0);
  assign to_exu_valid   = from_idu_valid && (anyInvalidCondition == 1'b0);

  // ----------------------------
  // Pass-through bits (combinational)
  // Note: With Decoupled, typically you register on fire; your Chisel does not,
  // it wires bits through. So we do the same.
  // ----------------------------
  assign to_exu_cf_inst      = from_idu_cf_inst;
  assign to_exu_cf_pc        = from_idu_cf_pc;
  assign to_exu_cf_next_pc   = from_idu_cf_next_pc;
  assign to_exu_cf_isBranch  = from_idu_cf_isBranch;

  assign to_exu_ctrl_MemWrite   = from_idu_ctrl_MemWrite;
  assign to_exu_ctrl_ResSrc     = from_idu_ctrl_ResSrc;
  assign to_exu_ctrl_fuSrc1Type = from_idu_ctrl_fuSrc1Type;
  assign to_exu_ctrl_fuSrc2Type = from_idu_ctrl_fuSrc2Type;
  assign to_exu_ctrl_fuType     = from_idu_ctrl_fuType;
  assign to_exu_ctrl_fuOpType   = from_idu_ctrl_fuOpType;
  assign to_exu_ctrl_rs1        = from_idu_ctrl_rs1;
  assign to_exu_ctrl_rs2        = from_idu_ctrl_rs2;
  assign to_exu_ctrl_rfWen      = from_idu_ctrl_rfWen;
  assign to_exu_ctrl_rd         = from_idu_ctrl_rd;

  // data bundle pass-through + override rfSrc1/2
  assign to_exu_data_imm            = from_idu_data_imm;
  assign to_exu_data_Alu0Res_bits   = from_idu_data_Alu0Res_bits;
  assign to_exu_data_Alu0Res_valid  = from_idu_data_Alu0Res_valid;
  assign to_exu_data_data_from_mem  = from_idu_data_data_from_mem;
  assign to_exu_data_csrRdata       = from_idu_data_csrRdata;

  assign to_exu_data_rfSrc1 = from_reg_rfSrc1;
  assign to_exu_data_rfSrc2 = from_reg_rfSrc2;

  // fuSrc1 mux (MuxLookup default 0)
  always_comb begin
    unique case (from_idu_ctrl_fuSrc1Type)
      FUSRC_RFSRC1: to_exu_data_fuSrc1 = from_reg_rfSrc1;
      FUSRC_PC:     to_exu_data_fuSrc1 = from_idu_cf_pc;
      FUSRC_ZERO:   to_exu_data_fuSrc1 = '0;
      default:      to_exu_data_fuSrc1 = '0;
    endcase
  end

  // fuSrc2 mux (MuxLookup default 0)
  always_comb begin
    unique case (from_idu_ctrl_fuSrc2Type)
      FUSRC_RFSRC2: to_exu_data_fuSrc2 = from_reg_rfSrc2;
      FUSRC_IMM:    to_exu_data_fuSrc2 = from_idu_data_imm;
      FUSRC_FOUR:   to_exu_data_fuSrc2 = {{(XLEN-3){1'b0}}, 3'd4};
      default:      to_exu_data_fuSrc2 = '0;
    endcase
  end

  // ----------------------------
  // Scoreboard update (sequential)
  // setMask: when issuing an instruction that writes rd AND out.fire
  // clearMask: when writeback happens (wb_RegWrite)
  // ----------------------------
  logic [NR_GPR-1:0] setMask, clearMask;

  assign setMask   = (from_idu_ctrl_rfWen && to_exu_fire) ? mask(from_idu_ctrl_rd) : '0;
  assign clearMask = (wb_RegWrite) ? mask(wb_rd) : '0;

  integer i;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      for (i = 0; i < NR_GPR; i++) begin
        busy[i] <= '0;
      end
    end else begin
      busy[0] <= '0; // x0 always 0
      for (i = 1; i < NR_GPR; i++) begin
        if (setMask[i] && clearMask[i]) begin
          busy[i] <= busy[i];
        end else if (setMask[i]) begin
          if (busy[i] == BUSY_W'(MAXSCORE)) busy[i] <= BUSY_W'(MAXSCORE);
          else                               busy[i] <= busy[i] + BUSY_W'(1);
        end else if (clearMask[i]) begin
          if (busy[i] == '0) busy[i] <= '0;
          else                busy[i] <= busy[i] - BUSY_W'(1);
        end else begin
          busy[i] <= busy[i];
        end
      end
    end
  end

endmodule
