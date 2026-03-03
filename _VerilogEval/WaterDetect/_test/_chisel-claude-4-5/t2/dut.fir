circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<4>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    node s1 = bits(io.s, 1, 1) @[dut.scala 14:16]
    node s2 = bits(io.s, 2, 2) @[dut.scala 15:16]
    node s3 = bits(io.s, 3, 3) @[dut.scala 16:16]
    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 22:22]
    wire currentLevel : UInt<3> @[dut.scala 25:33]
    currentLevel <= UInt<3>("h4") @[dut.scala 25:33]
    node _T = and(s1, s2) @[dut.scala 26:11]
    node _T_1 = and(_T, s3) @[dut.scala 26:17]
    when _T_1 : @[dut.scala 26:24]
      currentLevel <= UInt<3>("h1") @[dut.scala 27:18]
    else :
      node _T_2 = and(s1, s2) @[dut.scala 28:17]
      node _T_3 = eq(s3, UInt<1>("h0")) @[dut.scala 28:26]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 28:23]
      when _T_4 : @[dut.scala 28:31]
        currentLevel <= UInt<3>("h2") @[dut.scala 29:18]
      else :
        node _T_5 = eq(s2, UInt<1>("h0")) @[dut.scala 30:20]
        node _T_6 = and(s1, _T_5) @[dut.scala 30:17]
        node _T_7 = eq(s3, UInt<1>("h0")) @[dut.scala 30:27]
        node _T_8 = and(_T_6, _T_7) @[dut.scala 30:24]
        when _T_8 : @[dut.scala 30:32]
          currentLevel <= UInt<3>("h3") @[dut.scala 31:18]
        else :
          currentLevel <= UInt<3>("h4") @[dut.scala 33:18]
    state <= currentLevel @[dut.scala 37:9]
    wire isRising : UInt<1> @[dut.scala 40:29]
    isRising <= UInt<1>("h0") @[dut.scala 40:29]
    node _T_9 = eq(currentLevel, UInt<3>("h1")) @[dut.scala 42:21]
    when _T_9 : @[dut.scala 42:35]
      node _isRising_T = eq(state, UInt<3>("h2")) @[dut.scala 43:24]
      node _isRising_T_1 = eq(state, UInt<3>("h3")) @[dut.scala 43:52]
      node _isRising_T_2 = or(_isRising_T, _isRising_T_1) @[dut.scala 43:42]
      node _isRising_T_3 = eq(state, UInt<3>("h4")) @[dut.scala 43:80]
      node _isRising_T_4 = or(_isRising_T_2, _isRising_T_3) @[dut.scala 43:70]
      isRising <= _isRising_T_4 @[dut.scala 43:14]
    else :
      node _T_10 = eq(currentLevel, UInt<3>("h2")) @[dut.scala 44:27]
      when _T_10 : @[dut.scala 44:45]
        node _isRising_T_5 = eq(state, UInt<3>("h3")) @[dut.scala 45:24]
        node _isRising_T_6 = eq(state, UInt<3>("h4")) @[dut.scala 45:52]
        node _isRising_T_7 = or(_isRising_T_5, _isRising_T_6) @[dut.scala 45:42]
        isRising <= _isRising_T_7 @[dut.scala 45:14]
      else :
        node _T_11 = eq(currentLevel, UInt<3>("h3")) @[dut.scala 46:27]
        when _T_11 : @[dut.scala 46:45]
          node _isRising_T_8 = eq(state, UInt<3>("h4")) @[dut.scala 47:24]
          isRising <= _isRising_T_8 @[dut.scala 47:14]
        else :
          isRising <= UInt<1>("h0") @[dut.scala 49:14]
    io.fr3 <= UInt<1>("h0") @[dut.scala 53:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 54:10]
    io.fr1 <= UInt<1>("h0") @[dut.scala 55:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 56:10]
    node _T_12 = eq(currentLevel, UInt<3>("h1")) @[dut.scala 59:21]
    when _T_12 : @[dut.scala 59:35]
      io.fr3 <= UInt<1>("h0") @[dut.scala 61:12]
      io.fr2 <= UInt<1>("h0") @[dut.scala 62:12]
      io.fr1 <= UInt<1>("h0") @[dut.scala 63:12]
    else :
      node _T_13 = eq(currentLevel, UInt<3>("h2")) @[dut.scala 64:27]
      when _T_13 : @[dut.scala 64:45]
        io.fr1 <= UInt<1>("h1") @[dut.scala 66:12]
      else :
        node _T_14 = eq(currentLevel, UInt<3>("h3")) @[dut.scala 67:27]
        when _T_14 : @[dut.scala 67:45]
          io.fr1 <= UInt<1>("h1") @[dut.scala 69:12]
          io.fr2 <= UInt<1>("h1") @[dut.scala 70:12]
        else :
          io.fr1 <= UInt<1>("h1") @[dut.scala 73:12]
          io.fr2 <= UInt<1>("h1") @[dut.scala 74:12]
          io.fr3 <= UInt<1>("h1") @[dut.scala 75:12]
    when isRising : @[dut.scala 79:18]
      io.dfr <= UInt<1>("h1") @[dut.scala 80:12]


