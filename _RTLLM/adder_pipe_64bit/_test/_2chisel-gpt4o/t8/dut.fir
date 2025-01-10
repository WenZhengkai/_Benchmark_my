circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_a : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 15:25]
    reg stage1_b : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 16:25]
    reg stage1_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:29]
    reg stage2_a : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 19:25]
    reg stage2_b : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 20:25]
    reg stage2_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:29]
    reg stage3_a : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 23:25]
    reg stage3_b : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 24:25]
    reg stage3_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:29]
    reg stage4_a : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 27:25]
    reg stage4_b : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 28:25]
    reg stage4_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:29]
    wire stage1_sum : UInt<17> @[dut.scala 31:24]
    wire stage2_sum : UInt<17> @[dut.scala 32:24]
    wire stage3_sum : UInt<17> @[dut.scala 33:24]
    wire stage4_sum : UInt<17> @[dut.scala 34:24]
    reg en_r1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), en_r1) @[dut.scala 37:22]
    en_r1 <= io.i_en @[dut.scala 37:22]
    reg en_r2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), en_r2) @[dut.scala 38:22]
    en_r2 <= en_r1 @[dut.scala 38:22]
    reg en_r3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), en_r3) @[dut.scala 39:22]
    en_r3 <= en_r2 @[dut.scala 39:22]
    reg en_r4 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), en_r4) @[dut.scala 40:22]
    en_r4 <= en_r3 @[dut.scala 40:22]
    when io.i_en : @[dut.scala 43:17]
      node _stage1_a_T = bits(io.adda, 15, 0) @[dut.scala 44:24]
      stage1_a <= _stage1_a_T @[dut.scala 44:14]
      node _stage1_b_T = bits(io.addb, 15, 0) @[dut.scala 45:24]
      stage1_b <= _stage1_b_T @[dut.scala 45:14]
      stage1_carry <= UInt<1>("h0") @[dut.scala 46:18]
    node _stage1_sum_T = add(stage1_a, stage1_b) @[dut.scala 49:26]
    node _stage1_sum_T_1 = tail(_stage1_sum_T, 1) @[dut.scala 49:26]
    node _stage1_sum_T_2 = add(_stage1_sum_T_1, stage1_carry) @[dut.scala 49:37]
    node _stage1_sum_T_3 = tail(_stage1_sum_T_2, 1) @[dut.scala 49:37]
    stage1_sum <= _stage1_sum_T_3 @[dut.scala 49:14]
    when en_r1 : @[dut.scala 52:15]
      node _stage2_a_T = bits(io.adda, 31, 16) @[dut.scala 53:24]
      stage2_a <= _stage2_a_T @[dut.scala 53:14]
      node _stage2_b_T = bits(io.addb, 31, 16) @[dut.scala 54:24]
      stage2_b <= _stage2_b_T @[dut.scala 54:14]
      node _stage2_carry_T = bits(stage1_sum, 16, 16) @[dut.scala 55:31]
      stage2_carry <= _stage2_carry_T @[dut.scala 55:18]
    node _stage2_sum_T = add(stage2_a, stage2_b) @[dut.scala 58:26]
    node _stage2_sum_T_1 = tail(_stage2_sum_T, 1) @[dut.scala 58:26]
    node _stage2_sum_T_2 = add(_stage2_sum_T_1, stage2_carry) @[dut.scala 58:37]
    node _stage2_sum_T_3 = tail(_stage2_sum_T_2, 1) @[dut.scala 58:37]
    stage2_sum <= _stage2_sum_T_3 @[dut.scala 58:14]
    when en_r2 : @[dut.scala 61:15]
      node _stage3_a_T = bits(io.adda, 47, 32) @[dut.scala 62:24]
      stage3_a <= _stage3_a_T @[dut.scala 62:14]
      node _stage3_b_T = bits(io.addb, 47, 32) @[dut.scala 63:24]
      stage3_b <= _stage3_b_T @[dut.scala 63:14]
      node _stage3_carry_T = bits(stage2_sum, 16, 16) @[dut.scala 64:31]
      stage3_carry <= _stage3_carry_T @[dut.scala 64:18]
    node _stage3_sum_T = add(stage3_a, stage3_b) @[dut.scala 67:26]
    node _stage3_sum_T_1 = tail(_stage3_sum_T, 1) @[dut.scala 67:26]
    node _stage3_sum_T_2 = add(_stage3_sum_T_1, stage3_carry) @[dut.scala 67:37]
    node _stage3_sum_T_3 = tail(_stage3_sum_T_2, 1) @[dut.scala 67:37]
    stage3_sum <= _stage3_sum_T_3 @[dut.scala 67:14]
    when en_r3 : @[dut.scala 70:15]
      node _stage4_a_T = bits(io.adda, 63, 48) @[dut.scala 71:24]
      stage4_a <= _stage4_a_T @[dut.scala 71:14]
      node _stage4_b_T = bits(io.addb, 63, 48) @[dut.scala 72:24]
      stage4_b <= _stage4_b_T @[dut.scala 72:14]
      node _stage4_carry_T = bits(stage3_sum, 16, 16) @[dut.scala 73:31]
      stage4_carry <= _stage4_carry_T @[dut.scala 73:18]
    node _stage4_sum_T = add(stage4_a, stage4_b) @[dut.scala 76:26]
    node _stage4_sum_T_1 = tail(_stage4_sum_T, 1) @[dut.scala 76:26]
    node _stage4_sum_T_2 = add(_stage4_sum_T_1, stage4_carry) @[dut.scala 76:37]
    node _stage4_sum_T_3 = tail(_stage4_sum_T_2, 1) @[dut.scala 76:37]
    stage4_sum <= _stage4_sum_T_3 @[dut.scala 76:14]
    node _io_result_T = bits(stage4_sum, 16, 16) @[dut.scala 79:30]
    node _io_result_T_1 = bits(stage4_sum, 15, 0) @[dut.scala 79:46]
    node _io_result_T_2 = bits(stage3_sum, 15, 0) @[dut.scala 79:65]
    node _io_result_T_3 = bits(stage2_sum, 15, 0) @[dut.scala 79:84]
    node _io_result_T_4 = bits(stage1_sum, 15, 0) @[dut.scala 79:103]
    node io_result_lo = cat(_io_result_T_3, _io_result_T_4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, _io_result_T_2) @[Cat.scala 33:92]
    node _io_result_T_5 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_5 @[dut.scala 79:13]
    io.o_en <= en_r4 @[dut.scala 80:11]

