circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<4>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node s1 = bits(io.s, 1, 1) @[dut.scala 14:16]
    node s2 = bits(io.s, 2, 2) @[dut.scala 15:16]
    node s3 = bits(io.s, 3, 3) @[dut.scala 16:16]
    node _level_above_s3_T = and(s1, s2) @[dut.scala 19:27]
    node level_above_s3 = and(_level_above_s3_T, s3) @[dut.scala 19:33]
    node _level_between_s3_s2_T = and(s1, s2) @[dut.scala 20:32]
    node _level_between_s3_s2_T_1 = eq(s3, UInt<1>("h0")) @[dut.scala 20:41]
    node level_between_s3_s2 = and(_level_between_s3_s2_T, _level_between_s3_s2_T_1) @[dut.scala 20:38]
    node _level_between_s2_s1_T = eq(s2, UInt<1>("h0")) @[dut.scala 21:35]
    node level_between_s2_s1 = and(s1, _level_between_s2_s1_T) @[dut.scala 21:32]
    node level_below_s1 = eq(s1, UInt<1>("h0")) @[dut.scala 22:24]
    reg prev_level : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 25:27]
    wire curr_level : UInt<2> @[dut.scala 32:24]
    node _curr_level_T = mux(level_below_s1, UInt<1>("h0"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _curr_level_T_1 = mux(level_between_s2_s1, UInt<1>("h1"), _curr_level_T) @[Mux.scala 101:16]
    node _curr_level_T_2 = mux(level_between_s3_s2, UInt<2>("h2"), _curr_level_T_1) @[Mux.scala 101:16]
    node _curr_level_T_3 = mux(level_above_s3, UInt<2>("h3"), _curr_level_T_2) @[Mux.scala 101:16]
    curr_level <= _curr_level_T_3 @[dut.scala 33:14]
    node level_rising = gt(curr_level, prev_level) @[dut.scala 41:33]
    prev_level <= curr_level @[dut.scala 44:14]
    reg fr3_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 47:24]
    reg fr2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 48:24]
    reg fr1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 49:24]
    reg dfr_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 50:24]
    when level_above_s3 : @[dut.scala 53:24]
      fr3_reg <= UInt<1>("h0") @[dut.scala 55:13]
      fr2_reg <= UInt<1>("h0") @[dut.scala 56:13]
      fr1_reg <= UInt<1>("h0") @[dut.scala 57:13]
      dfr_reg <= UInt<1>("h0") @[dut.scala 58:13]
    else :
      when level_between_s3_s2 : @[dut.scala 59:35]
        fr3_reg <= UInt<1>("h0") @[dut.scala 61:13]
        fr2_reg <= UInt<1>("h0") @[dut.scala 62:13]
        fr1_reg <= UInt<1>("h1") @[dut.scala 63:13]
        dfr_reg <= level_rising @[dut.scala 65:13]
      else :
        when level_between_s2_s1 : @[dut.scala 66:35]
          fr3_reg <= UInt<1>("h0") @[dut.scala 68:13]
          fr2_reg <= UInt<1>("h1") @[dut.scala 69:13]
          fr1_reg <= UInt<1>("h1") @[dut.scala 70:13]
          dfr_reg <= level_rising @[dut.scala 72:13]
        else :
          fr3_reg <= UInt<1>("h1") @[dut.scala 75:13]
          fr2_reg <= UInt<1>("h1") @[dut.scala 76:13]
          fr1_reg <= UInt<1>("h1") @[dut.scala 77:13]
          dfr_reg <= level_rising @[dut.scala 79:13]
    io.fr3 <= fr3_reg @[dut.scala 83:10]
    io.fr2 <= fr2_reg @[dut.scala 84:10]
    io.fr1 <= fr1_reg @[dut.scala 85:10]
    io.dfr <= dfr_reg @[dut.scala 86:10]

