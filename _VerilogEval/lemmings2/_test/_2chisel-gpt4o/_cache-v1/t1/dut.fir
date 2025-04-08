circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip bump_left : UInt<1>, flip bump_right : UInt<1>, flip ground : UInt<1>, walk_left : UInt<1>, walk_right : UInt<1>, aaah : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 19:22]
    io.walk_left <= UInt<1>("h0") @[dut.scala 22:16]
    io.walk_right <= UInt<1>("h0") @[dut.scala 23:17]
    io.aaah <= UInt<1>("h0") @[dut.scala 24:11]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 27:17]
    when _T : @[dut.scala 27:17]
      node _T_1 = eq(io.ground, UInt<1>("h0")) @[dut.scala 29:12]
      when _T_1 : @[dut.scala 29:24]
        state <= UInt<2>("h2") @[dut.scala 30:15]
        io.aaah <= UInt<1>("h1") @[dut.scala 31:17]
      else :
        when io.bump_left : @[dut.scala 32:32]
          state <= UInt<2>("h1") @[dut.scala 33:15]
        else :
          io.walk_left <= UInt<1>("h1") @[dut.scala 35:22]
    else :
      node _T_2 = eq(UInt<2>("h1"), state) @[dut.scala 27:17]
      when _T_2 : @[dut.scala 27:17]
        node _T_3 = eq(io.ground, UInt<1>("h0")) @[dut.scala 40:12]
        when _T_3 : @[dut.scala 40:24]
          state <= UInt<2>("h3") @[dut.scala 41:15]
          io.aaah <= UInt<1>("h1") @[dut.scala 42:17]
        else :
          when io.bump_right : @[dut.scala 43:33]
            state <= UInt<2>("h0") @[dut.scala 44:15]
          else :
            io.walk_right <= UInt<1>("h1") @[dut.scala 46:23]
      else :
        node _T_4 = eq(UInt<2>("h2"), state) @[dut.scala 27:17]
        when _T_4 : @[dut.scala 27:17]
          when io.ground : @[dut.scala 51:23]
            state <= UInt<2>("h0") @[dut.scala 52:15]
            io.walk_left <= UInt<1>("h1") @[dut.scala 53:22]
          else :
            io.aaah <= UInt<1>("h1") @[dut.scala 55:17]
        else :
          node _T_5 = eq(UInt<2>("h3"), state) @[dut.scala 27:17]
          when _T_5 : @[dut.scala 27:17]
            when io.ground : @[dut.scala 60:23]
              state <= UInt<2>("h1") @[dut.scala 61:15]
              io.walk_right <= UInt<1>("h1") @[dut.scala 62:23]
            else :
              io.aaah <= UInt<1>("h1") @[dut.scala 64:17]


