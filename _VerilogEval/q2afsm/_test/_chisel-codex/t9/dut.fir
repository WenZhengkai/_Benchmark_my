circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:22]
    wire nextState : UInt @[dut.scala 15:30]
    nextState <= state @[dut.scala 15:30]
    node _T = eq(UInt<2>("h0"), state) @[dut.scala 18:17]
    when _T : @[dut.scala 18:17]
      node _T_1 = bits(io.r, 0, 0) @[dut.scala 20:16]
      when _T_1 : @[dut.scala 20:21]
        nextState <= UInt<2>("h1") @[dut.scala 21:19]
      else :
        node _T_2 = bits(io.r, 1, 1) @[dut.scala 22:22]
        when _T_2 : @[dut.scala 22:27]
          nextState <= UInt<2>("h2") @[dut.scala 23:19]
        else :
          node _T_3 = bits(io.r, 2, 2) @[dut.scala 24:22]
          when _T_3 : @[dut.scala 24:27]
            nextState <= UInt<2>("h3") @[dut.scala 25:19]
          else :
            nextState <= UInt<2>("h0") @[dut.scala 27:19]
    else :
      node _T_4 = eq(UInt<2>("h1"), state) @[dut.scala 18:17]
      when _T_4 : @[dut.scala 18:17]
        node _T_5 = bits(io.r, 0, 0) @[dut.scala 31:16]
        when _T_5 : @[dut.scala 31:21]
          nextState <= UInt<2>("h1") @[dut.scala 31:33]
        else :
          nextState <= UInt<2>("h0") @[dut.scala 32:32]
      else :
        node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 18:17]
        when _T_6 : @[dut.scala 18:17]
          node _T_7 = bits(io.r, 1, 1) @[dut.scala 35:16]
          when _T_7 : @[dut.scala 35:21]
            nextState <= UInt<2>("h2") @[dut.scala 35:33]
          else :
            nextState <= UInt<2>("h0") @[dut.scala 36:32]
        else :
          node _T_8 = eq(UInt<2>("h3"), state) @[dut.scala 18:17]
          when _T_8 : @[dut.scala 18:17]
            node _T_9 = bits(io.r, 2, 2) @[dut.scala 39:16]
            when _T_9 : @[dut.scala 39:21]
              nextState <= UInt<2>("h3") @[dut.scala 39:33]
            else :
              nextState <= UInt<2>("h0") @[dut.scala 40:32]
    state <= nextState @[dut.scala 44:9]
    io.g <= UInt<1>("h0") @[dut.scala 47:8]
    node _T_10 = eq(UInt<2>("h1"), state) @[dut.scala 48:17]
    when _T_10 : @[dut.scala 48:17]
      io.g <= UInt<1>("h1") @[dut.scala 49:19]
    else :
      node _T_11 = eq(UInt<2>("h2"), state) @[dut.scala 48:17]
      when _T_11 : @[dut.scala 48:17]
        io.g <= UInt<2>("h2") @[dut.scala 50:19]
      else :
        node _T_12 = eq(UInt<2>("h3"), state) @[dut.scala 48:17]
        when _T_12 : @[dut.scala 48:17]
          io.g <= UInt<3>("h4") @[dut.scala 51:19]


