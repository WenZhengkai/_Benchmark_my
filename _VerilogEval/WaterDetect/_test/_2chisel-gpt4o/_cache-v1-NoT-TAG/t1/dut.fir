circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire currentState : UInt<2> @[dut.scala 22:33]
    currentState <= UInt<2>("h3") @[dut.scala 22:33]
    node _T = bits(io.s, 2, 2) @[dut.scala 23:12]
    when _T : @[dut.scala 23:17]
      currentState <= UInt<1>("h0") @[dut.scala 24:18]
    else :
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 25:18]
      when _T_1 : @[dut.scala 25:23]
        currentState <= UInt<1>("h1") @[dut.scala 26:18]
      else :
        node _T_2 = bits(io.s, 0, 0) @[dut.scala 27:18]
        when _T_2 : @[dut.scala 27:23]
          currentState <= UInt<2>("h2") @[dut.scala 28:18]
    reg currentStateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 32:32]
    reg previousStateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 33:33]
    node _T_3 = bits(reset, 0, 0) @[dut.scala 34:14]
    when _T_3 : @[dut.scala 34:22]
      currentStateReg <= UInt<2>("h3") @[dut.scala 35:21]
      previousStateReg <= UInt<2>("h3") @[dut.scala 36:22]
    else :
      previousStateReg <= currentStateReg @[dut.scala 38:22]
      currentStateReg <= currentState @[dut.scala 39:21]
    node _io_fr3_T = eq(currentStateReg, UInt<2>("h3")) @[dut.scala 43:30]
    io.fr3 <= _io_fr3_T @[dut.scala 43:10]
    node _io_fr2_T = eq(currentStateReg, UInt<2>("h2")) @[dut.scala 44:30]
    node _io_fr2_T_1 = eq(currentStateReg, UInt<2>("h3")) @[dut.scala 44:78]
    node _io_fr2_T_2 = or(_io_fr2_T, _io_fr2_T_1) @[dut.scala 44:58]
    io.fr2 <= _io_fr2_T_2 @[dut.scala 44:10]
    node _io_fr1_T = eq(currentStateReg, UInt<1>("h1")) @[dut.scala 45:30]
    node _io_fr1_T_1 = eq(currentStateReg, UInt<2>("h2")) @[dut.scala 45:78]
    node _io_fr1_T_2 = or(_io_fr1_T, _io_fr1_T_1) @[dut.scala 45:58]
    node _io_fr1_T_3 = eq(currentStateReg, UInt<2>("h3")) @[dut.scala 45:126]
    node _io_fr1_T_4 = or(_io_fr1_T_2, _io_fr1_T_3) @[dut.scala 45:106]
    io.fr1 <= _io_fr1_T_4 @[dut.scala 45:10]
    node isLevelRising = lt(currentStateReg, previousStateReg) @[dut.scala 48:39]
    node _io_dfr_T = eq(currentStateReg, UInt<2>("h3")) @[dut.scala 49:30]
    node _io_dfr_T_1 = or(_io_dfr_T, isLevelRising) @[dut.scala 49:54]
    io.dfr <= _io_dfr_T_1 @[dut.scala 49:10]

