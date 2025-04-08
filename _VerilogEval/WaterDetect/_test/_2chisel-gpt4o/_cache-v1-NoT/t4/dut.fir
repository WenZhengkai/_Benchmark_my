circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prev_s : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 16:23]
    reg fr3_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:24]
    reg fr2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:24]
    reg fr1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 19:24]
    reg dfr_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 20:24]
    io.fr3 <= fr3_reg @[dut.scala 23:10]
    io.fr2 <= fr2_reg @[dut.scala 24:10]
    io.fr1 <= fr1_reg @[dut.scala 25:10]
    io.dfr <= dfr_reg @[dut.scala 26:10]
    when io.reset : @[dut.scala 29:18]
      fr3_reg <= UInt<1>("h1") @[dut.scala 31:13]
      fr2_reg <= UInt<1>("h1") @[dut.scala 32:13]
      fr1_reg <= UInt<1>("h1") @[dut.scala 33:13]
      dfr_reg <= UInt<1>("h1") @[dut.scala 34:13]
      prev_s <= UInt<3>("h0") @[dut.scala 35:12]
    else :
      node _T = bits(io.s, 2, 2) @[dut.scala 38:14]
      when _T : @[dut.scala 38:19]
        fr3_reg <= UInt<1>("h0") @[dut.scala 40:15]
        fr2_reg <= UInt<1>("h0") @[dut.scala 41:15]
        fr1_reg <= UInt<1>("h0") @[dut.scala 42:15]
      else :
        node _T_1 = bits(io.s, 1, 1) @[dut.scala 43:21]
        when _T_1 : @[dut.scala 43:26]
          fr3_reg <= UInt<1>("h0") @[dut.scala 45:15]
          fr2_reg <= UInt<1>("h0") @[dut.scala 46:15]
          fr1_reg <= UInt<1>("h1") @[dut.scala 47:15]
        else :
          node _T_2 = bits(io.s, 0, 0) @[dut.scala 48:21]
          when _T_2 : @[dut.scala 48:26]
            fr3_reg <= UInt<1>("h0") @[dut.scala 50:15]
            fr2_reg <= UInt<1>("h1") @[dut.scala 51:15]
            fr1_reg <= UInt<1>("h1") @[dut.scala 52:15]
          else :
            fr3_reg <= UInt<1>("h1") @[dut.scala 55:15]
            fr2_reg <= UInt<1>("h1") @[dut.scala 56:15]
            fr1_reg <= UInt<1>("h1") @[dut.scala 57:15]
      node _T_3 = gt(io.s, prev_s) @[dut.scala 61:15]
      when _T_3 : @[dut.scala 61:25]
        dfr_reg <= UInt<1>("h1") @[dut.scala 63:15]
      else :
        dfr_reg <= UInt<1>("h0") @[dut.scala 66:15]
      prev_s <= io.s @[dut.scala 70:12]


