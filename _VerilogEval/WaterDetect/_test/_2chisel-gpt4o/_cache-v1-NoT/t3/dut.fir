circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _resetReg_T = bits(reset, 0, 0) @[dut.scala 14:42]
    wire resetReg : UInt<1> @[dut.scala 14:29]
    resetReg <= _resetReg_T @[dut.scala 14:29]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:23]
    reg prevState : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 23:26]
    when resetReg : @[dut.scala 26:18]
      fr3Reg <= UInt<1>("h1") @[dut.scala 28:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 29:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 30:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 31:12]
      prevState <= UInt<1>("h0") @[dut.scala 32:15]
    else :
      node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 35:15]
      when _T : @[dut.scala 35:29]
        fr3Reg <= UInt<1>("h0") @[dut.scala 36:14]
        fr2Reg <= UInt<1>("h0") @[dut.scala 37:14]
        fr1Reg <= UInt<1>("h0") @[dut.scala 38:14]
      else :
        node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 39:21]
        when _T_1 : @[dut.scala 39:35]
          fr3Reg <= UInt<1>("h0") @[dut.scala 40:14]
          fr2Reg <= UInt<1>("h0") @[dut.scala 41:14]
          fr1Reg <= UInt<1>("h1") @[dut.scala 42:14]
        else :
          node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 43:21]
          when _T_2 : @[dut.scala 43:35]
            fr3Reg <= UInt<1>("h0") @[dut.scala 44:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 45:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 46:14]
          else :
            fr3Reg <= UInt<1>("h1") @[dut.scala 48:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 49:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 50:14]
      node _T_3 = gt(io.s, prevState) @[dut.scala 54:15]
      when _T_3 : @[dut.scala 54:28]
        dfrReg <= UInt<1>("h1") @[dut.scala 56:14]
      else :
        dfrReg <= UInt<1>("h0") @[dut.scala 59:14]
      prevState <= io.s @[dut.scala 63:15]
    io.fr3 <= fr3Reg @[dut.scala 67:10]
    io.fr2 <= fr2Reg @[dut.scala 68:10]
    io.fr1 <= fr1Reg @[dut.scala 69:10]
    io.dfr <= dfrReg @[dut.scala 70:10]

