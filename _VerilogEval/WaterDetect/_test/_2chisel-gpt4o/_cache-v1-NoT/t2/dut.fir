circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:22]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 15:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 16:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:23]
    io.fr3 <= fr3Reg @[dut.scala 21:10]
    io.fr2 <= fr2Reg @[dut.scala 22:10]
    io.fr1 <= fr1Reg @[dut.scala 23:10]
    io.dfr <= dfrReg @[dut.scala 24:10]
    node _T = bits(reset, 0, 0) @[dut.scala 27:20]
    when _T : @[dut.scala 27:24]
      fr3Reg <= UInt<1>("h1") @[dut.scala 29:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 30:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 31:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 32:12]
      prevS <= UInt<1>("h0") @[dut.scala 33:11]
    else :
      node _T_1 = eq(UInt<3>("h7"), io.s) @[dut.scala 36:18]
      when _T_1 : @[dut.scala 36:18]
        fr3Reg <= UInt<1>("h0") @[dut.scala 38:16]
        fr2Reg <= UInt<1>("h0") @[dut.scala 39:16]
        fr1Reg <= UInt<1>("h0") @[dut.scala 40:16]
      else :
        node _T_2 = eq(UInt<3>("h6"), io.s) @[dut.scala 36:18]
        when _T_2 : @[dut.scala 36:18]
          fr3Reg <= UInt<1>("h0") @[dut.scala 43:16]
          fr2Reg <= UInt<1>("h0") @[dut.scala 44:16]
          fr1Reg <= UInt<1>("h1") @[dut.scala 45:16]
        else :
          node _T_3 = eq(UInt<3>("h4"), io.s) @[dut.scala 36:18]
          when _T_3 : @[dut.scala 36:18]
            fr3Reg <= UInt<1>("h0") @[dut.scala 48:16]
            fr2Reg <= UInt<1>("h1") @[dut.scala 49:16]
            fr1Reg <= UInt<1>("h1") @[dut.scala 50:16]
          else :
            node _T_4 = eq(UInt<1>("h0"), io.s) @[dut.scala 36:18]
            when _T_4 : @[dut.scala 36:18]
              fr3Reg <= UInt<1>("h1") @[dut.scala 53:16]
              fr2Reg <= UInt<1>("h1") @[dut.scala 54:16]
              fr1Reg <= UInt<1>("h1") @[dut.scala 55:16]
      node _T_5 = gt(io.s, prevS) @[dut.scala 60:15]
      when _T_5 : @[dut.scala 60:24]
        dfrReg <= UInt<1>("h1") @[dut.scala 61:14]
      else :
        dfrReg <= UInt<1>("h0") @[dut.scala 63:14]
      prevS <= io.s @[dut.scala 67:11]


