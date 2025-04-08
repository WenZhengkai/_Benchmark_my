circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg stage1SumReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 14:29]
    reg stage2SumReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 15:29]
    reg stage3SumReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 16:29]
    reg stage4SumReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 17:29]
    reg stage1CarryReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:31]
    reg stage2CarryReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:31]
    reg stage3CarryReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:31]
    reg stage1EnReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:28]
    reg stage2EnReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:28]
    reg stage3EnReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:28]
    reg stage4EnReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:28]
    node _stage1Sum_T = bits(io.adda, 15, 0) @[dut.scala 29:26]
    node _stage1Sum_T_1 = bits(io.addb, 15, 0) @[dut.scala 29:44]
    node stage1Sum = add(_stage1Sum_T, _stage1Sum_T_1) @[dut.scala 29:34]
    stage1SumReg <= stage1Sum @[dut.scala 30:16]
    node _stage1CarryReg_T = bits(stage1Sum, 16, 16) @[dut.scala 31:30]
    stage1CarryReg <= _stage1CarryReg_T @[dut.scala 31:18]
    stage1EnReg <= io.i_en @[dut.scala 32:15]
    node _stage2Sum_T = bits(io.adda, 31, 16) @[dut.scala 35:26]
    node _stage2Sum_T_1 = bits(io.addb, 31, 16) @[dut.scala 35:45]
    node _stage2Sum_T_2 = add(_stage2Sum_T, _stage2Sum_T_1) @[dut.scala 35:35]
    node _stage2Sum_T_3 = add(_stage2Sum_T_2, stage1CarryReg) @[dut.scala 35:54]
    node stage2Sum = tail(_stage2Sum_T_3, 1) @[dut.scala 35:54]
    stage2SumReg <= stage2Sum @[dut.scala 36:16]
    node _stage2CarryReg_T = bits(stage2Sum, 16, 16) @[dut.scala 37:30]
    stage2CarryReg <= _stage2CarryReg_T @[dut.scala 37:18]
    stage2EnReg <= stage1EnReg @[dut.scala 38:15]
    node _stage3Sum_T = bits(io.adda, 47, 32) @[dut.scala 41:26]
    node _stage3Sum_T_1 = bits(io.addb, 47, 32) @[dut.scala 41:45]
    node _stage3Sum_T_2 = add(_stage3Sum_T, _stage3Sum_T_1) @[dut.scala 41:35]
    node _stage3Sum_T_3 = add(_stage3Sum_T_2, stage2CarryReg) @[dut.scala 41:54]
    node stage3Sum = tail(_stage3Sum_T_3, 1) @[dut.scala 41:54]
    stage3SumReg <= stage3Sum @[dut.scala 42:16]
    node _stage3CarryReg_T = bits(stage3Sum, 16, 16) @[dut.scala 43:30]
    stage3CarryReg <= _stage3CarryReg_T @[dut.scala 43:18]
    stage3EnReg <= stage2EnReg @[dut.scala 44:15]
    node _stage4Sum_T = bits(io.adda, 63, 48) @[dut.scala 47:26]
    node _stage4Sum_T_1 = bits(io.addb, 63, 48) @[dut.scala 47:45]
    node _stage4Sum_T_2 = add(_stage4Sum_T, _stage4Sum_T_1) @[dut.scala 47:35]
    node _stage4Sum_T_3 = add(_stage4Sum_T_2, stage3CarryReg) @[dut.scala 47:54]
    node stage4Sum = tail(_stage4Sum_T_3, 1) @[dut.scala 47:54]
    node _stage4SumReg_T = cat(stage3CarryReg, stage4Sum) @[Cat.scala 33:92]
    stage4SumReg <= _stage4SumReg_T @[dut.scala 48:16]
    stage4EnReg <= stage3EnReg @[dut.scala 49:15]
    node _io_result_T = bits(stage1SumReg, 15, 0) @[dut.scala 52:46]
    node _io_result_T_1 = bits(stage2SumReg, 15, 0) @[dut.scala 52:67]
    node _io_result_T_2 = bits(stage3SumReg, 15, 0) @[dut.scala 52:88]
    node io_result_lo = cat(_io_result_T_1, _io_result_T_2) @[Cat.scala 33:92]
    node io_result_hi = cat(stage4SumReg, _io_result_T) @[Cat.scala 33:92]
    node _io_result_T_3 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_3 @[dut.scala 52:13]
    io.o_en <= stage4EnReg @[dut.scala 53:11]

