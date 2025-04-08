circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevS : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 15:22]
    io.fr3 <= UInt<1>("h0") @[dut.scala 18:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 19:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 20:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 21:10]
    when io.reset : @[dut.scala 24:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 25:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 26:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 27:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 28:12]
    else :
      node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 31:15]
      when _T : @[dut.scala 31:29]
        io.fr3 <= UInt<1>("h0") @[dut.scala 33:14]
        io.fr2 <= UInt<1>("h0") @[dut.scala 34:14]
        io.fr1 <= UInt<1>("h0") @[dut.scala 35:14]
        io.dfr <= UInt<1>("h0") @[dut.scala 36:14]
      else :
        node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 37:21]
        when _T_1 : @[dut.scala 37:35]
          io.fr3 <= UInt<1>("h0") @[dut.scala 39:14]
          io.fr2 <= UInt<1>("h0") @[dut.scala 40:14]
          io.fr1 <= UInt<1>("h1") @[dut.scala 41:14]
          node _io_dfr_T = lt(prevS, io.s) @[dut.scala 43:23]
          io.dfr <= _io_dfr_T @[dut.scala 43:14]
        else :
          node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 44:21]
          when _T_2 : @[dut.scala 44:35]
            io.fr3 <= UInt<1>("h0") @[dut.scala 46:14]
            io.fr2 <= UInt<1>("h1") @[dut.scala 47:14]
            io.fr1 <= UInt<1>("h1") @[dut.scala 48:14]
            node _io_dfr_T_1 = lt(prevS, io.s) @[dut.scala 50:23]
            io.dfr <= _io_dfr_T_1 @[dut.scala 50:14]
          else :
            node _T_3 = eq(io.s, UInt<1>("h0")) @[dut.scala 51:21]
            when _T_3 : @[dut.scala 51:35]
              io.fr3 <= UInt<1>("h1") @[dut.scala 53:14]
              io.fr2 <= UInt<1>("h1") @[dut.scala 54:14]
              io.fr1 <= UInt<1>("h1") @[dut.scala 55:14]
              io.dfr <= UInt<1>("h1") @[dut.scala 57:14]
    prevS <= io.s @[dut.scala 62:9]

