circuit dut :
  module WaterReservoirController :
    input clock : Clock
    input reset : Reset
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 18:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 19:26]
    wire currentState : UInt<2> @[dut.scala 22:26]
    node _currentState_T = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node _currentState_T_1 = mux(_currentState_T, UInt<2>("h0"), UInt<2>("h3")) @[Mux.scala 81:58]
    node _currentState_T_2 = eq(UInt<2>("h3"), io.s) @[Mux.scala 81:61]
    node _currentState_T_3 = mux(_currentState_T_2, UInt<2>("h1"), _currentState_T_1) @[Mux.scala 81:58]
    node _currentState_T_4 = eq(UInt<1>("h1"), io.s) @[Mux.scala 81:61]
    node _currentState_T_5 = mux(_currentState_T_4, UInt<2>("h2"), _currentState_T_3) @[Mux.scala 81:58]
    node _currentState_T_6 = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node _currentState_T_7 = mux(_currentState_T_6, UInt<2>("h3"), _currentState_T_5) @[Mux.scala 81:58]
    currentState <= _currentState_T_7 @[dut.scala 23:16]
    when io.reset : @[dut.scala 31:19]
      state <= UInt<2>("h3") @[dut.scala 32:11]
      prevState <= UInt<2>("h3") @[dut.scala 33:15]
    else :
      node _T = neq(state, currentState) @[dut.scala 35:17]
      when _T : @[dut.scala 35:35]
        prevState <= state @[dut.scala 36:17]
        state <= currentState @[dut.scala 37:13]
    wire fr1Out : UInt<1> @[dut.scala 42:20]
    wire fr2Out : UInt<1> @[dut.scala 43:20]
    wire fr3Out : UInt<1> @[dut.scala 44:20]
    wire dfrOut : UInt<1> @[dut.scala 45:20]
    fr1Out <= UInt<1>("h0") @[dut.scala 48:10]
    fr2Out <= UInt<1>("h0") @[dut.scala 49:10]
    fr3Out <= UInt<1>("h0") @[dut.scala 50:10]
    dfrOut <= UInt<1>("h0") @[dut.scala 51:10]
    node _T_1 = eq(UInt<2>("h0"), state) @[dut.scala 54:18]
    when _T_1 : @[dut.scala 54:18]
      fr1Out <= UInt<1>("h0") @[dut.scala 57:14]
      fr2Out <= UInt<1>("h0") @[dut.scala 58:14]
      fr3Out <= UInt<1>("h0") @[dut.scala 59:14]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 54:18]
      when _T_2 : @[dut.scala 54:18]
        fr1Out <= UInt<1>("h1") @[dut.scala 62:14]
        fr2Out <= UInt<1>("h0") @[dut.scala 63:14]
        fr3Out <= UInt<1>("h0") @[dut.scala 64:14]
      else :
        node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 54:18]
        when _T_3 : @[dut.scala 54:18]
          fr1Out <= UInt<1>("h1") @[dut.scala 67:14]
          fr2Out <= UInt<1>("h1") @[dut.scala 68:14]
          fr3Out <= UInt<1>("h0") @[dut.scala 69:14]
        else :
          node _T_4 = eq(UInt<2>("h3"), state) @[dut.scala 54:18]
          when _T_4 : @[dut.scala 54:18]
            fr1Out <= UInt<1>("h1") @[dut.scala 72:14]
            fr2Out <= UInt<1>("h1") @[dut.scala 73:14]
            fr3Out <= UInt<1>("h1") @[dut.scala 74:14]
    node _dfrOut_T = gt(prevState, state) @[dut.scala 80:23]
    dfrOut <= _dfrOut_T @[dut.scala 80:10]
    io.fr1 <= fr1Out @[dut.scala 83:10]
    io.fr2 <= fr2Out @[dut.scala 84:10]
    io.fr3 <= fr3Out @[dut.scala 85:10]
    io.dfr <= dfrOut @[dut.scala 86:10]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    inst controller of WaterReservoirController @[dut.scala 99:26]
    controller.clock <= clock
    controller.reset <= reset
    controller.io.s <= io.s @[dut.scala 101:19]
    node _controller_io_reset_T = bits(reset, 0, 0) @[dut.scala 102:32]
    controller.io.reset <= _controller_io_reset_T @[dut.scala 102:23]
    io.fr1 <= controller.io.fr1 @[dut.scala 104:10]
    io.fr2 <= controller.io.fr2 @[dut.scala 105:10]
    io.fr3 <= controller.io.fr3 @[dut.scala 106:10]
    io.dfr <= controller.io.dfr @[dut.scala 107:10]

