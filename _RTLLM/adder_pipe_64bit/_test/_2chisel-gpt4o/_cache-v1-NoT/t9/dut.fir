circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg sumStage1 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 14:26]
    reg sumStage2 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 15:26]
    reg sumStage3 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 16:26]
    reg sumStage4 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 17:26]
    reg enStage1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:25]
    reg enStage2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:25]
    reg enStage3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:25]
    reg enStage4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    when io.i_en : @[dut.scala 26:17]
      node _add16_0_T = bits(io.adda, 15, 0) @[dut.scala 27:26]
      node _add16_0_T_1 = bits(io.addb, 15, 0) @[dut.scala 27:44]
      node add16_0 = add(_add16_0_T, _add16_0_T_1) @[dut.scala 27:34]
      sumStage1 <= add16_0 @[dut.scala 28:15]
      enStage1 <= io.i_en @[dut.scala 29:14]
    when enStage1 : @[dut.scala 33:18]
      node _add16_1_T = bits(io.adda, 31, 16) @[dut.scala 34:26]
      node _add16_1_T_1 = bits(io.addb, 31, 16) @[dut.scala 34:45]
      node _add16_1_T_2 = add(_add16_1_T, _add16_1_T_1) @[dut.scala 34:35]
      node _add16_1_T_3 = bits(sumStage1, 16, 16) @[dut.scala 34:65]
      node _add16_1_T_4 = add(_add16_1_T_2, _add16_1_T_3) @[dut.scala 34:54]
      node add16_1 = tail(_add16_1_T_4, 1) @[dut.scala 34:54]
      sumStage2 <= add16_1 @[dut.scala 35:15]
      enStage2 <= enStage1 @[dut.scala 36:14]
    when enStage2 : @[dut.scala 40:18]
      node _add16_2_T = bits(io.adda, 47, 32) @[dut.scala 41:26]
      node _add16_2_T_1 = bits(io.addb, 47, 32) @[dut.scala 41:45]
      node _add16_2_T_2 = add(_add16_2_T, _add16_2_T_1) @[dut.scala 41:35]
      node _add16_2_T_3 = bits(sumStage2, 16, 16) @[dut.scala 41:65]
      node _add16_2_T_4 = add(_add16_2_T_2, _add16_2_T_3) @[dut.scala 41:54]
      node add16_2 = tail(_add16_2_T_4, 1) @[dut.scala 41:54]
      sumStage3 <= add16_2 @[dut.scala 42:15]
      enStage3 <= enStage2 @[dut.scala 43:14]
    when enStage3 : @[dut.scala 47:18]
      node _add16_3_T = bits(io.adda, 63, 48) @[dut.scala 48:26]
      node _add16_3_T_1 = bits(io.addb, 63, 48) @[dut.scala 48:45]
      node _add16_3_T_2 = add(_add16_3_T, _add16_3_T_1) @[dut.scala 48:35]
      node _add16_3_T_3 = bits(sumStage3, 16, 16) @[dut.scala 48:65]
      node _add16_3_T_4 = add(_add16_3_T_2, _add16_3_T_3) @[dut.scala 48:54]
      node add16_3 = tail(_add16_3_T_4, 1) @[dut.scala 48:54]
      sumStage4 <= add16_3 @[dut.scala 49:15]
      enStage4 <= enStage3 @[dut.scala 50:14]
    io.o_en <= enStage4 @[dut.scala 54:11]
    node _io_result_T = bits(sumStage4, 16, 16) @[dut.scala 57:29]
    node _io_result_T_1 = bits(sumStage4, 15, 0) @[dut.scala 57:44]
    node _io_result_T_2 = bits(sumStage3, 15, 0) @[dut.scala 57:62]
    node _io_result_T_3 = bits(sumStage2, 15, 0) @[dut.scala 57:80]
    node _io_result_T_4 = bits(sumStage1, 15, 0) @[dut.scala 57:98]
    node io_result_lo = cat(_io_result_T_3, _io_result_T_4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, _io_result_T_2) @[Cat.scala 33:92]
    node _io_result_T_5 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_5 @[dut.scala 57:13]

