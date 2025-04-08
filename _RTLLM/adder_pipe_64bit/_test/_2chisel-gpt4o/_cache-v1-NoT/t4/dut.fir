circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg enReg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:23]
    reg enReg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:23]
    reg enReg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:23]
    reg enReg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:23]
    reg sumReg1 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg1) @[dut.scala 19:20]
    reg sumReg2 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg2) @[dut.scala 20:20]
    reg sumReg3 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg3) @[dut.scala 21:20]
    reg sumReg4 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg4) @[dut.scala 22:20]
    when io.i_en : @[dut.scala 25:17]
      node _addResStage1_T = bits(io.adda, 15, 0) @[dut.scala 26:31]
      node _addResStage1_T_1 = bits(io.addb, 15, 0) @[dut.scala 26:49]
      node addResStage1 = add(_addResStage1_T, _addResStage1_T_1) @[dut.scala 26:39]
      sumReg1 <= addResStage1 @[dut.scala 27:13]
    enReg1 <= io.i_en @[dut.scala 29:10]
    when enReg1 : @[dut.scala 32:16]
      node _addResStage2_T = bits(io.adda, 31, 16) @[dut.scala 33:31]
      node _addResStage2_T_1 = bits(io.addb, 31, 16) @[dut.scala 33:50]
      node _addResStage2_T_2 = add(_addResStage2_T, _addResStage2_T_1) @[dut.scala 33:40]
      node _addResStage2_T_3 = bits(sumReg1, 16, 16) @[dut.scala 33:69]
      node addResStage2 = add(_addResStage2_T_2, _addResStage2_T_3) @[dut.scala 33:59]
      sumReg2 <= addResStage2 @[dut.scala 34:13]
    enReg2 <= enReg1 @[dut.scala 36:10]
    when enReg2 : @[dut.scala 39:16]
      node _addResStage3_T = bits(io.adda, 47, 32) @[dut.scala 40:31]
      node _addResStage3_T_1 = bits(io.addb, 47, 32) @[dut.scala 40:50]
      node _addResStage3_T_2 = add(_addResStage3_T, _addResStage3_T_1) @[dut.scala 40:40]
      node _addResStage3_T_3 = bits(sumReg2, 16, 16) @[dut.scala 40:69]
      node addResStage3 = add(_addResStage3_T_2, _addResStage3_T_3) @[dut.scala 40:59]
      sumReg3 <= addResStage3 @[dut.scala 41:13]
    enReg3 <= enReg2 @[dut.scala 43:10]
    when enReg3 : @[dut.scala 46:16]
      node _addResStage4_T = bits(io.adda, 63, 48) @[dut.scala 47:31]
      node _addResStage4_T_1 = bits(io.addb, 63, 48) @[dut.scala 47:50]
      node _addResStage4_T_2 = add(_addResStage4_T, _addResStage4_T_1) @[dut.scala 47:40]
      node _addResStage4_T_3 = bits(sumReg3, 16, 16) @[dut.scala 47:69]
      node addResStage4 = add(_addResStage4_T_2, _addResStage4_T_3) @[dut.scala 47:59]
      sumReg4 <= addResStage4 @[dut.scala 48:13]
    enReg4 <= enReg3 @[dut.scala 50:10]
    io.o_en <= enReg4 @[dut.scala 53:11]
    node _io_result_T = bits(sumReg4, 16, 16) @[dut.scala 56:27]
    node _io_result_T_1 = bits(sumReg4, 15, 0) @[dut.scala 56:40]
    node _io_result_T_2 = bits(sumReg3, 15, 0) @[dut.scala 56:56]
    node _io_result_T_3 = bits(sumReg2, 15, 0) @[dut.scala 56:72]
    node _io_result_T_4 = bits(sumReg1, 15, 0) @[dut.scala 56:88]
    node io_result_lo = cat(_io_result_T_3, _io_result_T_4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, _io_result_T_2) @[Cat.scala 33:92]
    node _io_result_T_5 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_5 @[dut.scala 56:13]

