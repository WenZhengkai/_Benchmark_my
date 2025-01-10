circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_out_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 14:31]
    reg stage2_out_sum : UInt<33>, clock with :
      reset => (reset, UInt<33>("h0")) @[dut.scala 15:31]
    reg stage3_out_sum : UInt<49>, clock with :
      reset => (reset, UInt<49>("h0")) @[dut.scala 16:31]
    reg stage4_out_sum : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 17:31]
    reg stage1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    stage1_en <= io.i_en @[dut.scala 19:26]
    reg stage2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
    stage2_en <= stage1_en @[dut.scala 20:26]
    reg stage3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    stage3_en <= stage2_en @[dut.scala 21:26]
    reg stage4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:26]
    stage4_en <= stage3_en @[dut.scala 22:26]
    node _stage1_sum_T = bits(io.adda, 15, 0) @[dut.scala 24:27]
    node _stage1_sum_T_1 = bits(io.addb, 15, 0) @[dut.scala 24:45]
    node stage1_sum = add(_stage1_sum_T, _stage1_sum_T_1) @[dut.scala 24:35]
    node _stage2_sum_T = bits(io.adda, 31, 16) @[dut.scala 25:27]
    node _stage2_sum_T_1 = bits(io.addb, 31, 16) @[dut.scala 25:46]
    node _stage2_sum_T_2 = add(_stage2_sum_T, _stage2_sum_T_1) @[dut.scala 25:36]
    node _stage2_sum_T_3 = bits(stage1_out_sum, 16, 16) @[dut.scala 25:71]
    node _stage2_sum_T_4 = add(_stage2_sum_T_2, _stage2_sum_T_3) @[dut.scala 25:55]
    node stage2_sum = tail(_stage2_sum_T_4, 1) @[dut.scala 25:55]
    node _stage3_sum_T = bits(io.adda, 47, 32) @[dut.scala 26:27]
    node _stage3_sum_T_1 = bits(io.addb, 47, 32) @[dut.scala 26:46]
    node _stage3_sum_T_2 = add(_stage3_sum_T, _stage3_sum_T_1) @[dut.scala 26:36]
    node _stage3_sum_T_3 = bits(stage2_out_sum, 32, 32) @[dut.scala 26:71]
    node _stage3_sum_T_4 = add(_stage3_sum_T_2, _stage3_sum_T_3) @[dut.scala 26:55]
    node stage3_sum = tail(_stage3_sum_T_4, 1) @[dut.scala 26:55]
    node _stage4_sum_T = bits(io.adda, 63, 48) @[dut.scala 27:27]
    node _stage4_sum_T_1 = bits(io.addb, 63, 48) @[dut.scala 27:46]
    node _stage4_sum_T_2 = add(_stage4_sum_T, _stage4_sum_T_1) @[dut.scala 27:36]
    node _stage4_sum_T_3 = bits(stage3_out_sum, 48, 48) @[dut.scala 27:71]
    node _stage4_sum_T_4 = add(_stage4_sum_T_2, _stage4_sum_T_3) @[dut.scala 27:55]
    node stage4_sum = tail(_stage4_sum_T_4, 1) @[dut.scala 27:55]
    when io.i_en : @[dut.scala 29:17]
      stage1_out_sum <= stage1_sum @[dut.scala 30:20]
    when stage1_en : @[dut.scala 33:19]
      node _stage2_out_sum_T = bits(stage2_sum, 16, 0) @[dut.scala 34:37]
      node _stage2_out_sum_T_1 = bits(stage1_out_sum, 15, 0) @[dut.scala 34:60]
      node _stage2_out_sum_T_2 = cat(_stage2_out_sum_T, _stage2_out_sum_T_1) @[Cat.scala 33:92]
      stage2_out_sum <= _stage2_out_sum_T_2 @[dut.scala 34:20]
    when stage2_en : @[dut.scala 37:19]
      node _stage3_out_sum_T = bits(stage3_sum, 16, 0) @[dut.scala 38:37]
      node _stage3_out_sum_T_1 = bits(stage2_out_sum, 31, 0) @[dut.scala 38:60]
      node _stage3_out_sum_T_2 = cat(_stage3_out_sum_T, _stage3_out_sum_T_1) @[Cat.scala 33:92]
      stage3_out_sum <= _stage3_out_sum_T_2 @[dut.scala 38:20]
    when stage3_en : @[dut.scala 41:19]
      node _stage4_out_sum_T = bits(stage4_sum, 16, 0) @[dut.scala 42:37]
      node _stage4_out_sum_T_1 = bits(stage3_out_sum, 47, 0) @[dut.scala 42:60]
      node _stage4_out_sum_T_2 = cat(_stage4_out_sum_T, _stage4_out_sum_T_1) @[Cat.scala 33:92]
      stage4_out_sum <= _stage4_out_sum_T_2 @[dut.scala 42:20]
    io.result <= stage4_out_sum @[dut.scala 45:13]
    io.o_en <= stage4_en @[dut.scala 46:13]

