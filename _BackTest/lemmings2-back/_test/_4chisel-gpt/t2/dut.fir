circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:25]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 26:20]
    node _T_1 = asUInt(stateReg) @[dut.scala 26:20]
    node _T_2 = eq(_T, _T_1) @[dut.scala 26:20]
    when _T_2 : @[dut.scala 26:20]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 28:12]
      when _T_3 : @[dut.scala 28:24]
        stateReg <= UInt<2>("h2") @[dut.scala 29:18]
      else :
        node _T_4 = or(io.bump_left, io.bump_right) @[dut.scala 30:31]
        when _T_4 : @[dut.scala 30:49]
          stateReg <= UInt<1>("h1") @[dut.scala 31:18]
    else :
      node _T_5 = asUInt(UInt<1>("h1")) @[dut.scala 26:20]
      node _T_6 = asUInt(stateReg) @[dut.scala 26:20]
      node _T_7 = eq(_T_5, _T_6) @[dut.scala 26:20]
      when _T_7 : @[dut.scala 26:20]
        node _T_8 = eq(io.ground, UInt<1>("h0")) @[dut.scala 35:12]
        when _T_8 : @[dut.scala 35:24]
          stateReg <= UInt<2>("h3") @[dut.scala 36:18]
        else :
          node _T_9 = or(io.bump_right, io.bump_left) @[dut.scala 37:32]
          when _T_9 : @[dut.scala 37:49]
            stateReg <= UInt<1>("h0") @[dut.scala 38:18]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 26:20]
        node _T_11 = asUInt(stateReg) @[dut.scala 26:20]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 26:20]
        when _T_12 : @[dut.scala 26:20]
          when io.ground : @[dut.scala 42:23]
            stateReg <= UInt<1>("h0") @[dut.scala 43:18]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 26:20]
          node _T_14 = asUInt(stateReg) @[dut.scala 26:20]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 26:20]
          when _T_15 : @[dut.scala 26:20]
            when io.ground : @[dut.scala 47:23]
              stateReg <= UInt<1>("h1") @[dut.scala 48:18]
    node _io_walk_left_T = eq(stateReg, UInt<1>("h0")) @[dut.scala 54:29]
    io.walk_left <= _io_walk_left_T @[dut.scala 54:16]
    node _io_walk_right_T = eq(stateReg, UInt<1>("h1")) @[dut.scala 55:30]
    io.walk_right <= _io_walk_right_T @[dut.scala 55:17]
    node _io_aaah_T = eq(stateReg, UInt<2>("h2")) @[dut.scala 56:24]
    node _io_aaah_T_1 = eq(stateReg, UInt<2>("h3")) @[dut.scala 56:59]
    node _io_aaah_T_2 = or(_io_aaah_T, _io_aaah_T_1) @[dut.scala 56:47]
    io.aaah <= _io_aaah_T_2 @[dut.scala 56:11]

