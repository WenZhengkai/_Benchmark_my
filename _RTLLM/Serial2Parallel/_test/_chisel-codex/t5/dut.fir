circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 13:25]
    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 15:25]
    reg doutParallelReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 18:32]
    reg doutValidReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:32]
    doutValidReg <= UInt<1>("h0") @[dut.scala 22:16]
    when io.din_valid : @[dut.scala 24:22]
      node _nextShift_T = bits(shiftReg, 6, 0) @[dut.scala 25:33]
      node nextShift = cat(_nextShift_T, io.din_serial) @[Cat.scala 33:92]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 27:14]
      when _T : @[dut.scala 27:23]
        doutParallelReg <= nextShift @[dut.scala 29:23]
        doutValidReg <= UInt<1>("h1") @[dut.scala 30:20]
        cnt <= UInt<1>("h0") @[dut.scala 31:11]
      else :
        node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 33:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 33:18]
        cnt <= _cnt_T_1 @[dut.scala 33:11]
      shiftReg <= nextShift @[dut.scala 36:14]
    io.dout_parallel <= doutParallelReg @[dut.scala 39:20]
    io.dout_valid <= doutValidReg @[dut.scala 40:17]

