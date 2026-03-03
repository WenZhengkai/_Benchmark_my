circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:22]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 18:17]
    node _T_1 = asUInt(state) @[dut.scala 18:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 18:17]
    when _T_2 : @[dut.scala 18:17]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 20:16]
      when _T_3 : @[dut.scala 20:21]
        state <= UInt<1>("h1") @[dut.scala 21:15]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 22:22]
        when _T_4 : @[dut.scala 22:27]
          state <= UInt<2>("h2") @[dut.scala 23:15]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 24:22]
          when _T_5 : @[dut.scala 24:27]
            state <= UInt<2>("h3") @[dut.scala 25:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 27:15]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 18:17]
      node _T_7 = asUInt(state) @[dut.scala 18:17]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 18:17]
      when _T_8 : @[dut.scala 18:17]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 31:16]
        when _T_9 : @[dut.scala 31:21]
          state <= UInt<1>("h1") @[dut.scala 31:29]
        else :
          state <= UInt<1>("h0") @[dut.scala 32:28]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 18:17]
        node _T_11 = asUInt(state) @[dut.scala 18:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 18:17]
        when _T_12 : @[dut.scala 18:17]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 35:16]
          when _T_13 : @[dut.scala 35:21]
            state <= UInt<2>("h2") @[dut.scala 35:29]
          else :
            state <= UInt<1>("h0") @[dut.scala 36:28]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 18:17]
          node _T_15 = asUInt(state) @[dut.scala 18:17]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 18:17]
          when _T_16 : @[dut.scala 18:17]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 39:16]
            when _T_17 : @[dut.scala 39:21]
              state <= UInt<2>("h3") @[dut.scala 39:29]
            else :
              state <= UInt<1>("h0") @[dut.scala 40:28]
    io.g <= UInt<1>("h0") @[dut.scala 45:8]
    node _T_18 = asUInt(UInt<1>("h1")) @[dut.scala 46:17]
    node _T_19 = asUInt(state) @[dut.scala 46:17]
    node _T_20 = eq(_T_18, _T_19) @[dut.scala 46:17]
    when _T_20 : @[dut.scala 46:17]
      io.g <= UInt<1>("h1") @[dut.scala 47:18]
    else :
      node _T_21 = asUInt(UInt<2>("h2")) @[dut.scala 46:17]
      node _T_22 = asUInt(state) @[dut.scala 46:17]
      node _T_23 = eq(_T_21, _T_22) @[dut.scala 46:17]
      when _T_23 : @[dut.scala 46:17]
        io.g <= UInt<2>("h2") @[dut.scala 48:18]
      else :
        node _T_24 = asUInt(UInt<2>("h3")) @[dut.scala 46:17]
        node _T_25 = asUInt(state) @[dut.scala 46:17]
        node _T_26 = eq(_T_24, _T_25) @[dut.scala 46:17]
        when _T_26 : @[dut.scala 46:17]
          io.g <= UInt<3>("h4") @[dut.scala 49:18]


