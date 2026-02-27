circuit dut :
  module SerialToParallel :
    input clock : Clock
    input reset : Reset
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    reg cnt : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 15:20]
    reg shiftReg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 17:25]
    reg outValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:25]
    io.dout_parallel <= shiftReg @[dut.scala 22:20]
    io.dout_valid <= outValid @[dut.scala 23:17]
    when io.din_valid : @[dut.scala 25:22]
      node _shiftReg_T = bits(shiftReg, 7, 1) @[dut.scala 27:44]
      node _shiftReg_T_1 = cat(io.din_serial, _shiftReg_T) @[Cat.scala 33:92]
      shiftReg <= _shiftReg_T_1 @[dut.scala 27:14]
      node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 30:16]
      node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 30:16]
      cnt <= _cnt_T_1 @[dut.scala 30:9]
      node _T = eq(cnt, UInt<3>("h7")) @[dut.scala 33:14]
      when _T : @[dut.scala 33:23]
        outValid <= UInt<1>("h1") @[dut.scala 34:16]
        cnt <= UInt<1>("h0") @[dut.scala 35:11]
      else :
        outValid <= UInt<1>("h0") @[dut.scala 37:16]
    else :
      outValid <= UInt<1>("h0") @[dut.scala 41:14]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip din_serial : UInt<1>, flip din_valid : UInt<1>, dout_parallel : UInt<8>, dout_valid : UInt<1>}

    inst converter of SerialToParallel @[dut.scala 54:25]
    converter.clock <= clock
    converter.reset <= reset
    converter.io.din_serial <= io.din_serial @[dut.scala 56:27]
    converter.io.din_valid <= io.din_valid @[dut.scala 57:26]
    io.dout_parallel <= converter.io.dout_parallel @[dut.scala 58:20]
    io.dout_valid <= converter.io.dout_valid @[dut.scala 59:17]

