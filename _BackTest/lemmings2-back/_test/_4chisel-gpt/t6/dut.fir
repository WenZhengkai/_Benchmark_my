circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:22]
    wire nextState : UInt @[dut.scala 19:30]
    nextState <= state @[dut.scala 19:30]
    io.walk_left <= UInt<1>("h0") @[dut.scala 22:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 23:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 24:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 27:17]
    when _T : @[dut.scala 27:17]
      io.walk_left <= UInt<1>("h1") @[dut.scala 29:20]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 30:12]
      when _T_1 : @[dut.scala 30:24]
        nextState <= UInt<2>("h2") @[dut.scala 31:19]
      else :
        node _T_2 = or(io.bump_left, io.bump_right) @[dut.scala 32:31]
        when _T_2 : @[dut.scala 32:49]
          nextState <= UInt<2>("h1") @[dut.scala 33:19]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[dut.scala 27:17]
      when _T_3 : @[dut.scala 27:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 38:21]
        node _T_4 = eq(io.ground, UInt<1>("h0")) @[dut.scala 39:12]
        when _T_4 : @[dut.scala 39:24]
          nextState <= UInt<2>("h3") @[dut.scala 40:19]
        else :
          node _T_5 = or(io.bump_left, io.bump_right) @[dut.scala 41:31]
          when _T_5 : @[dut.scala 41:49]
            nextState <= UInt<2>("h0") @[dut.scala 42:19]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 27:17]
        when _T_6 : @[dut.scala 27:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 47:15]
          when io.ground : @[dut.scala 48:23]
            nextState <= UInt<2>("h0") @[dut.scala 49:19]
        else :
          node _T_7 = eq(UInt<2>("h3"), state) @[dut.scala 27:17]
          when _T_7 : @[dut.scala 27:17]
            io.aaah <= UInt<1>("h1") @[dut.scala 54:15]
            when io.ground : @[dut.scala 55:23]
              nextState <= UInt<2>("h1") @[dut.scala 56:19]
    state <= nextState @[dut.scala 62:9]
    node _T_8 = bits(reset, 0, 0) @[dut.scala 65:14]
    when _T_8 : @[dut.scala 65:22]
      state <= UInt<2>("h0") @[dut.scala 66:11]


