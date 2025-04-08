circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:25]
    io.walk_left <= UInt<1>("h0") @[dut.scala 22:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 23:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 24:11]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 27:20]
    node _T_1 = asUInt(stateReg) @[dut.scala 27:20]
    node _T_2 = eq(_T, _T_1) @[dut.scala 27:20]
    when _T_2 : @[dut.scala 27:20]
      io.walk_left <= UInt<1>("h1") @[dut.scala 29:20]
      node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 30:12]
      when _T_3 : @[dut.scala 30:24]
        stateReg <= UInt<2>("h2") @[dut.scala 31:18]
      else :
        when io.bump_left : @[dut.scala 32:32]
          stateReg <= UInt<1>("h1") @[dut.scala 33:18]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 27:20]
      node _T_5 = asUInt(stateReg) @[dut.scala 27:20]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 27:20]
      when _T_6 : @[dut.scala 27:20]
        io.walk_right <= UInt<1>("h1") @[dut.scala 38:21]
        node _T_7 = eq(io.ground, UInt<1>("h0")) @[dut.scala 39:12]
        when _T_7 : @[dut.scala 39:24]
          stateReg <= UInt<2>("h3") @[dut.scala 40:18]
        else :
          when io.bump_right : @[dut.scala 41:33]
            stateReg <= UInt<1>("h0") @[dut.scala 42:18]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 27:20]
        node _T_9 = asUInt(stateReg) @[dut.scala 27:20]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 27:20]
        when _T_10 : @[dut.scala 27:20]
          io.aaah <= UInt<1>("h1") @[dut.scala 47:15]
          when io.ground : @[dut.scala 48:23]
            stateReg <= UInt<1>("h0") @[dut.scala 49:18]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 27:20]
          node _T_12 = asUInt(stateReg) @[dut.scala 27:20]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 27:20]
          when _T_13 : @[dut.scala 27:20]
            io.aaah <= UInt<1>("h1") @[dut.scala 54:15]
            when io.ground : @[dut.scala 55:23]
              stateReg <= UInt<1>("h1") @[dut.scala 56:18]


