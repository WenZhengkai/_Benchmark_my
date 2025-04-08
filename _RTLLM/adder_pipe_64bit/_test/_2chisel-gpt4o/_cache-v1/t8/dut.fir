circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    stage1_en <= io.i_en @[dut.scala 14:26]
    reg stage1_adda : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 15:28]
    stage1_adda <= io.adda @[dut.scala 15:28]
    reg stage1_addb : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 16:28]
    stage1_addb <= io.addb @[dut.scala 16:28]
    reg stage2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    stage2_en <= stage1_en @[dut.scala 18:26]
    reg stage2_sum : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 19:27]
    reg stage3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    stage3_en <= stage2_en @[dut.scala 21:26]
    reg stage3_sum : UInt<33>, clock with :
      reset => (reset, UInt<33>("h0")) @[dut.scala 22:27]
    reg stage4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    stage4_en <= stage3_en @[dut.scala 24:26]
    reg stage4_sum : UInt<49>, clock with :
      reset => (reset, UInt<49>("h0")) @[dut.scala 25:27]
    reg finalResult : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 27:28]
    reg finalEn : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:24]
    finalEn <= stage4_en @[dut.scala 28:24]
    node _stage1_sum_T = bits(stage1_adda, 15, 0) @[dut.scala 31:31]
    node _stage1_sum_T_1 = bits(stage1_addb, 15, 0) @[dut.scala 31:53]
    node stage1_sum = add(_stage1_sum_T, _stage1_sum_T_1) @[dut.scala 31:39]
    node _stage2_sum_temp_T = bits(stage1_adda, 31, 16) @[dut.scala 34:36]
    node _stage2_sum_temp_T_1 = bits(stage1_addb, 31, 16) @[dut.scala 34:59]
    node _stage2_sum_temp_T_2 = add(_stage2_sum_temp_T, _stage2_sum_temp_T_1) @[dut.scala 34:45]
    node _stage2_sum_temp_T_3 = bits(stage1_sum, 16, 16) @[dut.scala 34:80]
    node _stage2_sum_temp_T_4 = add(_stage2_sum_temp_T_2, _stage2_sum_temp_T_3) @[dut.scala 34:68]
    node stage2_sum_temp = tail(_stage2_sum_temp_T_4, 1) @[dut.scala 34:68]
    when stage2_en : @[dut.scala 35:19]
      node _stage2_sum_T = bits(stage2_sum_temp, 16, 16) @[dut.scala 36:38]
      node _stage2_sum_T_1 = bits(stage1_sum, 15, 0) @[dut.scala 36:54]
      node _stage2_sum_T_2 = cat(_stage2_sum_T, _stage2_sum_T_1) @[Cat.scala 33:92]
      stage2_sum <= _stage2_sum_T_2 @[dut.scala 36:16]
    node _stage3_sum_temp_T = bits(stage1_adda, 47, 32) @[dut.scala 40:36]
    node _stage3_sum_temp_T_1 = bits(stage1_addb, 47, 32) @[dut.scala 40:59]
    node _stage3_sum_temp_T_2 = add(_stage3_sum_temp_T, _stage3_sum_temp_T_1) @[dut.scala 40:45]
    node _stage3_sum_temp_T_3 = bits(stage2_sum, 16, 16) @[dut.scala 40:80]
    node _stage3_sum_temp_T_4 = add(_stage3_sum_temp_T_2, _stage3_sum_temp_T_3) @[dut.scala 40:68]
    node stage3_sum_temp = tail(_stage3_sum_temp_T_4, 1) @[dut.scala 40:68]
    when stage3_en : @[dut.scala 41:19]
      node _stage3_sum_T = bits(stage3_sum_temp, 16, 16) @[dut.scala 42:38]
      node _stage3_sum_T_1 = bits(stage2_sum, 15, 0) @[dut.scala 42:54]
      node _stage3_sum_T_2 = cat(_stage3_sum_T, _stage3_sum_T_1) @[Cat.scala 33:92]
      stage3_sum <= _stage3_sum_T_2 @[dut.scala 42:16]
    node _stage4_sum_temp_T = bits(stage1_adda, 63, 48) @[dut.scala 46:36]
    node _stage4_sum_temp_T_1 = bits(stage1_addb, 63, 48) @[dut.scala 46:59]
    node _stage4_sum_temp_T_2 = add(_stage4_sum_temp_T, _stage4_sum_temp_T_1) @[dut.scala 46:45]
    node _stage4_sum_temp_T_3 = bits(stage3_sum, 16, 16) @[dut.scala 46:80]
    node _stage4_sum_temp_T_4 = add(_stage4_sum_temp_T_2, _stage4_sum_temp_T_3) @[dut.scala 46:68]
    node stage4_sum_temp = tail(_stage4_sum_temp_T_4, 1) @[dut.scala 46:68]
    when stage4_en : @[dut.scala 47:19]
      node _stage4_sum_T = bits(stage4_sum_temp, 16, 16) @[dut.scala 48:38]
      node _stage4_sum_T_1 = bits(stage3_sum, 15, 0) @[dut.scala 48:54]
      node _stage4_sum_T_2 = cat(_stage4_sum_T, _stage4_sum_T_1) @[Cat.scala 33:92]
      stage4_sum <= _stage4_sum_T_2 @[dut.scala 48:16]
    when finalEn : @[dut.scala 52:17]
      node _finalResult_T = bits(stage4_sum, 16, 16) @[dut.scala 53:34]
      node _finalResult_T_1 = bits(stage4_sum, 15, 0) @[dut.scala 53:50]
      node _finalResult_T_2 = cat(_finalResult_T, _finalResult_T_1) @[Cat.scala 33:92]
      finalResult <= _finalResult_T_2 @[dut.scala 53:17]
    io.result <= finalResult @[dut.scala 57:13]
    io.o_en <= finalEn @[dut.scala 58:11]

