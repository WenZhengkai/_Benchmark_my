circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 12:25]
    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 13:25]
    reg outReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 14:25]
    reg outValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:25]
    outValid <= UInt<1>("h0") @[dut.scala 18:12]
    when io.din_valid : @[dut.scala 20:22]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 21:14]
      when _T : @[dut.scala 21:23]
        node _outReg_T = bits(shiftReg, 6, 0) @[dut.scala 23:31]
        node _outReg_T_1 = cat(_outReg_T, io.din_serial) @[Cat.scala 33:92]
        outReg <= _outReg_T_1 @[dut.scala 23:16]
        outValid <= UInt<1>("h1") @[dut.scala 24:16]
        cnt <= UInt<1>("h0") @[dut.scala 25:16]
        shiftReg <= UInt<1>("h0") @[dut.scala 26:16]
      else :
        node _shiftReg_T = bits(shiftReg, 6, 0) @[dut.scala 28:31]
        node _shiftReg_T_1 = cat(_shiftReg_T, io.din_serial) @[Cat.scala 33:92]
        shiftReg <= _shiftReg_T_1 @[dut.scala 28:16]
        node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 29:23]
        node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 29:23]
        cnt <= _cnt_T_1 @[dut.scala 29:16]
    io.dout_parallel <= outReg @[dut.scala 33:20]
    io.dout_valid <= outValid @[dut.scala 34:20]

