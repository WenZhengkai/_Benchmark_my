circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip rst : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire level : UInt<2> @[dut.scala 18:19]
    node _T = bits(io.s, 2, 2) @[dut.scala 19:12]
    when _T : @[dut.scala 19:17]
      level <= UInt<2>("h3") @[dut.scala 20:11]
    else :
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 21:18]
      when _T_1 : @[dut.scala 21:23]
        level <= UInt<2>("h2") @[dut.scala 22:11]
      else :
        node _T_2 = bits(io.s, 0, 0) @[dut.scala 23:18]
        when _T_2 : @[dut.scala 23:23]
          level <= UInt<1>("h1") @[dut.scala 24:11]
        else :
          level <= UInt<1>("h0") @[dut.scala 26:11]
    reg lastLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 30:32]
    reg lastChangeWasUp : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:32]
    when io.rst : @[dut.scala 34:16]
      lastLevel <= UInt<1>("h0") @[dut.scala 35:21]
      lastChangeWasUp <= UInt<1>("h0") @[dut.scala 36:21]
    else :
      node _T_3 = neq(level, lastLevel) @[dut.scala 37:20]
      when _T_3 : @[dut.scala 37:35]
        node _lastChangeWasUp_T = gt(level, lastLevel) @[dut.scala 38:30]
        lastChangeWasUp <= _lastChangeWasUp_T @[dut.scala 38:21]
        lastLevel <= level @[dut.scala 39:21]
    io.fr1 <= UInt<1>("h0") @[dut.scala 43:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 44:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 45:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 46:10]
    when io.rst : @[dut.scala 49:16]
      io.fr1 <= UInt<1>("h1") @[dut.scala 50:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 51:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 52:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 53:12]
    else :
      node _T_4 = eq(UInt<2>("h3"), level) @[dut.scala 55:19]
      when _T_4 : @[dut.scala 55:19]
        io.fr1 <= UInt<1>("h0") @[dut.scala 57:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 58:16]
        io.fr3 <= UInt<1>("h0") @[dut.scala 59:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 60:16]
      else :
        node _T_5 = eq(UInt<2>("h2"), level) @[dut.scala 55:19]
        when _T_5 : @[dut.scala 55:19]
          io.fr1 <= UInt<1>("h1") @[dut.scala 63:16]
          io.fr2 <= UInt<1>("h0") @[dut.scala 64:16]
          io.fr3 <= UInt<1>("h0") @[dut.scala 65:16]
          io.dfr <= lastChangeWasUp @[dut.scala 66:16]
        else :
          node _T_6 = eq(UInt<1>("h1"), level) @[dut.scala 55:19]
          when _T_6 : @[dut.scala 55:19]
            io.fr1 <= UInt<1>("h1") @[dut.scala 69:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 70:16]
            io.fr3 <= UInt<1>("h0") @[dut.scala 71:16]
            io.dfr <= lastChangeWasUp @[dut.scala 72:16]
          else :
            node _T_7 = eq(UInt<1>("h0"), level) @[dut.scala 55:19]
            when _T_7 : @[dut.scala 55:19]
              io.fr1 <= UInt<1>("h1") @[dut.scala 75:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 76:16]
              io.fr3 <= UInt<1>("h1") @[dut.scala 77:16]
              io.dfr <= UInt<1>("h1") @[dut.scala 78:16]


