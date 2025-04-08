circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset_sync : UInt<1>}

    io.fr3 <= UInt<1>("h0") @[dut.scala 15:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 16:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 17:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 18:10]
    reg prevSensors : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 21:28]
    when io.reset_sync : @[dut.scala 24:23]
      io.fr3 <= UInt<1>("h1") @[dut.scala 27:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 28:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 29:12]
      io.dfr <= UInt<1>("h0") @[dut.scala 30:12]
      prevSensors <= UInt<1>("h0") @[dut.scala 31:17]
    else :
      node _T = eq(io.s, UInt<3>("h7")) @[dut.scala 34:15]
      when _T : @[dut.scala 34:29]
        io.fr3 <= UInt<1>("h0") @[dut.scala 35:14]
        io.fr2 <= UInt<1>("h0") @[dut.scala 36:14]
        io.fr1 <= UInt<1>("h0") @[dut.scala 37:14]
        io.dfr <= UInt<1>("h0") @[dut.scala 38:14]
      else :
        node _T_1 = eq(io.s, UInt<2>("h3")) @[dut.scala 39:21]
        when _T_1 : @[dut.scala 39:35]
          io.fr3 <= UInt<1>("h0") @[dut.scala 40:14]
          io.fr2 <= UInt<1>("h0") @[dut.scala 41:14]
          io.fr1 <= UInt<1>("h1") @[dut.scala 42:14]
          io.dfr <= UInt<1>("h0") @[dut.scala 43:14]
        else :
          node _T_2 = eq(io.s, UInt<1>("h1")) @[dut.scala 44:21]
          when _T_2 : @[dut.scala 44:35]
            io.fr3 <= UInt<1>("h0") @[dut.scala 45:14]
            io.fr2 <= UInt<1>("h1") @[dut.scala 46:14]
            io.fr1 <= UInt<1>("h1") @[dut.scala 47:14]
            node _io_dfr_T = lt(prevSensors, io.s) @[dut.scala 48:29]
            io.dfr <= _io_dfr_T @[dut.scala 48:14]
          else :
            node _T_3 = eq(io.s, UInt<1>("h0")) @[dut.scala 49:21]
            when _T_3 : @[dut.scala 49:35]
              io.fr3 <= UInt<1>("h1") @[dut.scala 50:14]
              io.fr2 <= UInt<1>("h1") @[dut.scala 51:14]
              io.fr1 <= UInt<1>("h1") @[dut.scala 52:14]
              io.dfr <= UInt<1>("h0") @[dut.scala 53:14]
      prevSensors <= io.s @[dut.scala 57:17]


