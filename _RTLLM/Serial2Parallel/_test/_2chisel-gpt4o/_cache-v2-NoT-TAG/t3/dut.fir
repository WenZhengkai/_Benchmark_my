circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cntReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:23]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 14:25]
    reg doutParallelReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 15:32]
    reg doutValidReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:29]
    when io.din_valid : @[dut.scala 19:22]
      node _cntReg_T = add(cntReg, UInt<1>("h1")) @[dut.scala 20:22]
      node _cntReg_T_1 = tail(_cntReg_T, 1) @[dut.scala 20:22]
      cntReg <= _cntReg_T_1 @[dut.scala 20:12]
      node _T = eq(cntReg, UInt<4>("h8")) @[dut.scala 21:17]
      when _T : @[dut.scala 21:26]
        cntReg <= UInt<1>("h0") @[dut.scala 22:14]
    when io.din_valid : @[dut.scala 27:22]
      node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 28:29]
      node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 28:14]
    node _T_1 = eq(cntReg, UInt<4>("h8")) @[dut.scala 32:31]
    node _T_2 = and(io.din_valid, _T_1) @[dut.scala 32:21]
    when _T_2 : @[dut.scala 32:40]
      doutParallelReg <= shiftReg @[dut.scala 33:21]
    node _doutValidReg_T = eq(cntReg, UInt<4>("h8")) @[dut.scala 37:42]
    node _doutValidReg_T_1 = and(io.din_valid, _doutValidReg_T) @[dut.scala 37:32]
    doutValidReg <= _doutValidReg_T_1 @[dut.scala 37:16]
    io.dout_parallel <= doutParallelReg @[dut.scala 40:20]
    io.dout_valid <= doutValidReg @[dut.scala 41:17]

