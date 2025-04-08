circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 14:27]
    reg stage2_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 15:27]
    reg stage3_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 16:27]
    reg stage4_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 17:27]
    reg en_stage1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
    en_stage1 <= io.i_en @[dut.scala 20:26]
    reg en_stage2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    en_stage2 <= en_stage1 @[dut.scala 21:26]
    reg en_stage3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:26]
    en_stage3 <= en_stage2 @[dut.scala 22:26]
    reg en_stage4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:26]
    en_stage4 <= en_stage3 @[dut.scala 23:26]
    when io.i_en : @[dut.scala 26:17]
      node _sum0_T = bits(io.adda, 15, 0) @[dut.scala 27:23]
      node _sum0_T_1 = bits(io.addb, 15, 0) @[dut.scala 27:41]
      node sum0 = add(_sum0_T, _sum0_T_1) @[dut.scala 27:31]
      stage1_sum <= sum0 @[dut.scala 28:16]
    when en_stage1 : @[dut.scala 32:19]
      node _sum1_T = bits(io.adda, 31, 16) @[dut.scala 33:23]
      node _sum1_T_1 = bits(io.addb, 31, 16) @[dut.scala 33:42]
      node _sum1_T_2 = add(_sum1_T, _sum1_T_1) @[dut.scala 33:32]
      node _sum1_T_3 = bits(stage1_sum, 16, 16) @[dut.scala 33:63]
      node _sum1_T_4 = add(_sum1_T_2, _sum1_T_3) @[dut.scala 33:51]
      node sum1 = tail(_sum1_T_4, 1) @[dut.scala 33:51]
      stage2_sum <= sum1 @[dut.scala 34:16]
    when en_stage2 : @[dut.scala 38:19]
      node _sum2_T = bits(io.adda, 47, 32) @[dut.scala 39:23]
      node _sum2_T_1 = bits(io.addb, 47, 32) @[dut.scala 39:42]
      node _sum2_T_2 = add(_sum2_T, _sum2_T_1) @[dut.scala 39:32]
      node _sum2_T_3 = bits(stage2_sum, 16, 16) @[dut.scala 39:63]
      node _sum2_T_4 = add(_sum2_T_2, _sum2_T_3) @[dut.scala 39:51]
      node sum2 = tail(_sum2_T_4, 1) @[dut.scala 39:51]
      stage3_sum <= sum2 @[dut.scala 40:16]
    when en_stage3 : @[dut.scala 44:19]
      node _sum3_T = bits(io.adda, 63, 48) @[dut.scala 45:23]
      node _sum3_T_1 = bits(io.addb, 63, 48) @[dut.scala 45:42]
      node _sum3_T_2 = add(_sum3_T, _sum3_T_1) @[dut.scala 45:32]
      node _sum3_T_3 = bits(stage3_sum, 16, 16) @[dut.scala 45:63]
      node _sum3_T_4 = add(_sum3_T_2, _sum3_T_3) @[dut.scala 45:51]
      node sum3 = tail(_sum3_T_4, 1) @[dut.scala 45:51]
      stage4_sum <= sum3 @[dut.scala 46:16]
    io.o_en <= en_stage4 @[dut.scala 50:11]
    node _io_result_T = bits(stage4_sum, 16, 16) @[dut.scala 53:30]
    node _io_result_T_1 = bits(stage4_sum, 15, 0) @[dut.scala 53:46]
    node _io_result_T_2 = bits(stage3_sum, 15, 0) @[dut.scala 53:65]
    node _io_result_T_3 = bits(stage2_sum, 15, 0) @[dut.scala 53:84]
    node _io_result_T_4 = bits(stage1_sum, 15, 0) @[dut.scala 53:103]
    node io_result_lo = cat(_io_result_T_3, _io_result_T_4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, _io_result_T_2) @[Cat.scala 33:92]
    node _io_result_T_5 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_5 @[dut.scala 53:13]

