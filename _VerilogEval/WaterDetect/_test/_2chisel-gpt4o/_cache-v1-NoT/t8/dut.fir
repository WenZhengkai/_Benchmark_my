circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:22]
    reg fr3_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 15:24]
    reg fr2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 16:24]
    reg fr1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:24]
    reg dfr_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:24]
    io.fr3 <= fr3_reg @[dut.scala 21:10]
    io.fr2 <= fr2_reg @[dut.scala 22:10]
    io.fr1 <= fr1_reg @[dut.scala 23:10]
    io.dfr <= dfr_reg @[dut.scala 24:10]
    node _T = bits(reset, 0, 0) @[dut.scala 27:21]
    when _T : @[dut.scala 27:25]
      fr3_reg <= UInt<1>("h1") @[dut.scala 29:13]
      fr2_reg <= UInt<1>("h1") @[dut.scala 30:13]
      fr1_reg <= UInt<1>("h1") @[dut.scala 31:13]
      dfr_reg <= UInt<1>("h1") @[dut.scala 32:13]
      prevS <= UInt<1>("h0") @[dut.scala 33:11]
    else :
      node _T_1 = bits(io.s, 2, 2) @[dut.scala 36:15]
      when _T_1 : @[dut.scala 36:20]
        fr3_reg <= UInt<1>("h0") @[dut.scala 37:15]
        fr2_reg <= UInt<1>("h0") @[dut.scala 38:15]
        fr1_reg <= UInt<1>("h0") @[dut.scala 39:15]
      else :
        node _T_2 = bits(io.s, 1, 1) @[dut.scala 40:22]
        when _T_2 : @[dut.scala 40:27]
          fr3_reg <= UInt<1>("h0") @[dut.scala 41:15]
          fr2_reg <= UInt<1>("h0") @[dut.scala 42:15]
          fr1_reg <= UInt<1>("h1") @[dut.scala 43:15]
        else :
          node _T_3 = bits(io.s, 0, 0) @[dut.scala 44:22]
          when _T_3 : @[dut.scala 44:27]
            fr3_reg <= UInt<1>("h0") @[dut.scala 45:15]
            fr2_reg <= UInt<1>("h1") @[dut.scala 46:15]
            fr1_reg <= UInt<1>("h1") @[dut.scala 47:15]
          else :
            fr3_reg <= UInt<1>("h1") @[dut.scala 49:15]
            fr2_reg <= UInt<1>("h1") @[dut.scala 50:15]
            fr1_reg <= UInt<1>("h1") @[dut.scala 51:15]
      node _T_4 = gt(io.s, prevS) @[dut.scala 55:16]
      when _T_4 : @[dut.scala 55:25]
        dfr_reg <= UInt<1>("h1") @[dut.scala 56:15]
      else :
        dfr_reg <= UInt<1>("h0") @[dut.scala 58:15]
      prevS <= io.s @[dut.scala 62:11]


