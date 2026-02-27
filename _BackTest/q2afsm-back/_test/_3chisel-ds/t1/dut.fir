circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 15:22]
    node _io_g_T = eq(state, UInt<2>("h2")) @[dut.scala 19:12]
    node _io_g_T_1 = eq(state, UInt<3>("h4")) @[dut.scala 20:12]
    node _io_g_T_2 = eq(state, UInt<4>("h8")) @[dut.scala 21:12]
    node _io_g_T_3 = mux(_io_g_T_2, UInt<3>("h4"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _io_g_T_4 = mux(_io_g_T_1, UInt<2>("h2"), _io_g_T_3) @[Mux.scala 101:16]
    node _io_g_T_5 = mux(_io_g_T, UInt<1>("h1"), _io_g_T_4) @[Mux.scala 101:16]
    io.g <= _io_g_T_5 @[dut.scala 18:8]
    node _state_T = eq(state, UInt<1>("h1")) @[dut.scala 26:12]
    node _state_T_1 = bits(io.r, 0, 0) @[dut.scala 27:12]
    node _state_T_2 = bits(io.r, 0, 0) @[dut.scala 28:13]
    node _state_T_3 = eq(_state_T_2, UInt<1>("h0")) @[dut.scala 28:8]
    node _state_T_4 = bits(io.r, 1, 1) @[dut.scala 28:24]
    node _state_T_5 = and(_state_T_3, _state_T_4) @[dut.scala 28:17]
    node _state_T_6 = eq(io.r, UInt<3>("h4")) @[dut.scala 29:13]
    node _state_T_7 = mux(_state_T_6, UInt<4>("h8"), UInt<1>("h1")) @[Mux.scala 101:16]
    node _state_T_8 = mux(_state_T_5, UInt<3>("h4"), _state_T_7) @[Mux.scala 101:16]
    node _state_T_9 = mux(_state_T_1, UInt<2>("h2"), _state_T_8) @[Mux.scala 101:16]
    node _state_T_10 = eq(state, UInt<2>("h2")) @[dut.scala 31:12]
    node _state_T_11 = bits(io.r, 0, 0) @[dut.scala 31:31]
    node _state_T_12 = mux(_state_T_11, UInt<2>("h2"), UInt<1>("h1")) @[dut.scala 31:26]
    node _state_T_13 = eq(state, UInt<3>("h4")) @[dut.scala 32:12]
    node _state_T_14 = bits(io.r, 1, 1) @[dut.scala 32:31]
    node _state_T_15 = mux(_state_T_14, UInt<3>("h4"), UInt<1>("h1")) @[dut.scala 32:26]
    node _state_T_16 = eq(state, UInt<4>("h8")) @[dut.scala 33:12]
    node _state_T_17 = bits(io.r, 2, 2) @[dut.scala 33:31]
    node _state_T_18 = mux(_state_T_17, UInt<4>("h8"), UInt<1>("h1")) @[dut.scala 33:26]
    node _state_T_19 = mux(_state_T_16, _state_T_18, state) @[Mux.scala 101:16]
    node _state_T_20 = mux(_state_T_13, _state_T_15, _state_T_19) @[Mux.scala 101:16]
    node _state_T_21 = mux(_state_T_10, _state_T_12, _state_T_20) @[Mux.scala 101:16]
    node _state_T_22 = mux(_state_T, _state_T_9, _state_T_21) @[Mux.scala 101:16]
    state <= _state_T_22 @[dut.scala 25:9]

