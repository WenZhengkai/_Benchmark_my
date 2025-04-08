circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevSensorState : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 15:32]
    io.fr3 <= UInt<1>("h0") @[dut.scala 18:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 19:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 20:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 21:10]
    when io.reset : @[dut.scala 24:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 25:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 26:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 27:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 28:12]
      prevSensorState <= UInt<1>("h0") @[dut.scala 29:21]
    else :
      node s1 = bits(io.s, 0, 0) @[dut.scala 32:18]
      node s2 = bits(io.s, 1, 1) @[dut.scala 33:18]
      node s3 = bits(io.s, 2, 2) @[dut.scala 34:18]
      node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 36:18]
      when _T : @[dut.scala 36:18]
        skip
      else :
        node _T_1 = eq(UInt<2>("h3"), io.s) @[dut.scala 36:18]
        when _T_1 : @[dut.scala 36:18]
          io.fr1 <= UInt<1>("h1") @[dut.scala 41:16]
        else :
          node _T_2 = eq(UInt<1>("h1"), io.s) @[dut.scala 36:18]
          when _T_2 : @[dut.scala 36:18]
            io.fr1 <= UInt<1>("h1") @[dut.scala 44:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 45:16]
          else :
            node _T_3 = eq(UInt<1>("h0"), io.s) @[dut.scala 36:18]
            when _T_3 : @[dut.scala 36:18]
              io.fr1 <= UInt<1>("h1") @[dut.scala 48:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 49:16]
              io.fr3 <= UInt<1>("h1") @[dut.scala 50:16]
      node _io_dfr_T = lt(prevSensorState, io.s) @[dut.scala 55:31]
      io.dfr <= _io_dfr_T @[dut.scala 55:12]
      prevSensorState <= io.s @[dut.scala 56:21]


