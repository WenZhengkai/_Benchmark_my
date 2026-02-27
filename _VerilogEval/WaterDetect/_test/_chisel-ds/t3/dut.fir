circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 15:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 18:26]
    when io.reset : @[dut.scala 21:18]
      state <= UInt<1>("h0") @[dut.scala 22:11]
      prevState <= UInt<1>("h0") @[dut.scala 23:15]
    else :
      prevState <= state @[dut.scala 25:15]
      node _state_T = eq(io.s, UInt<1>("h0")) @[dut.scala 27:13]
      node _state_T_1 = eq(io.s, UInt<1>("h1")) @[dut.scala 28:13]
      node _state_T_2 = eq(io.s, UInt<2>("h3")) @[dut.scala 29:13]
      node _state_T_3 = eq(io.s, UInt<3>("h7")) @[dut.scala 30:13]
      node _state_T_4 = mux(_state_T_3, UInt<2>("h3"), state) @[Mux.scala 101:16]
      node _state_T_5 = mux(_state_T_2, UInt<2>("h2"), _state_T_4) @[Mux.scala 101:16]
      node _state_T_6 = mux(_state_T_1, UInt<1>("h1"), _state_T_5) @[Mux.scala 101:16]
      node _state_T_7 = mux(_state_T, UInt<1>("h0"), _state_T_6) @[Mux.scala 101:16]
      state <= _state_T_7 @[dut.scala 26:11]
    node _io_fr1_T = eq(state, UInt<1>("h0")) @[dut.scala 35:23]
    node _io_fr1_T_1 = eq(state, UInt<1>("h1")) @[dut.scala 35:50]
    node _io_fr1_T_2 = eq(state, UInt<2>("h2")) @[dut.scala 35:77]
    node _io_fr1_T_3 = mux(_io_fr1_T_2, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 35:70]
    node _io_fr1_T_4 = mux(_io_fr1_T_1, UInt<1>("h1"), _io_fr1_T_3) @[dut.scala 35:43]
    node _io_fr1_T_5 = mux(_io_fr1_T, UInt<1>("h1"), _io_fr1_T_4) @[dut.scala 35:16]
    io.fr1 <= _io_fr1_T_5 @[dut.scala 35:10]
    node _io_fr2_T = eq(state, UInt<1>("h0")) @[dut.scala 36:23]
    node _io_fr2_T_1 = eq(state, UInt<1>("h1")) @[dut.scala 36:50]
    node _io_fr2_T_2 = mux(_io_fr2_T_1, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 36:43]
    node _io_fr2_T_3 = mux(_io_fr2_T, UInt<1>("h1"), _io_fr2_T_2) @[dut.scala 36:16]
    io.fr2 <= _io_fr2_T_3 @[dut.scala 36:10]
    node _io_fr3_T = eq(state, UInt<1>("h0")) @[dut.scala 37:23]
    node _io_fr3_T_1 = mux(_io_fr3_T, UInt<1>("h1"), UInt<1>("h0")) @[dut.scala 37:16]
    io.fr3 <= _io_fr3_T_1 @[dut.scala 37:10]
    node _io_dfr_T = gt(state, prevState) @[dut.scala 40:20]
    io.dfr <= _io_dfr_T @[dut.scala 40:10]

