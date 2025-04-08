circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire currentState : UInt @[dut.scala 23:33]
    currentState <= UInt<1>("h0") @[dut.scala 23:33]
    node _T = bits(io.s, 2, 2) @[dut.scala 24:12]
    when _T : @[dut.scala 24:17]
      currentState <= UInt<2>("h3") @[dut.scala 25:18]
    else :
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 26:18]
      when _T_1 : @[dut.scala 26:23]
        currentState <= UInt<2>("h2") @[dut.scala 27:18]
      else :
        node _T_2 = bits(io.s, 0, 0) @[dut.scala 28:18]
        when _T_2 : @[dut.scala 28:23]
          currentState <= UInt<1>("h1") @[dut.scala 29:18]
    reg currentStateReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 33:32]
    reg previousStateReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 34:33]
    node _T_3 = bits(reset, 0, 0) @[dut.scala 35:14]
    when _T_3 : @[dut.scala 35:22]
      currentStateReg <= UInt<1>("h0") @[dut.scala 36:21]
      previousStateReg <= UInt<1>("h0") @[dut.scala 37:22]
    else :
      currentStateReg <= currentState @[dut.scala 39:21]
      previousStateReg <= currentStateReg @[dut.scala 40:22]
    node _io_fr3_T = eq(currentStateReg, UInt<1>("h0")) @[dut.scala 44:30]
    io.fr3 <= _io_fr3_T @[dut.scala 44:10]
    node _io_fr2_T = eq(currentStateReg, UInt<1>("h0")) @[dut.scala 45:30]
    node _io_fr2_T_1 = eq(currentStateReg, UInt<1>("h1")) @[dut.scala 45:63]
    node _io_fr2_T_2 = or(_io_fr2_T, _io_fr2_T_1) @[dut.scala 45:43]
    io.fr2 <= _io_fr2_T_2 @[dut.scala 45:10]
    node _io_fr1_T = eq(currentStateReg, UInt<1>("h0")) @[dut.scala 46:30]
    node _io_fr1_T_1 = eq(currentStateReg, UInt<1>("h1")) @[dut.scala 46:63]
    node _io_fr1_T_2 = or(_io_fr1_T, _io_fr1_T_1) @[dut.scala 46:43]
    node _io_fr1_T_3 = eq(currentStateReg, UInt<2>("h2")) @[dut.scala 46:100]
    node _io_fr1_T_4 = or(_io_fr1_T_2, _io_fr1_T_3) @[dut.scala 46:80]
    io.fr1 <= _io_fr1_T_4 @[dut.scala 46:10]
    node isLevelRising = lt(currentStateReg, previousStateReg) @[dut.scala 49:39]
    node _io_dfr_T = eq(currentStateReg, UInt<1>("h0")) @[dut.scala 50:30]
    node _io_dfr_T_1 = or(_io_dfr_T, isLevelRising) @[dut.scala 50:43]
    io.dfr <= _io_dfr_T_1 @[dut.scala 50:10]

