circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_stage1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:28]
    adda_stage1 <= io.adda @[dut.scala 14:28]
    reg addb_stage1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:28]
    addb_stage1 <= io.addb @[dut.scala 15:28]
    reg adda_stage2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:28]
    adda_stage2 <= adda_stage1 @[dut.scala 17:28]
    reg addb_stage2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:28]
    addb_stage2 <= addb_stage1 @[dut.scala 18:28]
    reg adda_stage3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:28]
    adda_stage3 <= adda_stage2 @[dut.scala 20:28]
    reg addb_stage3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:28]
    addb_stage3 <= addb_stage2 @[dut.scala 21:28]
    reg en_stage1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    en_stage1 <= io.i_en @[dut.scala 24:26]
    reg en_stage2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:26]
    en_stage2 <= en_stage1 @[dut.scala 25:26]
    reg en_stage3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:26]
    en_stage3 <= en_stage2 @[dut.scala 26:26]
    reg en_stage4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:26]
    en_stage4 <= en_stage3 @[dut.scala 27:26]
    wire sum_stage1 : UInt<17> @[dut.scala 30:24]
    reg carry_stage1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:29]
    carry_stage1 <= UInt<1>("h0") @[dut.scala 31:29]
    node _sum_stage1_T = bits(io.adda, 15, 0) @[dut.scala 33:24]
    node _sum_stage1_T_1 = bits(io.addb, 15, 0) @[dut.scala 33:41]
    node _sum_stage1_T_2 = add(_sum_stage1_T, _sum_stage1_T_1) @[dut.scala 33:32]
    node _sum_stage1_T_3 = tail(_sum_stage1_T_2, 1) @[dut.scala 33:32]
    sum_stage1 <= _sum_stage1_T_3 @[dut.scala 33:14]
    node _carry_stage1_T = bits(sum_stage1, 16, 16) @[dut.scala 34:29]
    carry_stage1 <= _carry_stage1_T @[dut.scala 34:16]
    node _partial_sum1_T = bits(sum_stage1, 15, 0) @[dut.scala 36:40]
    reg partial_sum1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 36:29]
    partial_sum1 <= _partial_sum1_T @[dut.scala 36:29]
    wire sum_stage2 : UInt<17> @[dut.scala 39:24]
    reg carry_stage2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:29]
    carry_stage2 <= UInt<1>("h0") @[dut.scala 40:29]
    node _sum_stage2_T = bits(adda_stage1, 31, 16) @[dut.scala 42:28]
    node _sum_stage2_T_1 = bits(addb_stage1, 31, 16) @[dut.scala 42:50]
    node _sum_stage2_T_2 = add(_sum_stage2_T, _sum_stage2_T_1) @[dut.scala 42:37]
    node _sum_stage2_T_3 = tail(_sum_stage2_T_2, 1) @[dut.scala 42:37]
    node _sum_stage2_T_4 = add(_sum_stage2_T_3, carry_stage1) @[dut.scala 42:59]
    node _sum_stage2_T_5 = tail(_sum_stage2_T_4, 1) @[dut.scala 42:59]
    sum_stage2 <= _sum_stage2_T_5 @[dut.scala 42:14]
    node _carry_stage2_T = bits(sum_stage2, 16, 16) @[dut.scala 43:29]
    carry_stage2 <= _carry_stage2_T @[dut.scala 43:16]
    node _partial_sum2_T = bits(sum_stage2, 15, 0) @[dut.scala 45:40]
    reg partial_sum2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 45:29]
    partial_sum2 <= _partial_sum2_T @[dut.scala 45:29]
    wire sum_stage3 : UInt<17> @[dut.scala 48:24]
    reg carry_stage3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 49:29]
    carry_stage3 <= UInt<1>("h0") @[dut.scala 49:29]
    node _sum_stage3_T = bits(adda_stage2, 47, 32) @[dut.scala 51:28]
    node _sum_stage3_T_1 = bits(addb_stage2, 47, 32) @[dut.scala 51:50]
    node _sum_stage3_T_2 = add(_sum_stage3_T, _sum_stage3_T_1) @[dut.scala 51:37]
    node _sum_stage3_T_3 = tail(_sum_stage3_T_2, 1) @[dut.scala 51:37]
    node _sum_stage3_T_4 = add(_sum_stage3_T_3, carry_stage2) @[dut.scala 51:59]
    node _sum_stage3_T_5 = tail(_sum_stage3_T_4, 1) @[dut.scala 51:59]
    sum_stage3 <= _sum_stage3_T_5 @[dut.scala 51:14]
    node _carry_stage3_T = bits(sum_stage3, 16, 16) @[dut.scala 52:29]
    carry_stage3 <= _carry_stage3_T @[dut.scala 52:16]
    node _partial_sum3_T = bits(sum_stage3, 15, 0) @[dut.scala 54:40]
    reg partial_sum3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:29]
    partial_sum3 <= _partial_sum3_T @[dut.scala 54:29]
    wire sum_stage4 : UInt<17> @[dut.scala 57:24]
    wire carry_stage4 : UInt<1> @[dut.scala 58:26]
    node _sum_stage4_T = bits(adda_stage3, 63, 48) @[dut.scala 60:28]
    node _sum_stage4_T_1 = bits(addb_stage3, 63, 48) @[dut.scala 60:50]
    node _sum_stage4_T_2 = add(_sum_stage4_T, _sum_stage4_T_1) @[dut.scala 60:37]
    node _sum_stage4_T_3 = tail(_sum_stage4_T_2, 1) @[dut.scala 60:37]
    node _sum_stage4_T_4 = add(_sum_stage4_T_3, carry_stage3) @[dut.scala 60:59]
    node _sum_stage4_T_5 = tail(_sum_stage4_T_4, 1) @[dut.scala 60:59]
    sum_stage4 <= _sum_stage4_T_5 @[dut.scala 60:14]
    node _carry_stage4_T = bits(sum_stage4, 16, 16) @[dut.scala 61:29]
    carry_stage4 <= _carry_stage4_T @[dut.scala 61:16]
    node _partial_sum4_T = bits(sum_stage4, 15, 0) @[dut.scala 63:40]
    reg partial_sum4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 63:29]
    partial_sum4 <= _partial_sum4_T @[dut.scala 63:29]
    reg final_carry : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 64:28]
    final_carry <= carry_stage4 @[dut.scala 64:28]
    reg sum1_stage2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 67:28]
    sum1_stage2 <= partial_sum1 @[dut.scala 67:28]
    reg sum1_stage3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 68:28]
    sum1_stage3 <= sum1_stage2 @[dut.scala 68:28]
    reg sum1_stage4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 69:28]
    sum1_stage4 <= sum1_stage3 @[dut.scala 69:28]
    reg sum2_stage3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 71:28]
    sum2_stage3 <= partial_sum2 @[dut.scala 71:28]
    reg sum2_stage4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 72:28]
    sum2_stage4 <= sum2_stage3 @[dut.scala 72:28]
    reg sum3_stage4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 74:28]
    sum3_stage4 <= partial_sum3 @[dut.scala 74:28]
    node io_result_lo = cat(sum2_stage4, sum1_stage4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(final_carry, partial_sum4) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum3_stage4) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 77:13]
    io.o_en <= en_stage4 @[dut.scala 80:11]

