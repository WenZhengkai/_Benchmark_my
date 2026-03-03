circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip rst : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire currLevel : UInt<2> @[dut.scala 21:23]
    node _currLevel_T = bits(io.s, 0, 0) @[Bitwise.scala 53:100]
    node _currLevel_T_1 = bits(io.s, 1, 1) @[Bitwise.scala 53:100]
    node _currLevel_T_2 = bits(io.s, 2, 2) @[Bitwise.scala 53:100]
    node _currLevel_T_3 = add(_currLevel_T_1, _currLevel_T_2) @[Bitwise.scala 51:90]
    node _currLevel_T_4 = bits(_currLevel_T_3, 1, 0) @[Bitwise.scala 51:90]
    node _currLevel_T_5 = add(_currLevel_T, _currLevel_T_4) @[Bitwise.scala 51:90]
    node _currLevel_T_6 = bits(_currLevel_T_5, 1, 0) @[Bitwise.scala 51:90]
    currLevel <= _currLevel_T_6 @[dut.scala 22:13]
    reg lastLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 25:34]
    reg prevLevelAtChange : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 26:34]
    wire effectivePrev : UInt<2> @[dut.scala 30:27]
    node _effectivePrev_T = neq(currLevel, lastLevel) @[dut.scala 31:34]
    node _effectivePrev_T_1 = mux(_effectivePrev_T, lastLevel, prevLevelAtChange) @[dut.scala 31:23]
    effectivePrev <= _effectivePrev_T_1 @[dut.scala 31:17]
    when io.rst : @[dut.scala 33:16]
      lastLevel <= UInt<1>("h0") @[dut.scala 36:15]
      prevLevelAtChange <= UInt<1>("h0") @[dut.scala 37:23]
    else :
      node _T = neq(currLevel, lastLevel) @[dut.scala 39:20]
      when _T : @[dut.scala 39:35]
        prevLevelAtChange <= lastLevel @[dut.scala 40:25]
        lastLevel <= currLevel @[dut.scala 41:17]
    io.fr1 <= UInt<1>("h0") @[dut.scala 46:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 47:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 48:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 49:10]
    when io.rst : @[dut.scala 52:16]
      io.fr1 <= UInt<1>("h1") @[dut.scala 54:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 55:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 56:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 57:12]
    else :
      node _T_1 = eq(UInt<2>("h3"), currLevel) @[dut.scala 59:23]
      when _T_1 : @[dut.scala 59:23]
        io.fr1 <= UInt<1>("h0") @[dut.scala 61:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 62:16]
        io.fr3 <= UInt<1>("h0") @[dut.scala 63:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 64:16]
      else :
        node _T_2 = eq(UInt<2>("h2"), currLevel) @[dut.scala 59:23]
        when _T_2 : @[dut.scala 59:23]
          io.fr1 <= UInt<1>("h1") @[dut.scala 67:16]
          io.fr2 <= UInt<1>("h0") @[dut.scala 68:16]
          io.fr3 <= UInt<1>("h0") @[dut.scala 69:16]
          node _io_dfr_T = lt(effectivePrev, currLevel) @[dut.scala 70:33]
          io.dfr <= _io_dfr_T @[dut.scala 70:16]
        else :
          node _T_3 = eq(UInt<1>("h1"), currLevel) @[dut.scala 59:23]
          when _T_3 : @[dut.scala 59:23]
            io.fr1 <= UInt<1>("h1") @[dut.scala 73:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 74:16]
            io.fr3 <= UInt<1>("h0") @[dut.scala 75:16]
            node _io_dfr_T_1 = lt(effectivePrev, currLevel) @[dut.scala 76:33]
            io.dfr <= _io_dfr_T_1 @[dut.scala 76:16]
          else :
            node _T_4 = eq(UInt<1>("h0"), currLevel) @[dut.scala 59:23]
            when _T_4 : @[dut.scala 59:23]
              io.fr1 <= UInt<1>("h1") @[dut.scala 79:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 80:16]
              io.fr3 <= UInt<1>("h1") @[dut.scala 81:16]
              io.dfr <= UInt<1>("h1") @[dut.scala 82:16]


