circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg enaReg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:24]
    reg enaReg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:24]
    reg enaReg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:24]
    reg enaReg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:24]
    reg addaReg1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addaReg1) @[dut.scala 19:21]
    reg addaReg2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addaReg2) @[dut.scala 20:21]
    reg addaReg3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addaReg3) @[dut.scala 21:21]
    reg addaReg4 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addaReg4) @[dut.scala 22:21]
    reg addbReg1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addbReg1) @[dut.scala 24:21]
    reg addbReg2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addbReg2) @[dut.scala 25:21]
    reg addbReg3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addbReg3) @[dut.scala 26:21]
    reg addbReg4 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), addbReg4) @[dut.scala 27:21]
    reg carryOut1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:26]
    reg carryOut2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:26]
    reg carryOut3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:26]
    reg sumReg1 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg1) @[dut.scala 33:20]
    reg sumReg2 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg2) @[dut.scala 34:20]
    reg sumReg3 : UInt<17>, clock with :
      reset => (UInt<1>("h0"), sumReg3) @[dut.scala 35:20]
    reg finalSum : UInt<65>, clock with :
      reset => (UInt<1>("h0"), finalSum) @[dut.scala 36:21]
    when io.i_en : @[dut.scala 39:17]
      node _lowerAdd_T = bits(io.adda, 15, 0) @[dut.scala 40:27]
      node _lowerAdd_T_1 = bits(io.addb, 15, 0) @[dut.scala 40:45]
      node lowerAdd = add(_lowerAdd_T, _lowerAdd_T_1) @[dut.scala 40:35]
      sumReg1 <= lowerAdd @[dut.scala 41:13]
      node _carryOut1_T = bits(lowerAdd, 16, 16) @[dut.scala 42:26]
      carryOut1 <= _carryOut1_T @[dut.scala 42:15]
      enaReg1 <= io.i_en @[dut.scala 43:13]
      addaReg1 <= io.adda @[dut.scala 44:14]
      addbReg1 <= io.addb @[dut.scala 45:14]
    when enaReg1 : @[dut.scala 49:17]
      node _middleAdd_T = bits(addaReg1, 31, 16) @[dut.scala 50:29]
      node _middleAdd_T_1 = bits(addbReg1, 31, 16) @[dut.scala 50:49]
      node _middleAdd_T_2 = add(_middleAdd_T, _middleAdd_T_1) @[dut.scala 50:38]
      node _middleAdd_T_3 = add(_middleAdd_T_2, carryOut1) @[dut.scala 50:58]
      node middleAdd = tail(_middleAdd_T_3, 1) @[dut.scala 50:58]
      sumReg2 <= middleAdd @[dut.scala 51:13]
      node _carryOut2_T = bits(middleAdd, 16, 16) @[dut.scala 52:27]
      carryOut2 <= _carryOut2_T @[dut.scala 52:15]
      enaReg2 <= enaReg1 @[dut.scala 53:13]
      addaReg2 <= addaReg1 @[dut.scala 54:14]
      addbReg2 <= addbReg1 @[dut.scala 55:14]
    when enaReg2 : @[dut.scala 59:17]
      node _upperAdd_T = bits(addaReg2, 47, 32) @[dut.scala 60:28]
      node _upperAdd_T_1 = bits(addbReg2, 47, 32) @[dut.scala 60:48]
      node _upperAdd_T_2 = add(_upperAdd_T, _upperAdd_T_1) @[dut.scala 60:37]
      node _upperAdd_T_3 = add(_upperAdd_T_2, carryOut2) @[dut.scala 60:57]
      node upperAdd = tail(_upperAdd_T_3, 1) @[dut.scala 60:57]
      sumReg3 <= upperAdd @[dut.scala 61:13]
      node _carryOut3_T = bits(upperAdd, 16, 16) @[dut.scala 62:26]
      carryOut3 <= _carryOut3_T @[dut.scala 62:15]
      enaReg3 <= enaReg2 @[dut.scala 63:13]
      addaReg3 <= addaReg2 @[dut.scala 64:14]
      addbReg3 <= addbReg2 @[dut.scala 65:14]
    when enaReg3 : @[dut.scala 69:17]
      node _topAdd_T = bits(addaReg3, 63, 48) @[dut.scala 70:26]
      node _topAdd_T_1 = bits(addbReg3, 63, 48) @[dut.scala 70:46]
      node _topAdd_T_2 = add(_topAdd_T, _topAdd_T_1) @[dut.scala 70:35]
      node _topAdd_T_3 = add(_topAdd_T_2, carryOut3) @[dut.scala 70:55]
      node topAdd = tail(_topAdd_T_3, 1) @[dut.scala 70:55]
      node _finalSum_T = bits(sumReg3, 15, 0) @[dut.scala 71:36]
      node _finalSum_T_1 = bits(sumReg2, 15, 0) @[dut.scala 71:52]
      node _finalSum_T_2 = bits(sumReg1, 15, 0) @[dut.scala 71:68]
      node finalSum_lo = cat(_finalSum_T_1, _finalSum_T_2) @[Cat.scala 33:92]
      node finalSum_hi = cat(topAdd, _finalSum_T) @[Cat.scala 33:92]
      node _finalSum_T_3 = cat(finalSum_hi, finalSum_lo) @[Cat.scala 33:92]
      finalSum <= _finalSum_T_3 @[dut.scala 71:14]
      enaReg4 <= enaReg3 @[dut.scala 72:13]
    io.result <= finalSum @[dut.scala 76:13]
    io.o_en <= enaReg4 @[dut.scala 77:11]

