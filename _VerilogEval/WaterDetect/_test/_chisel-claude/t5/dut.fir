circuit dut :
  module WaterReservoirController :
    input clock : Clock
    input reset : Reset
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 18:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 21:26]
    wire currentSensorState : UInt<2> @[dut.scala 24:32]
    node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 26:13]
    when _T : @[dut.scala 26:27]
      currentSensorState <= UInt<2>("h0") @[dut.scala 27:24]
    else :
      node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 28:19]
      when _T_1 : @[dut.scala 28:33]
        currentSensorState <= UInt<2>("h1") @[dut.scala 29:24]
      else :
        node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 30:19]
        when _T_2 : @[dut.scala 30:33]
          currentSensorState <= UInt<2>("h2") @[dut.scala 31:24]
        else :
          currentSensorState <= UInt<2>("h3") @[dut.scala 33:24]
    when io.reset : @[dut.scala 37:18]
      state <= UInt<2>("h3") @[dut.scala 38:11]
      prevState <= UInt<2>("h3") @[dut.scala 39:15]
    else :
      node _T_3 = neq(state, currentSensorState) @[dut.scala 41:16]
      when _T_3 : @[dut.scala 41:40]
        prevState <= state @[dut.scala 42:17]
        state <= currentSensorState @[dut.scala 43:13]
    node _io_fr1_T = eq(state, UInt<2>("h1")) @[dut.scala 48:20]
    node _io_fr1_T_1 = eq(state, UInt<2>("h2")) @[dut.scala 48:48]
    node _io_fr1_T_2 = or(_io_fr1_T, _io_fr1_T_1) @[dut.scala 48:38]
    node _io_fr1_T_3 = eq(state, UInt<2>("h3")) @[dut.scala 48:76]
    node _io_fr1_T_4 = or(_io_fr1_T_2, _io_fr1_T_3) @[dut.scala 48:66]
    io.fr1 <= _io_fr1_T_4 @[dut.scala 48:10]
    node _io_fr2_T = eq(state, UInt<2>("h2")) @[dut.scala 49:20]
    node _io_fr2_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 49:48]
    node _io_fr2_T_2 = or(_io_fr2_T, _io_fr2_T_1) @[dut.scala 49:38]
    io.fr2 <= _io_fr2_T_2 @[dut.scala 49:10]
    node _io_fr3_T = eq(state, UInt<2>("h3")) @[dut.scala 50:20]
    io.fr3 <= _io_fr3_T @[dut.scala 50:10]
    node _io_dfr_T = gt(state, prevState) @[dut.scala 54:20]
    node _io_dfr_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 54:43]
    node _io_dfr_T_2 = or(_io_dfr_T, _io_dfr_T_1) @[dut.scala 54:33]
    io.dfr <= _io_dfr_T_2 @[dut.scala 54:10]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    inst controller of WaterReservoirController @[dut.scala 67:26]
    controller.clock <= clock
    controller.reset <= reset
    controller.io.s <= io.s @[dut.scala 70:19]
    controller.io.reset <= reset @[dut.scala 71:23]
    io.fr1 <= controller.io.fr1 @[dut.scala 74:10]
    io.fr2 <= controller.io.fr2 @[dut.scala 75:10]
    io.fr3 <= controller.io.fr3 @[dut.scala 76:10]
    io.dfr <= controller.io.dfr @[dut.scala 77:10]

