circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg fr3_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:24]
    reg fr2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:24]
    reg fr1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:24]
    reg dfr_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    reg prev_s : UInt, clock with :
      reset => (UInt<1>("h0"), prev_s) @[dut.scala 21:23]
    prev_s <= io.s @[dut.scala 21:23]
    io.fr3 <= UInt<1>("h0") @[dut.scala 24:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 25:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 26:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 27:10]
    when io.reset : @[dut.scala 30:18]
      fr3_reg <= UInt<1>("h1") @[dut.scala 31:13]
      fr2_reg <= UInt<1>("h1") @[dut.scala 32:13]
      fr1_reg <= UInt<1>("h1") @[dut.scala 33:13]
      dfr_reg <= UInt<1>("h1") @[dut.scala 34:13]
    else :
      node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 37:18]
      when _T : @[dut.scala 37:18]
        fr3_reg <= UInt<1>("h0") @[dut.scala 39:17]
        fr2_reg <= UInt<1>("h0") @[dut.scala 40:17]
        fr1_reg <= UInt<1>("h0") @[dut.scala 41:17]
        dfr_reg <= UInt<1>("h0") @[dut.scala 42:17]
      else :
        node _T_1 = eq(UInt<2>("h3"), io.s) @[dut.scala 37:18]
        when _T_1 : @[dut.scala 37:18]
          fr3_reg <= UInt<1>("h0") @[dut.scala 45:17]
          fr2_reg <= UInt<1>("h0") @[dut.scala 46:17]
          fr1_reg <= UInt<1>("h1") @[dut.scala 47:17]
          node _dfr_reg_T = gt(io.s, prev_s) @[dut.scala 48:26]
          dfr_reg <= _dfr_reg_T @[dut.scala 48:17]
        else :
          node _T_2 = eq(UInt<1>("h1"), io.s) @[dut.scala 37:18]
          when _T_2 : @[dut.scala 37:18]
            fr3_reg <= UInt<1>("h0") @[dut.scala 51:17]
            fr2_reg <= UInt<1>("h1") @[dut.scala 52:17]
            fr1_reg <= UInt<1>("h1") @[dut.scala 53:17]
            node _dfr_reg_T_1 = gt(io.s, prev_s) @[dut.scala 54:26]
            dfr_reg <= _dfr_reg_T_1 @[dut.scala 54:17]
          else :
            node _T_3 = eq(UInt<1>("h0"), io.s) @[dut.scala 37:18]
            when _T_3 : @[dut.scala 37:18]
              fr3_reg <= UInt<1>("h1") @[dut.scala 57:17]
              fr2_reg <= UInt<1>("h1") @[dut.scala 58:17]
              fr1_reg <= UInt<1>("h1") @[dut.scala 59:17]
              dfr_reg <= UInt<1>("h1") @[dut.scala 60:17]
    io.fr3 <= fr3_reg @[dut.scala 66:10]
    io.fr2 <= fr2_reg @[dut.scala 67:10]
    io.fr1 <= fr1_reg @[dut.scala 68:10]
    io.dfr <= dfr_reg @[dut.scala 69:10]

