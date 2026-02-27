circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 18:25]
    reg fr3Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 21:23]
    reg fr2Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 22:23]
    reg fr1Reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 23:23]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 24:23]
    io.fr3 <= fr3Reg @[dut.scala 27:10]
    io.fr2 <= fr2Reg @[dut.scala 28:10]
    io.fr1 <= fr1Reg @[dut.scala 29:10]
    io.dfr <= dfrReg @[dut.scala 30:10]
    when io.reset : @[dut.scala 33:18]
      stateReg <= UInt<2>("h3") @[dut.scala 34:14]
      fr3Reg <= UInt<1>("h1") @[dut.scala 35:12]
      fr2Reg <= UInt<1>("h1") @[dut.scala 36:12]
      fr1Reg <= UInt<1>("h1") @[dut.scala 37:12]
      dfrReg <= UInt<1>("h1") @[dut.scala 38:12]
    else :
      node _T = eq(UInt<2>("h0"), stateReg) @[dut.scala 41:22]
      when _T : @[dut.scala 41:22]
        node _T_1 = eq(io.s, UInt<3>("h7")) @[dut.scala 43:19]
        when _T_1 : @[dut.scala 43:33]
          stateReg <= UInt<2>("h0") @[dut.scala 44:20]
        else :
          node _T_2 = eq(io.s, UInt<3>("h6")) @[dut.scala 45:25]
          when _T_2 : @[dut.scala 45:39]
            stateReg <= UInt<2>("h1") @[dut.scala 46:20]
          else :
            stateReg <= UInt<2>("h2") @[dut.scala 48:20]
      else :
        node _T_3 = eq(UInt<2>("h1"), stateReg) @[dut.scala 41:22]
        when _T_3 : @[dut.scala 41:22]
          node _T_4 = eq(io.s, UInt<3>("h7")) @[dut.scala 52:19]
          when _T_4 : @[dut.scala 52:33]
            stateReg <= UInt<2>("h0") @[dut.scala 53:20]
          else :
            node _T_5 = eq(io.s, UInt<3>("h6")) @[dut.scala 54:25]
            when _T_5 : @[dut.scala 54:39]
              stateReg <= UInt<2>("h1") @[dut.scala 55:20]
            else :
              node _T_6 = eq(io.s, UInt<3>("h4")) @[dut.scala 56:25]
              when _T_6 : @[dut.scala 56:39]
                stateReg <= UInt<2>("h2") @[dut.scala 57:20]
              else :
                stateReg <= UInt<2>("h3") @[dut.scala 59:20]
        else :
          node _T_7 = eq(UInt<2>("h2"), stateReg) @[dut.scala 41:22]
          when _T_7 : @[dut.scala 41:22]
            node _T_8 = eq(io.s, UInt<3>("h7")) @[dut.scala 63:19]
            when _T_8 : @[dut.scala 63:33]
              stateReg <= UInt<2>("h0") @[dut.scala 64:20]
            else :
              node _T_9 = eq(io.s, UInt<3>("h6")) @[dut.scala 65:25]
              when _T_9 : @[dut.scala 65:39]
                stateReg <= UInt<2>("h1") @[dut.scala 66:20]
              else :
                node _T_10 = eq(io.s, UInt<3>("h4")) @[dut.scala 67:25]
                when _T_10 : @[dut.scala 67:39]
                  stateReg <= UInt<2>("h2") @[dut.scala 68:20]
                else :
                  stateReg <= UInt<2>("h3") @[dut.scala 70:20]
          else :
            node _T_11 = eq(UInt<2>("h3"), stateReg) @[dut.scala 41:22]
            when _T_11 : @[dut.scala 41:22]
              node _T_12 = eq(io.s, UInt<3>("h7")) @[dut.scala 74:19]
              when _T_12 : @[dut.scala 74:33]
                stateReg <= UInt<2>("h0") @[dut.scala 75:20]
              else :
                node _T_13 = eq(io.s, UInt<3>("h6")) @[dut.scala 76:25]
                when _T_13 : @[dut.scala 76:39]
                  stateReg <= UInt<2>("h1") @[dut.scala 77:20]
                else :
                  node _T_14 = eq(io.s, UInt<3>("h4")) @[dut.scala 78:25]
                  when _T_14 : @[dut.scala 78:39]
                    stateReg <= UInt<2>("h2") @[dut.scala 79:20]
                  else :
                    stateReg <= UInt<2>("h3") @[dut.scala 81:20]
      node _T_15 = eq(UInt<2>("h0"), stateReg) @[dut.scala 87:22]
      when _T_15 : @[dut.scala 87:22]
        fr3Reg <= UInt<1>("h0") @[dut.scala 89:16]
        fr2Reg <= UInt<1>("h0") @[dut.scala 90:16]
        fr1Reg <= UInt<1>("h0") @[dut.scala 91:16]
        dfrReg <= UInt<1>("h0") @[dut.scala 92:16]
      else :
        node _T_16 = eq(UInt<2>("h1"), stateReg) @[dut.scala 87:22]
        when _T_16 : @[dut.scala 87:22]
          fr3Reg <= UInt<1>("h0") @[dut.scala 95:16]
          fr2Reg <= UInt<1>("h0") @[dut.scala 96:16]
          fr1Reg <= UInt<1>("h1") @[dut.scala 97:16]
          dfrReg <= UInt<1>("h0") @[dut.scala 98:16]
        else :
          node _T_17 = eq(UInt<2>("h2"), stateReg) @[dut.scala 87:22]
          when _T_17 : @[dut.scala 87:22]
            fr3Reg <= UInt<1>("h0") @[dut.scala 101:16]
            fr2Reg <= UInt<1>("h1") @[dut.scala 102:16]
            fr1Reg <= UInt<1>("h1") @[dut.scala 103:16]
            dfrReg <= UInt<1>("h0") @[dut.scala 104:16]
          else :
            node _T_18 = eq(UInt<2>("h3"), stateReg) @[dut.scala 87:22]
            when _T_18 : @[dut.scala 87:22]
              fr3Reg <= UInt<1>("h1") @[dut.scala 107:16]
              fr2Reg <= UInt<1>("h1") @[dut.scala 108:16]
              fr1Reg <= UInt<1>("h1") @[dut.scala 109:16]
              dfrReg <= UInt<1>("h1") @[dut.scala 110:16]
      node _T_19 = eq(stateReg, UInt<2>("h1")) @[dut.scala 115:19]
      node _T_20 = eq(stateReg, UInt<2>("h2")) @[dut.scala 115:47]
      node _T_21 = or(_T_19, _T_20) @[dut.scala 115:35]
      when _T_21 : @[dut.scala 115:64]
        node _T_22 = eq(io.s, UInt<3>("h7")) @[dut.scala 116:17]
        node _T_23 = eq(io.s, UInt<3>("h6")) @[dut.scala 116:38]
        node _T_24 = or(_T_22, _T_23) @[dut.scala 116:30]
        node _T_25 = eq(io.s, UInt<3>("h4")) @[dut.scala 116:59]
        node _T_26 = or(_T_24, _T_25) @[dut.scala 116:51]
        when _T_26 : @[dut.scala 116:73]
          dfrReg <= UInt<1>("h1") @[dut.scala 117:16]
        else :
          dfrReg <= UInt<1>("h0") @[dut.scala 119:16]
      else :
        dfrReg <= UInt<1>("h0") @[dut.scala 122:14]


