circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    wire currentLevel : UInt<2> @[dut.scala 24:26]
    node s1 = bits(io.s, 0, 0) @[dut.scala 27:16]
    node s2 = bits(io.s, 1, 1) @[dut.scala 28:16]
    node s3 = bits(io.s, 2, 2) @[dut.scala 29:16]
    node _T = eq(s3, UInt<1>("h1")) @[dut.scala 32:11]
    when _T : @[dut.scala 32:20]
      currentLevel <= UInt<2>("h3") @[dut.scala 33:18]
    else :
      node _T_1 = eq(s2, UInt<1>("h1")) @[dut.scala 34:17]
      when _T_1 : @[dut.scala 34:26]
        currentLevel <= UInt<2>("h2") @[dut.scala 35:18]
      else :
        node _T_2 = eq(s1, UInt<1>("h1")) @[dut.scala 36:17]
        when _T_2 : @[dut.scala 36:26]
          currentLevel <= UInt<1>("h1") @[dut.scala 37:18]
        else :
          currentLevel <= UInt<1>("h0") @[dut.scala 39:18]
    when io.reset : @[dut.scala 43:18]
      state <= UInt<1>("h0") @[dut.scala 44:11]
      prevState <= UInt<1>("h0") @[dut.scala 45:15]
    else :
      node _T_3 = neq(state, currentLevel) @[dut.scala 47:16]
      when _T_3 : @[dut.scala 47:34]
        prevState <= state @[dut.scala 48:17]
        state <= currentLevel @[dut.scala 49:13]
    io.fr1 <= UInt<1>("h0") @[dut.scala 55:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 56:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 57:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 58:10]
    node _T_4 = asUInt(UInt<1>("h0")) @[dut.scala 61:17]
    node _T_5 = asUInt(state) @[dut.scala 61:17]
    node _T_6 = eq(_T_4, _T_5) @[dut.scala 61:17]
    when _T_6 : @[dut.scala 61:17]
      io.fr1 <= UInt<1>("h1") @[dut.scala 63:14]
      io.fr2 <= UInt<1>("h1") @[dut.scala 64:14]
      io.fr3 <= UInt<1>("h1") @[dut.scala 65:14]
    else :
      node _T_7 = asUInt(UInt<1>("h1")) @[dut.scala 61:17]
      node _T_8 = asUInt(state) @[dut.scala 61:17]
      node _T_9 = eq(_T_7, _T_8) @[dut.scala 61:17]
      when _T_9 : @[dut.scala 61:17]
        io.fr1 <= UInt<1>("h1") @[dut.scala 68:14]
        io.fr2 <= UInt<1>("h1") @[dut.scala 69:14]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 61:17]
        node _T_11 = asUInt(state) @[dut.scala 61:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 61:17]
        when _T_12 : @[dut.scala 61:17]
          io.fr1 <= UInt<1>("h1") @[dut.scala 72:14]
        else :
          node _T_13 = asUInt(UInt<2>("h3")) @[dut.scala 61:17]
          node _T_14 = asUInt(state) @[dut.scala 61:17]
          node _T_15 = eq(_T_13, _T_14) @[dut.scala 61:17]
          when _T_15 : @[dut.scala 61:17]
            skip
    node _T_16 = lt(prevState, state) @[dut.scala 80:18]
    when _T_16 : @[dut.scala 80:27]
      io.dfr <= UInt<1>("h1") @[dut.scala 81:12]
    when io.reset : @[dut.scala 85:18]
      io.fr1 <= UInt<1>("h1") @[dut.scala 86:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 87:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 88:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 89:12]


