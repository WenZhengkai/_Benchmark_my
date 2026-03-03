circuit dut :
  module dut :
    input clock : Clock
    input reset : AsyncReset
    input bump_left : UInt<1>
    input bump_right : UInt<1>
    input ground : UInt<1>
    output walk_left : UInt<1>
    output walk_right : UInt<1>
    output aaah : UInt<1>

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 24:19]
    node _T_1 = asUInt(state) @[dut.scala 24:19]
    node _T_2 = eq(_T, _T_1) @[dut.scala 24:19]
    when _T_2 : @[dut.scala 24:19]
      node _T_3 = eq(ground, UInt<1>("h0")) @[dut.scala 26:14]
      when _T_3 : @[dut.scala 26:23]
        state <= UInt<2>("h2") @[dut.scala 27:17]
      else :
        when bump_left : @[dut.scala 30:27]
          state <= UInt<1>("h1") @[dut.scala 30:35]
        else :
          state <= UInt<1>("h0") @[dut.scala 31:35]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[dut.scala 24:19]
      node _T_5 = asUInt(state) @[dut.scala 24:19]
      node _T_6 = eq(_T_4, _T_5) @[dut.scala 24:19]
      when _T_6 : @[dut.scala 24:19]
        node _T_7 = eq(ground, UInt<1>("h0")) @[dut.scala 36:14]
        when _T_7 : @[dut.scala 36:23]
          state <= UInt<2>("h3") @[dut.scala 37:17]
        else :
          when bump_right : @[dut.scala 40:28]
            state <= UInt<1>("h0") @[dut.scala 40:36]
          else :
            state <= UInt<1>("h1") @[dut.scala 41:36]
      else :
        node _T_8 = asUInt(UInt<2>("h2")) @[dut.scala 24:19]
        node _T_9 = asUInt(state) @[dut.scala 24:19]
        node _T_10 = eq(_T_8, _T_9) @[dut.scala 24:19]
        when _T_10 : @[dut.scala 24:19]
          when ground : @[dut.scala 47:22]
            state <= UInt<1>("h0") @[dut.scala 47:30]
        else :
          node _T_11 = asUInt(UInt<2>("h3")) @[dut.scala 24:19]
          node _T_12 = asUInt(state) @[dut.scala 24:19]
          node _T_13 = eq(_T_11, _T_12) @[dut.scala 24:19]
          when _T_13 : @[dut.scala 24:19]
            when ground : @[dut.scala 51:22]
              state <= UInt<1>("h1") @[dut.scala 51:30]
    node _walk_left_T = eq(state, UInt<1>("h0")) @[dut.scala 55:26]
    walk_left <= _walk_left_T @[dut.scala 55:16]
    node _walk_right_T = eq(state, UInt<1>("h1")) @[dut.scala 56:26]
    walk_right <= _walk_right_T @[dut.scala 56:16]
    node _aaah_T = eq(state, UInt<2>("h2")) @[dut.scala 57:26]
    node _aaah_T_1 = eq(state, UInt<2>("h3")) @[dut.scala 57:56]
    node _aaah_T_2 = or(_aaah_T, _aaah_T_1) @[dut.scala 57:46]
    aaah <= _aaah_T_2 @[dut.scala 57:16]

