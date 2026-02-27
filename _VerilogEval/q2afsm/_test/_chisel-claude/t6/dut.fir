circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:22]
    io.g <= UInt<1>("h0") @[dut.scala 19:8]
    node r0 = bits(io.r, 0, 0) @[dut.scala 22:16]
    node r1 = bits(io.r, 1, 1) @[dut.scala 23:16]
    node r2 = bits(io.r, 2, 2) @[dut.scala 24:16]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 27:18]
    when _T : @[dut.scala 27:18]
      when r0 : @[dut.scala 30:17]
        state <= UInt<2>("h1") @[dut.scala 31:15]
      else :
        when r1 : @[dut.scala 32:24]
          state <= UInt<2>("h2") @[dut.scala 33:15]
        else :
          when r2 : @[dut.scala 34:24]
            state <= UInt<2>("h3") @[dut.scala 35:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 37:15]
    else :
      node _T_1 = eq(UInt<2>("h1"), state) @[dut.scala 27:18]
      when _T_1 : @[dut.scala 27:18]
        io.g <= UInt<1>("h1") @[dut.scala 43:12]
        when r0 : @[dut.scala 45:17]
          state <= UInt<2>("h1") @[dut.scala 46:15]
        else :
          state <= UInt<2>("h0") @[dut.scala 48:15]
      else :
        node _T_2 = eq(UInt<2>("h2"), state) @[dut.scala 27:18]
        when _T_2 : @[dut.scala 27:18]
          io.g <= UInt<2>("h2") @[dut.scala 54:12]
          when r1 : @[dut.scala 56:17]
            state <= UInt<2>("h2") @[dut.scala 57:15]
          else :
            state <= UInt<2>("h0") @[dut.scala 59:15]
        else :
          node _T_3 = eq(UInt<2>("h3"), state) @[dut.scala 27:18]
          when _T_3 : @[dut.scala 27:18]
            io.g <= UInt<3>("h4") @[dut.scala 65:12]
            when r2 : @[dut.scala 67:17]
              state <= UInt<2>("h3") @[dut.scala 68:15]
            else :
              state <= UInt<2>("h0") @[dut.scala 70:15]


