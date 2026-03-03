circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    node r0 = bits(io.r, 0, 0) @[dut.scala 16:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 17:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 18:16]
    io.g <= UInt<1>("h0") @[dut.scala 21:8]
    node _T = eq(UInt<2>("h1"), state) @[dut.scala 24:17]
    when _T : @[dut.scala 24:17]
      io.g <= UInt<1>("h1") @[dut.scala 25:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), state) @[dut.scala 24:17]
      when _T_1 : @[dut.scala 24:17]
        io.g <= UInt<2>("h2") @[dut.scala 26:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), state) @[dut.scala 24:17]
        when _T_2 : @[dut.scala 24:17]
          io.g <= UInt<3>("h4") @[dut.scala 27:19]
    node _T_3 = eq(UInt<2>("h0"), state) @[dut.scala 31:17]
    when _T_3 : @[dut.scala 31:17]
      when r0 : @[dut.scala 33:21]
        state <= UInt<2>("h1") @[dut.scala 33:29]
      else :
        when r1 : @[dut.scala 34:23]
          state <= UInt<2>("h2") @[dut.scala 34:31]
        else :
          when r2 : @[dut.scala 35:23]
            state <= UInt<2>("h3") @[dut.scala 35:31]
          else :
            state <= UInt<2>("h0") @[dut.scala 36:31]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 31:17]
      when _T_4 : @[dut.scala 31:17]
        when r0 : @[dut.scala 39:16]
          state <= UInt<2>("h1") @[dut.scala 39:24]
        else :
          state <= UInt<2>("h0") @[dut.scala 39:51]
      else :
        node _T_5 = eq(UInt<2>("h2"), state) @[dut.scala 31:17]
        when _T_5 : @[dut.scala 31:17]
          when r1 : @[dut.scala 42:16]
            state <= UInt<2>("h2") @[dut.scala 42:24]
          else :
            state <= UInt<2>("h0") @[dut.scala 42:51]
        else :
          node _T_6 = eq(UInt<2>("h3"), state) @[dut.scala 31:17]
          when _T_6 : @[dut.scala 31:17]
            when r2 : @[dut.scala 45:16]
              state <= UInt<2>("h3") @[dut.scala 45:24]
            else :
              state <= UInt<2>("h0") @[dut.scala 45:51]


