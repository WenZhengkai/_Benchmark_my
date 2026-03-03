circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    node _state_T = bits(reset, 0, 0) @[dut.scala 11:46]
    reg state : UInt<2>, clock with :
      reset => (_state_T, UInt<2>("h0")) @[dut.scala 13:21]
    node _state_T_1 = eq(UInt<2>("h0"), state) @[dut.scala 15:16]
    when _state_T_1 : @[dut.scala 15:16]
      node _state_T_2 = bits(io.r, 0, 0) @[dut.scala 17:18]
      when _state_T_2 : @[dut.scala 17:28]
        state <= UInt<2>("h1") @[dut.scala 17:33]
      else :
        node _state_T_3 = bits(io.r, 1, 1) @[dut.scala 18:25]
        when _state_T_3 : @[dut.scala 18:29]
          state <= UInt<2>("h2") @[dut.scala 18:34]
        else :
          node _state_T_4 = bits(io.r, 2, 2) @[dut.scala 19:25]
          when _state_T_4 : @[dut.scala 19:29]
            state <= UInt<2>("h3") @[dut.scala 19:34]
          else :
            state <= UInt<2>("h0") @[dut.scala 20:33]
    else :
      node _state_T_5 = eq(UInt<2>("h1"), state) @[dut.scala 15:16]
      when _state_T_5 : @[dut.scala 15:16]
        node _state_st_T = bits(io.r, 0, 0) @[dut.scala 22:30]
        node _state_st_T_1 = mux(_state_st_T, UInt<2>("h1"), UInt<2>("h0")) @[dut.scala 22:25]
        state <= _state_st_T_1 @[dut.scala 22:19]
      else :
        node _state_T_6 = eq(UInt<2>("h2"), state) @[dut.scala 15:16]
        when _state_T_6 : @[dut.scala 15:16]
          node _state_st_T_2 = bits(io.r, 1, 1) @[dut.scala 23:30]
          node _state_st_T_3 = mux(_state_st_T_2, UInt<2>("h2"), UInt<2>("h0")) @[dut.scala 23:25]
          state <= _state_st_T_3 @[dut.scala 23:19]
        else :
          node _state_T_7 = eq(UInt<2>("h3"), state) @[dut.scala 15:16]
          when _state_T_7 : @[dut.scala 15:16]
            node _state_st_T_4 = bits(io.r, 2, 2) @[dut.scala 24:30]
            node _state_st_T_5 = mux(_state_st_T_4, UInt<2>("h3"), UInt<2>("h0")) @[dut.scala 24:25]
            state <= _state_st_T_5 @[dut.scala 24:19]
    io.g <= UInt<1>("h0") @[dut.scala 31:8]
    node _T = eq(UInt<2>("h1"), state) @[dut.scala 32:17]
    when _T : @[dut.scala 32:17]
      io.g <= UInt<1>("h1") @[dut.scala 33:19]
    else :
      node _T_1 = eq(UInt<2>("h2"), state) @[dut.scala 32:17]
      when _T_1 : @[dut.scala 32:17]
        io.g <= UInt<2>("h2") @[dut.scala 34:19]
      else :
        node _T_2 = eq(UInt<2>("h3"), state) @[dut.scala 32:17]
        when _T_2 : @[dut.scala 32:17]
          io.g <= UInt<3>("h4") @[dut.scala 35:19]


