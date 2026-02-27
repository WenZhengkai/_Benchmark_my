module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);

  // RegEnable(io.adda/addb, 0.U, io.i_en)
  reg [63:0] adda_reg;
  reg [63:0] addb_reg;

  // 4-stage enable pipeline (VecInit(Seq.fill(4)(false.B)))
  reg [3:0] en_pipeline;

  // Pipeline registers for sums and carries
  reg [15:0] stage1_sum_r, stage2_sum_r, stage3_sum_r, stage4_sum_r;
  reg        carry1_r, carry2_r, carry3_r, final_carry_r;

  // Combinational RCA16 equivalents for each stage
  wire [16:0] stage1_full = {1'b0, adda_reg[15:0]}   + {1'b0, addb_reg[15:0]}   + 17'd0;
  wire [16:0] stage2_full = {1'b0, adda_reg[31:16]}  + {1'b0, addb_reg[31:16]}  + {16'd0, carry1_r};
  wire [16:0] stage3_full = {1'b0, adda_reg[47:32]}  + {1'b0, addb_reg[47:32]}  + {16'd0, carry2_r};
  wire [16:0] stage4_full = {1'b0, adda_reg[63:48]}  + {1'b0, addb_reg[63:48]}  + {16'd0, carry3_r};

  // Result register (RegInit(0.U(65.W)))
  reg [64:0] result_reg;

  always @(posedge clock) begin
    if (reset) begin
      adda_reg       <= 64'd0;
      addb_reg       <= 64'd0;
      en_pipeline    <= 4'b0000;

      stage1_sum_r   <= 16'd0; carry1_r <= 1'b0;
      stage2_sum_r   <= 16'd0; carry2_r <= 1'b0;
      stage3_sum_r   <= 16'd0; carry3_r <= 1'b0;
      stage4_sum_r   <= 16'd0; final_carry_r <= 1'b0;

      result_reg     <= 65'd0;
    end else begin
      // Enable pipeline behavior matching the Chisel code:
      // when(io.i_en) en_pipeline(0):=true; then shift
      // (note: this keeps en_pipeline(0) sticky once set, as in the given Chisel)
      if (io_i_en)
        en_pipeline[0] <= 1'b1;
      en_pipeline[3] <= en_pipeline[2];
      en_pipeline[2] <= en_pipeline[1];
      en_pipeline[1] <= en_pipeline[0];

      // RegEnable for inputs
      if (io_i_en) begin
        adda_reg <= io_adda;
        addb_reg <= io_addb;
      end

      // RegNext for each stage output/carry
      stage1_sum_r     <= stage1_full[15:0];
      carry1_r         <= stage1_full[16];

      stage2_sum_r     <= stage2_full[15:0];
      carry2_r         <= stage2_full[16];

      stage3_sum_r     <= stage3_full[15:0];
      carry3_r         <= stage3_full[16];

      stage4_sum_r     <= stage4_full[15:0];
      final_carry_r    <= stage4_full[16];

      // result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
      result_reg <= {final_carry_r, stage4_sum_r, stage3_sum_r, stage2_sum_r, stage1_sum_r};
    end
  end

  assign io_result = result_reg;
  assign io_o_en   = en_pipeline[3];

endmodule