circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 15:22]
    reg prevState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:26]
    io.fr3 <= UInt<1>("h0") @[dut.scala 25:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 26:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 27:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 28:10]
    when io.reset : @[dut.scala 31:18]
      state <= UInt<2>("h3") @[dut.scala 32:11]
      prevState <= UInt<2>("h3") @[dut.scala 33:15]
      io.fr3 <= UInt<1>("h1") @[dut.scala 34:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 35:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 36:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 37:12]
    else :
      prevState <= state @[dut.scala 40:15]
      node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 43:18]
      when _T : @[dut.scala 43:18]
        state <= UInt<2>("h0") @[dut.scala 44:28]
      else :
        node _T_1 = eq(UInt<3>("h6"), io.s) @[dut.scala 43:18]
        when _T_1 : @[dut.scala 43:18]
          state <= UInt<2>("h1") @[dut.scala 45:28]
        else :
          node _T_2 = eq(UInt<3>("h4"), io.s) @[dut.scala 43:18]
          when _T_2 : @[dut.scala 43:18]
            state <= UInt<2>("h2") @[dut.scala 46:28]
          else :
            node _T_3 = eq(UInt<1>("h0"), io.s) @[dut.scala 43:18]
            when _T_3 : @[dut.scala 43:18]
              state <= UInt<2>("h3") @[dut.scala 47:28]
      node _T_4 = eq(UInt<2>("h0"), state) @[dut.scala 51:19]
      when _T_4 : @[dut.scala 51:19]
        io.fr3 <= UInt<1>("h0") @[dut.scala 53:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 54:16]
        io.fr1 <= UInt<1>("h0") @[dut.scala 55:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 56:16]
      else :
        node _T_5 = eq(UInt<2>("h1"), state) @[dut.scala 51:19]
        when _T_5 : @[dut.scala 51:19]
          io.fr3 <= UInt<1>("h0") @[dut.scala 59:16]
          io.fr2 <= UInt<1>("h0") @[dut.scala 60:16]
          io.fr1 <= UInt<1>("h1") @[dut.scala 61:16]
          node _io_dfr_T = lt(prevState, state) @[dut.scala 62:30]
          io.dfr <= _io_dfr_T @[dut.scala 62:16]
        else :
          node _T_6 = eq(UInt<2>("h2"), state) @[dut.scala 51:19]
          when _T_6 : @[dut.scala 51:19]
            io.fr3 <= UInt<1>("h0") @[dut.scala 65:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 66:16]
            io.fr1 <= UInt<1>("h1") @[dut.scala 67:16]
            node _io_dfr_T_1 = lt(prevState, state) @[dut.scala 68:30]
            io.dfr <= _io_dfr_T_1 @[dut.scala 68:16]
          else :
            node _T_7 = eq(UInt<2>("h3"), state) @[dut.scala 51:19]
            when _T_7 : @[dut.scala 51:19]
              io.fr3 <= UInt<1>("h1") @[dut.scala 71:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 72:16]
              io.fr1 <= UInt<1>("h1") @[dut.scala 73:16]
              io.dfr <= UInt<1>("h1") @[dut.scala 74:16]


