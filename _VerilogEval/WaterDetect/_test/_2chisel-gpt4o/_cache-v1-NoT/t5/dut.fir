circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:22]
    reg fr3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:20]
    reg fr2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:20]
    reg fr1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:20]
    reg dfr : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:20]
    io.fr3 <= fr3 @[dut.scala 23:10]
    io.fr2 <= fr2 @[dut.scala 24:10]
    io.fr1 <= fr1 @[dut.scala 25:10]
    io.dfr <= dfr @[dut.scala 26:10]
    node _T = bits(reset, 0, 0) @[dut.scala 29:21]
    when _T : @[dut.scala 29:25]
      fr3 <= UInt<1>("h1") @[dut.scala 31:9]
      fr2 <= UInt<1>("h1") @[dut.scala 32:9]
      fr1 <= UInt<1>("h1") @[dut.scala 33:9]
      dfr <= UInt<1>("h1") @[dut.scala 34:9]
      prevS <= UInt<1>("h0") @[dut.scala 35:11]
    else :
      node _T_1 = eq(UInt<3>("h7"), io.s) @[dut.scala 38:18]
      when _T_1 : @[dut.scala 38:18]
        fr3 <= UInt<1>("h0") @[dut.scala 40:13]
        fr2 <= UInt<1>("h0") @[dut.scala 41:13]
        fr1 <= UInt<1>("h0") @[dut.scala 42:13]
      else :
        node _T_2 = eq(UInt<2>("h3"), io.s) @[dut.scala 38:18]
        when _T_2 : @[dut.scala 38:18]
          fr3 <= UInt<1>("h0") @[dut.scala 45:13]
          fr2 <= UInt<1>("h0") @[dut.scala 46:13]
          fr1 <= UInt<1>("h1") @[dut.scala 47:13]
        else :
          node _T_3 = eq(UInt<1>("h1"), io.s) @[dut.scala 38:18]
          when _T_3 : @[dut.scala 38:18]
            fr3 <= UInt<1>("h0") @[dut.scala 50:13]
            fr2 <= UInt<1>("h1") @[dut.scala 51:13]
            fr1 <= UInt<1>("h1") @[dut.scala 52:13]
          else :
            node _T_4 = eq(UInt<1>("h0"), io.s) @[dut.scala 38:18]
            when _T_4 : @[dut.scala 38:18]
              fr3 <= UInt<1>("h1") @[dut.scala 55:13]
              fr2 <= UInt<1>("h1") @[dut.scala 56:13]
              fr1 <= UInt<1>("h1") @[dut.scala 57:13]
      node _T_5 = gt(io.s, prevS) @[dut.scala 62:15]
      when _T_5 : @[dut.scala 62:24]
        dfr <= UInt<1>("h1") @[dut.scala 63:11]
      else :
        dfr <= UInt<1>("h0") @[dut.scala 65:11]
      prevS <= io.s @[dut.scala 69:11]


