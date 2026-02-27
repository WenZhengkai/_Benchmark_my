circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 15:26]
    io.fr3 <= UInt<1>("h0") @[dut.scala 18:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 19:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 20:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 21:10]
    wire currentLevel : UInt<2> @[dut.scala 24:26]
    node _currentLevel_T = eq(io.s, UInt<3>("h7")) @[dut.scala 26:11]
    node _currentLevel_T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 27:11]
    node _currentLevel_T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 28:11]
    node _currentLevel_T_3 = eq(io.s, UInt<1>("h0")) @[dut.scala 29:11]
    node _currentLevel_T_4 = mux(_currentLevel_T_3, UInt<1>("h0"), UInt<1>("h0")) @[Mux.scala 101:16]
    node _currentLevel_T_5 = mux(_currentLevel_T_2, UInt<1>("h1"), _currentLevel_T_4) @[Mux.scala 101:16]
    node _currentLevel_T_6 = mux(_currentLevel_T_1, UInt<2>("h2"), _currentLevel_T_5) @[Mux.scala 101:16]
    node _currentLevel_T_7 = mux(_currentLevel_T, UInt<2>("h3"), _currentLevel_T_6) @[Mux.scala 101:16]
    currentLevel <= _currentLevel_T_7 @[dut.scala 25:16]
    when io.reset : @[dut.scala 33:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 35:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 36:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 37:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 38:12]
      prevLevel <= UInt<1>("h0") @[dut.scala 39:15]
    else :
      node _T = eq(UInt<2>("h3"), currentLevel) @[dut.scala 42:26]
      when _T : @[dut.scala 42:26]
        io.fr3 <= UInt<1>("h0") @[dut.scala 44:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 45:16]
        io.fr1 <= UInt<1>("h0") @[dut.scala 46:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 47:16]
      else :
        node _T_1 = eq(UInt<2>("h2"), currentLevel) @[dut.scala 42:26]
        when _T_1 : @[dut.scala 42:26]
          io.fr3 <= UInt<1>("h0") @[dut.scala 50:16]
          io.fr2 <= UInt<1>("h0") @[dut.scala 51:16]
          io.fr1 <= UInt<1>("h1") @[dut.scala 52:16]
          node _io_dfr_T = lt(prevLevel, currentLevel) @[dut.scala 53:29]
          io.dfr <= _io_dfr_T @[dut.scala 53:16]
        else :
          node _T_2 = eq(UInt<1>("h1"), currentLevel) @[dut.scala 42:26]
          when _T_2 : @[dut.scala 42:26]
            io.fr3 <= UInt<1>("h0") @[dut.scala 56:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 57:16]
            io.fr1 <= UInt<1>("h1") @[dut.scala 58:16]
            node _io_dfr_T_1 = lt(prevLevel, currentLevel) @[dut.scala 59:29]
            io.dfr <= _io_dfr_T_1 @[dut.scala 59:16]
          else :
            node _T_3 = eq(UInt<1>("h0"), currentLevel) @[dut.scala 42:26]
            when _T_3 : @[dut.scala 42:26]
              io.fr3 <= UInt<1>("h1") @[dut.scala 62:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 63:16]
              io.fr1 <= UInt<1>("h1") @[dut.scala 64:16]
              io.dfr <= UInt<1>("h1") @[dut.scala 65:16]
      prevLevel <= currentLevel @[dut.scala 69:15]


