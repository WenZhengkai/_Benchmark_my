circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node _resetSync_T = bits(reset, 0, 0) @[dut.scala 14:37]
    wire resetSync : UInt<1> @[dut.scala 14:30]
    resetSync <= _resetSync_T @[dut.scala 14:30]
    reg prevState : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 17:26]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 21:23]
    io.fr3 <= fr3Reg @[dut.scala 24:10]
    io.fr2 <= fr2Reg @[dut.scala 25:10]
    io.fr1 <= fr1Reg @[dut.scala 26:10]
    io.dfr <= dfrReg @[dut.scala 27:10]
    when resetSync : @[dut.scala 30:19]
      prevState <= UInt<3>("h0") @[dut.scala 32:15]
      fr3Reg <= UInt<1>("h1") @[dut.scala 33:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 34:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 35:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 36:12]
    else :
      node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 39:15]
      when _T : @[dut.scala 39:29]
        fr3Reg <= UInt<1>("h0") @[dut.scala 40:14]
        fr2Reg <= UInt<1>("h0") @[dut.scala 41:14]
        fr1Reg <= UInt<1>("h0") @[dut.scala 42:14]
      else :
        node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 43:21]
        when _T_1 : @[dut.scala 43:35]
          fr3Reg <= UInt<1>("h0") @[dut.scala 44:14]
          fr2Reg <= UInt<1>("h0") @[dut.scala 45:14]
          fr1Reg <= UInt<1>("h1") @[dut.scala 46:14]
        else :
          node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 47:21]
          when _T_2 : @[dut.scala 47:35]
            fr3Reg <= UInt<1>("h0") @[dut.scala 48:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 49:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 50:14]
          else :
            fr3Reg <= UInt<1>("h1") @[dut.scala 52:14]
            fr2Reg <= UInt<1>("h1") @[dut.scala 53:14]
            fr1Reg <= UInt<1>("h1") @[dut.scala 54:14]
      node _dfrReg_T = gt(io.s, prevState) @[dut.scala 59:20]
      dfrReg <= _dfrReg_T @[dut.scala 59:12]
      prevState <= io.s @[dut.scala 62:15]


