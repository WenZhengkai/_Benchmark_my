circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 20:22]
    reg prev_state : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 21:27]
    io.fr3 <= UInt<1>("h0") @[dut.scala 24:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 25:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 26:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 27:10]
    node _T = eq(UInt<2>("h3"), state) @[dut.scala 30:17]
    when _T : @[dut.scala 30:17]
      io.fr3 <= UInt<1>("h0") @[dut.scala 33:14]
      io.fr2 <= UInt<1>("h0") @[dut.scala 34:14]
      io.fr1 <= UInt<1>("h0") @[dut.scala 35:14]
      io.dfr <= UInt<1>("h0") @[dut.scala 36:14]
      node _T_1 = eq(io.s, UInt<3>("h7")) @[dut.scala 37:17]
      when _T_1 : @[dut.scala 37:31]
        state <= UInt<2>("h3") @[dut.scala 38:15]
      else :
        node _T_2 = eq(io.s, UInt<2>("h3")) @[dut.scala 39:23]
        when _T_2 : @[dut.scala 39:37]
          prev_state <= state @[dut.scala 40:20]
          state <= UInt<2>("h2") @[dut.scala 41:15]
    else :
      node _T_3 = eq(UInt<2>("h2"), state) @[dut.scala 30:17]
      when _T_3 : @[dut.scala 30:17]
        io.fr3 <= UInt<1>("h0") @[dut.scala 46:14]
        io.fr2 <= UInt<1>("h0") @[dut.scala 47:14]
        io.fr1 <= UInt<1>("h1") @[dut.scala 48:14]
        node _io_dfr_T = eq(prev_state, UInt<2>("h1")) @[dut.scala 49:28]
        io.dfr <= _io_dfr_T @[dut.scala 49:14]
        node _T_4 = eq(io.s, UInt<2>("h3")) @[dut.scala 50:17]
        when _T_4 : @[dut.scala 50:31]
          state <= UInt<2>("h2") @[dut.scala 51:15]
        else :
          node _T_5 = eq(io.s, UInt<1>("h1")) @[dut.scala 52:23]
          when _T_5 : @[dut.scala 52:37]
            prev_state <= state @[dut.scala 53:20]
            state <= UInt<2>("h1") @[dut.scala 54:15]
          else :
            node _T_6 = eq(io.s, UInt<3>("h7")) @[dut.scala 55:23]
            when _T_6 : @[dut.scala 55:37]
              prev_state <= state @[dut.scala 56:20]
              state <= UInt<2>("h3") @[dut.scala 57:15]
      else :
        node _T_7 = eq(UInt<2>("h1"), state) @[dut.scala 30:17]
        when _T_7 : @[dut.scala 30:17]
          io.fr3 <= UInt<1>("h0") @[dut.scala 62:14]
          io.fr2 <= UInt<1>("h1") @[dut.scala 63:14]
          io.fr1 <= UInt<1>("h1") @[dut.scala 64:14]
          node _io_dfr_T_1 = eq(prev_state, UInt<2>("h0")) @[dut.scala 65:28]
          io.dfr <= _io_dfr_T_1 @[dut.scala 65:14]
          node _T_8 = eq(io.s, UInt<1>("h1")) @[dut.scala 66:17]
          when _T_8 : @[dut.scala 66:31]
            state <= UInt<2>("h1") @[dut.scala 67:15]
          else :
            node _T_9 = eq(io.s, UInt<2>("h3")) @[dut.scala 68:23]
            when _T_9 : @[dut.scala 68:37]
              prev_state <= state @[dut.scala 69:20]
              state <= UInt<2>("h2") @[dut.scala 70:15]
            else :
              node _T_10 = eq(io.s, UInt<1>("h0")) @[dut.scala 71:23]
              when _T_10 : @[dut.scala 71:37]
                prev_state <= state @[dut.scala 72:20]
                state <= UInt<2>("h0") @[dut.scala 73:15]
        else :
          node _T_11 = eq(UInt<2>("h0"), state) @[dut.scala 30:17]
          when _T_11 : @[dut.scala 30:17]
            io.fr3 <= UInt<1>("h1") @[dut.scala 78:14]
            io.fr2 <= UInt<1>("h1") @[dut.scala 79:14]
            io.fr1 <= UInt<1>("h1") @[dut.scala 80:14]
            io.dfr <= UInt<1>("h1") @[dut.scala 81:14]
            node _T_12 = eq(io.s, UInt<1>("h0")) @[dut.scala 82:17]
            when _T_12 : @[dut.scala 82:31]
              state <= UInt<2>("h0") @[dut.scala 83:15]
            else :
              node _T_13 = eq(io.s, UInt<1>("h1")) @[dut.scala 84:23]
              when _T_13 : @[dut.scala 84:37]
                prev_state <= state @[dut.scala 85:20]
                state <= UInt<2>("h1") @[dut.scala 86:15]
    node _T_14 = bits(reset, 0, 0) @[dut.scala 92:20]
    when _T_14 : @[dut.scala 92:24]
      state <= UInt<2>("h0") @[dut.scala 93:11]
      prev_state <= UInt<2>("h0") @[dut.scala 94:16]
      io.fr3 <= UInt<1>("h1") @[dut.scala 95:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 96:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 97:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 98:12]


