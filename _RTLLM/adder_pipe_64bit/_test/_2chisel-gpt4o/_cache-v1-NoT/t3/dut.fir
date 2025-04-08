circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg enReg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:23]
    reg enReg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:23]
    reg enReg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:23]
    reg enReg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:23]
    reg sumStage1 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 21:26]
    reg sumStage2 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 22:26]
    reg sumStage3 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 23:26]
    reg sumStage4 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 24:26]
    when io.i_en : @[dut.scala 27:18]
      node _addLsb_T = bits(io.adda, 15, 0) @[dut.scala 28:25]
      node _addLsb_T_1 = bits(io.addb, 15, 0) @[dut.scala 28:43]
      node addLsb = add(_addLsb_T, _addLsb_T_1) @[dut.scala 28:33]
      sumStage1 <= addLsb @[dut.scala 29:15]
      enReg1 <= io.i_en @[dut.scala 30:12]
    else :
      enReg1 <= UInt<1>("h0") @[dut.scala 32:12]
    when enReg1 : @[dut.scala 36:17]
      node _addNext_T = bits(io.adda, 31, 16) @[dut.scala 37:26]
      node _addNext_T_1 = bits(io.addb, 31, 16) @[dut.scala 37:45]
      node _addNext_T_2 = add(_addNext_T, _addNext_T_1) @[dut.scala 37:35]
      node _addNext_T_3 = bits(sumStage1, 16, 16) @[dut.scala 37:65]
      node _addNext_T_4 = add(_addNext_T_2, _addNext_T_3) @[dut.scala 37:54]
      node addNext = tail(_addNext_T_4, 1) @[dut.scala 37:54]
      sumStage2 <= addNext @[dut.scala 38:15]
      enReg2 <= enReg1 @[dut.scala 39:12]
    else :
      enReg2 <= UInt<1>("h0") @[dut.scala 41:12]
    when enReg2 : @[dut.scala 45:17]
      node _addNext_T_5 = bits(io.adda, 47, 32) @[dut.scala 46:26]
      node _addNext_T_6 = bits(io.addb, 47, 32) @[dut.scala 46:45]
      node _addNext_T_7 = add(_addNext_T_5, _addNext_T_6) @[dut.scala 46:35]
      node _addNext_T_8 = bits(sumStage2, 16, 16) @[dut.scala 46:65]
      node _addNext_T_9 = add(_addNext_T_7, _addNext_T_8) @[dut.scala 46:54]
      node addNext_1 = tail(_addNext_T_9, 1) @[dut.scala 46:54]
      sumStage3 <= addNext_1 @[dut.scala 47:15]
      enReg3 <= enReg2 @[dut.scala 48:12]
    else :
      enReg3 <= UInt<1>("h0") @[dut.scala 50:12]
    when enReg3 : @[dut.scala 54:17]
      node _addMsb_T = bits(io.adda, 63, 48) @[dut.scala 55:25]
      node _addMsb_T_1 = bits(io.addb, 63, 48) @[dut.scala 55:44]
      node _addMsb_T_2 = add(_addMsb_T, _addMsb_T_1) @[dut.scala 55:34]
      node _addMsb_T_3 = bits(sumStage3, 16, 16) @[dut.scala 55:64]
      node _addMsb_T_4 = add(_addMsb_T_2, _addMsb_T_3) @[dut.scala 55:53]
      node addMsb = tail(_addMsb_T_4, 1) @[dut.scala 55:53]
      sumStage4 <= addMsb @[dut.scala 56:15]
      enReg4 <= enReg3 @[dut.scala 57:12]
    else :
      enReg4 <= UInt<1>("h0") @[dut.scala 59:12]
    node _io_result_T = bits(sumStage4, 16, 16) @[dut.scala 63:29]
    node _io_result_T_1 = bits(sumStage4, 15, 0) @[dut.scala 63:44]
    node _io_result_T_2 = bits(sumStage3, 15, 0) @[dut.scala 63:62]
    node _io_result_T_3 = bits(sumStage2, 15, 0) @[dut.scala 63:80]
    node _io_result_T_4 = bits(sumStage1, 15, 0) @[dut.scala 63:98]
    node io_result_lo = cat(_io_result_T_3, _io_result_T_4) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(_io_result_T, _io_result_T_1) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, _io_result_T_2) @[Cat.scala 33:92]
    node _io_result_T_5 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_5 @[dut.scala 63:13]
    io.o_en <= enReg4 @[dut.scala 64:11]

