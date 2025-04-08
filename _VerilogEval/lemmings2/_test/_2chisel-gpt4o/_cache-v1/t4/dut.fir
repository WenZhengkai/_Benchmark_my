circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 18:22]
    reg savedWalkingDirection : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 19:38]
    io.walk_left <= UInt<1>("h0") @[dut.scala 22:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 23:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 24:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 26:17]
    when _T : @[dut.scala 26:17]
      io.walk_left <= UInt<1>("h1") @[dut.scala 28:20]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 29:12]
      when _T_1 : @[dut.scala 29:24]
        state <= UInt<2>("h2") @[dut.scala 30:15]
        savedWalkingDirection <= UInt<2>("h0") @[dut.scala 31:31]
      else :
        node _T_2 = or(io.bump_left, io.bump_right) @[dut.scala 32:31]
        when _T_2 : @[dut.scala 32:49]
          state <= UInt<2>("h1") @[dut.scala 33:15]
    else :
      node _T_3 = eq(UInt<2>("h1"), state) @[dut.scala 26:17]
      when _T_3 : @[dut.scala 26:17]
        io.walk_right <= UInt<1>("h1") @[dut.scala 38:21]
        node _T_4 = eq(io.ground, UInt<1>("h0")) @[dut.scala 39:12]
        when _T_4 : @[dut.scala 39:24]
          state <= UInt<2>("h2") @[dut.scala 40:15]
          savedWalkingDirection <= UInt<2>("h1") @[dut.scala 41:31]
        else :
          node _T_5 = or(io.bump_left, io.bump_right) @[dut.scala 42:31]
          when _T_5 : @[dut.scala 42:49]
            state <= UInt<2>("h0") @[dut.scala 43:15]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 26:17]
        when _T_6 : @[dut.scala 26:17]
          io.aaah <= UInt<1>("h1") @[dut.scala 48:15]
          when io.ground : @[dut.scala 49:23]
            state <= savedWalkingDirection @[dut.scala 50:15]


