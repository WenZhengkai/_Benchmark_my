circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr1 : UInt<1>, fr2 : UInt<1>, fr3 : UInt<1>, dfr : UInt<1>}

    io.fr1 <= UInt<1>("h0") @[dut.scala 21:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 22:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 23:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 24:10]
    reg prevLevel : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 27:26]
    when io.reset : @[dut.scala 28:18]
      prevLevel <= UInt<1>("h0") @[dut.scala 30:15]
      io.fr1 <= UInt<1>("h1") @[dut.scala 31:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 32:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 33:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 34:12]
    else :
      prevLevel <= io.s @[dut.scala 37:15]
      node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 40:15]
      when _T : @[dut.scala 40:29]
        io.fr1 <= UInt<1>("h0") @[dut.scala 42:14]
        io.fr2 <= UInt<1>("h0") @[dut.scala 43:14]
        io.fr3 <= UInt<1>("h0") @[dut.scala 44:14]
        io.dfr <= UInt<1>("h0") @[dut.scala 45:14]
      else :
        node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 46:22]
        when _T_1 : @[dut.scala 46:36]
          io.fr1 <= UInt<1>("h1") @[dut.scala 48:14]
          io.fr2 <= UInt<1>("h0") @[dut.scala 49:14]
          io.fr3 <= UInt<1>("h0") @[dut.scala 50:14]
          node _io_dfr_T = eq(prevLevel, UInt<1>("h1")) @[dut.scala 51:28]
          node _io_dfr_T_1 = eq(prevLevel, UInt<1>("h0")) @[dut.scala 51:54]
          node _io_dfr_T_2 = or(_io_dfr_T, _io_dfr_T_1) @[dut.scala 51:41]
          io.dfr <= _io_dfr_T_2 @[dut.scala 51:14]
        else :
          node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 52:22]
          when _T_2 : @[dut.scala 52:36]
            io.fr1 <= UInt<1>("h1") @[dut.scala 54:14]
            io.fr2 <= UInt<1>("h1") @[dut.scala 55:14]
            io.fr3 <= UInt<1>("h0") @[dut.scala 56:14]
            node _io_dfr_T_3 = eq(prevLevel, UInt<1>("h0")) @[dut.scala 57:28]
            io.dfr <= _io_dfr_T_3 @[dut.scala 57:14]
          else :
            node _T_3 = eq(io.s, UInt<1>("h0")) @[dut.scala 58:22]
            when _T_3 : @[dut.scala 58:36]
              io.fr1 <= UInt<1>("h1") @[dut.scala 60:14]
              io.fr2 <= UInt<1>("h1") @[dut.scala 61:14]
              io.fr3 <= UInt<1>("h1") @[dut.scala 62:14]
              io.dfr <= UInt<1>("h1") @[dut.scala 63:14]


