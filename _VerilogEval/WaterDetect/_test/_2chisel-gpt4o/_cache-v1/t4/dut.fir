circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg prevSensors : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 14:28]
    node resetSignal = bits(reset, 0, 0) @[dut.scala 15:32]
    io.fr3 <= UInt<1>("h0") @[dut.scala 18:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 19:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 20:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 21:10]
    when resetSignal : @[dut.scala 24:21]
      prevSensors <= UInt<1>("h0") @[dut.scala 25:17]
      io.fr3 <= UInt<1>("h1") @[dut.scala 26:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 27:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 28:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 29:12]
    else :
      prevSensors <= io.s @[dut.scala 32:17]
      node _T = eq(UInt<3>("h7"), io.s) @[dut.scala 35:18]
      when _T : @[dut.scala 35:18]
        io.fr3 <= UInt<1>("h0") @[dut.scala 38:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 39:16]
        io.fr1 <= UInt<1>("h0") @[dut.scala 40:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 41:16]
      else :
        node _T_1 = eq(UInt<2>("h3"), io.s) @[dut.scala 35:18]
        when _T_1 : @[dut.scala 35:18]
          io.fr3 <= UInt<1>("h0") @[dut.scala 44:16]
          io.fr2 <= UInt<1>("h0") @[dut.scala 45:16]
          io.fr1 <= UInt<1>("h1") @[dut.scala 46:16]
          node _T_2 = lt(prevSensors, io.s) @[dut.scala 47:26]
          when _T_2 : @[dut.scala 47:34]
            io.dfr <= UInt<1>("h1") @[dut.scala 48:18]
          else :
            io.dfr <= UInt<1>("h0") @[dut.scala 50:18]
        else :
          node _T_3 = eq(UInt<1>("h1"), io.s) @[dut.scala 35:18]
          when _T_3 : @[dut.scala 35:18]
            io.fr3 <= UInt<1>("h0") @[dut.scala 54:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 55:16]
            io.fr1 <= UInt<1>("h1") @[dut.scala 56:16]
            node _T_4 = lt(prevSensors, io.s) @[dut.scala 57:26]
            when _T_4 : @[dut.scala 57:34]
              io.dfr <= UInt<1>("h1") @[dut.scala 58:18]
            else :
              io.dfr <= UInt<1>("h0") @[dut.scala 60:18]
          else :
            node _T_5 = eq(UInt<1>("h0"), io.s) @[dut.scala 35:18]
            when _T_5 : @[dut.scala 35:18]
              io.fr3 <= UInt<1>("h1") @[dut.scala 64:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 65:16]
              io.fr1 <= UInt<1>("h1") @[dut.scala 66:16]
              io.dfr <= UInt<1>("h0") @[dut.scala 67:16]


