circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 15:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:26]
    when io.reset : @[dut.scala 25:18]
      state <= UInt<2>("h3") @[dut.scala 26:11]
      prevState <= UInt<2>("h3") @[dut.scala 27:15]
    else :
      prevState <= state @[dut.scala 30:15]
      node _T = bits(io.s, 2, 2) @[dut.scala 33:14]
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 33:25]
      node _T_2 = and(_T, _T_1) @[dut.scala 33:18]
      node _T_3 = bits(io.s, 0, 0) @[dut.scala 33:36]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 33:29]
      when _T_4 : @[dut.scala 33:41]
        state <= UInt<1>("h0") @[dut.scala 34:13]
      else :
        node _T_5 = bits(io.s, 1, 1) @[dut.scala 35:20]
        node _T_6 = bits(io.s, 0, 0) @[dut.scala 35:31]
        node _T_7 = and(_T_5, _T_6) @[dut.scala 35:24]
        when _T_7 : @[dut.scala 35:36]
          state <= UInt<1>("h1") @[dut.scala 36:13]
        else :
          node _T_8 = bits(io.s, 0, 0) @[dut.scala 37:20]
          when _T_8 : @[dut.scala 37:25]
            state <= UInt<2>("h2") @[dut.scala 38:13]
          else :
            state <= UInt<2>("h3") @[dut.scala 40:13]
    node _io_fr3_T = eq(state, UInt<2>("h3")) @[dut.scala 45:19]
    io.fr3 <= _io_fr3_T @[dut.scala 45:10]
    node _io_fr2_T = eq(state, UInt<2>("h2")) @[dut.scala 46:19]
    node _io_fr2_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 46:52]
    node _io_fr2_T_2 = or(_io_fr2_T, _io_fr2_T_1) @[dut.scala 46:43]
    io.fr2 <= _io_fr2_T_2 @[dut.scala 46:10]
    node _io_fr1_T = eq(state, UInt<1>("h1")) @[dut.scala 47:19]
    node _io_fr1_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 47:52]
    node _io_fr1_T_2 = or(_io_fr1_T, _io_fr1_T_1) @[dut.scala 47:43]
    node _io_fr1_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 47:85]
    node _io_fr1_T_4 = or(_io_fr1_T_2, _io_fr1_T_3) @[dut.scala 47:76]
    io.fr1 <= _io_fr1_T_4 @[dut.scala 47:10]
    node _io_dfr_T = lt(prevState, state) @[dut.scala 48:23]
    io.dfr <= _io_dfr_T @[dut.scala 48:10]

