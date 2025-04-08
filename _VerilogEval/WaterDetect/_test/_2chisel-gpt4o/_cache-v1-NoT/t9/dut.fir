circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:22]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:23]
    io.fr3 <= fr3Reg @[dut.scala 23:10]
    io.fr2 <= fr2Reg @[dut.scala 24:10]
    io.fr1 <= fr1Reg @[dut.scala 25:10]
    io.dfr <= dfrReg @[dut.scala 26:10]
    node _T = bits(reset, 0, 0) @[dut.scala 29:20]
    when _T : @[dut.scala 29:24]
      fr3Reg <= UInt<1>("h1") @[dut.scala 31:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 32:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 33:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 34:12]
      prevS <= UInt<1>("h0") @[dut.scala 35:11]
    else :
      node _T_1 = bits(io.s, 2, 2) @[dut.scala 38:14]
      when _T_1 : @[dut.scala 38:19]
        fr3Reg <= UInt<1>("h0") @[dut.scala 39:14]
        fr2Reg <= UInt<1>("h0") @[dut.scala 40:14]
        fr1Reg <= UInt<1>("h0") @[dut.scala 41:14]
      else :
        node _T_2 = bits(io.s, 1, 1) @[dut.scala 42:20]
        when _T_2 : @[dut.scala 42:25]
          fr3Reg <= UInt<1>("h0") @[dut.scala 43:14]
          fr2Reg <= UInt<1>("h0") @[dut.scala 44:14]
          fr1Reg <= UInt<1>("h1") @[dut.scala 45:14]
        else :
          node _T_3 = bits(io.s, 0, 0) @[dut.scala 46:20]
          when _T_3 : @[dut.scala 46:25]
            fr3Reg <= UInt<1>("h0") @[dut.scala 47:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 48:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 49:14]
          else :
            fr3Reg <= UInt<1>("h1") @[dut.scala 51:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 52:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 53:14]
      node _T_4 = gt(io.s, prevS) @[dut.scala 57:15]
      when _T_4 : @[dut.scala 57:24]
        dfrReg <= UInt<1>("h1") @[dut.scala 58:14]
      else :
        dfrReg <= UInt<1>("h0") @[dut.scala 60:14]
      prevS <= io.s @[dut.scala 64:11]


