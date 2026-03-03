circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<4>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node s1 = bits(io.s, 1, 1) @[dut.scala 14:16]
    node s2 = bits(io.s, 2, 2) @[dut.scala 15:16]
    node s3 = bits(io.s, 3, 3) @[dut.scala 16:16]
    node sensors_hi = cat(s3, s2) @[Cat.scala 33:92]
    node sensors = cat(sensors_hi, s1) @[Cat.scala 33:92]
    reg prevSensors : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 22:28]
    wire currentLevel : UInt<3> @[dut.scala 25:33]
    currentLevel <= UInt<3>("h0") @[dut.scala 25:33]
    node _T = eq(sensors, UInt<3>("h7")) @[dut.scala 26:16]
    when _T : @[dut.scala 26:30]
      currentLevel <= UInt<2>("h3") @[dut.scala 27:18]
    else :
      node _T_1 = eq(sensors, UInt<2>("h3")) @[dut.scala 28:22]
      when _T_1 : @[dut.scala 28:36]
        currentLevel <= UInt<2>("h2") @[dut.scala 29:18]
      else :
        node _T_2 = eq(sensors, UInt<1>("h1")) @[dut.scala 30:22]
        when _T_2 : @[dut.scala 30:36]
          currentLevel <= UInt<1>("h1") @[dut.scala 31:18]
        else :
          currentLevel <= UInt<1>("h0") @[dut.scala 33:18]
    wire prevLevel : UInt<3> @[dut.scala 37:30]
    prevLevel <= UInt<3>("h0") @[dut.scala 37:30]
    node _T_3 = eq(prevSensors, UInt<3>("h7")) @[dut.scala 38:20]
    when _T_3 : @[dut.scala 38:34]
      prevLevel <= UInt<2>("h3") @[dut.scala 39:15]
    else :
      node _T_4 = eq(prevSensors, UInt<2>("h3")) @[dut.scala 40:26]
      when _T_4 : @[dut.scala 40:40]
        prevLevel <= UInt<2>("h2") @[dut.scala 41:15]
      else :
        node _T_5 = eq(prevSensors, UInt<1>("h1")) @[dut.scala 42:26]
        when _T_5 : @[dut.scala 42:40]
          prevLevel <= UInt<1>("h1") @[dut.scala 43:15]
        else :
          prevLevel <= UInt<1>("h0") @[dut.scala 45:15]
    node levelRising = lt(prevLevel, currentLevel) @[dut.scala 49:31]
    wire nominalFr1 : UInt<1> @[dut.scala 52:31]
    nominalFr1 <= UInt<1>("h0") @[dut.scala 52:31]
    wire nominalFr2 : UInt<1> @[dut.scala 53:31]
    nominalFr2 <= UInt<1>("h0") @[dut.scala 53:31]
    wire nominalFr3 : UInt<1> @[dut.scala 54:31]
    nominalFr3 <= UInt<1>("h0") @[dut.scala 54:31]
    node _T_6 = eq(UInt<1>("h0"), currentLevel) @[dut.scala 56:24]
    when _T_6 : @[dut.scala 56:24]
      nominalFr1 <= UInt<1>("h1") @[dut.scala 58:18]
      nominalFr2 <= UInt<1>("h1") @[dut.scala 59:18]
      nominalFr3 <= UInt<1>("h1") @[dut.scala 60:18]
    else :
      node _T_7 = eq(UInt<1>("h1"), currentLevel) @[dut.scala 56:24]
      when _T_7 : @[dut.scala 56:24]
        nominalFr1 <= UInt<1>("h1") @[dut.scala 63:18]
        nominalFr2 <= UInt<1>("h1") @[dut.scala 64:18]
        nominalFr3 <= UInt<1>("h0") @[dut.scala 65:18]
      else :
        node _T_8 = eq(UInt<2>("h2"), currentLevel) @[dut.scala 56:24]
        when _T_8 : @[dut.scala 56:24]
          nominalFr1 <= UInt<1>("h1") @[dut.scala 68:18]
          nominalFr2 <= UInt<1>("h0") @[dut.scala 69:18]
          nominalFr3 <= UInt<1>("h0") @[dut.scala 70:18]
        else :
          node _T_9 = eq(UInt<2>("h3"), currentLevel) @[dut.scala 56:24]
          when _T_9 : @[dut.scala 56:24]
            nominalFr1 <= UInt<1>("h0") @[dut.scala 73:18]
            nominalFr2 <= UInt<1>("h0") @[dut.scala 74:18]
            nominalFr3 <= UInt<1>("h0") @[dut.scala 75:18]
    node _supplementalFlow_T = neq(sensors, prevSensors) @[dut.scala 80:50]
    node supplementalFlow = and(levelRising, _supplementalFlow_T) @[dut.scala 80:38]
    io.fr1 <= nominalFr1 @[dut.scala 83:10]
    io.fr2 <= nominalFr2 @[dut.scala 84:10]
    io.fr3 <= nominalFr3 @[dut.scala 85:10]
    io.dfr <= supplementalFlow @[dut.scala 86:10]
    node _T_10 = bits(reset, 0, 0) @[dut.scala 89:14]
    when _T_10 : @[dut.scala 89:22]
      prevSensors <= UInt<1>("h0") @[dut.scala 90:17]
    else :
      prevSensors <= sensors @[dut.scala 92:17]
    node _T_11 = bits(reset, 0, 0) @[dut.scala 96:14]
    when _T_11 : @[dut.scala 96:22]
      io.fr1 <= UInt<1>("h1") @[dut.scala 97:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 98:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 99:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 100:12]


