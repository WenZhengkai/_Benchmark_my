circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire levelNow : UInt<2> @[dut.scala 41:22]
    node _levelNow_T = eq(UInt<3>("h7"), io.s) @[Mux.scala 81:61]
    node _levelNow_T_1 = mux(_levelNow_T, UInt<2>("h0"), UInt<2>("h3")) @[Mux.scala 81:58]
    node _levelNow_T_2 = eq(UInt<2>("h3"), io.s) @[Mux.scala 81:61]
    node _levelNow_T_3 = mux(_levelNow_T_2, UInt<2>("h1"), _levelNow_T_1) @[Mux.scala 81:58]
    node _levelNow_T_4 = eq(UInt<1>("h1"), io.s) @[Mux.scala 81:61]
    node _levelNow_T_5 = mux(_levelNow_T_4, UInt<2>("h2"), _levelNow_T_3) @[Mux.scala 81:58]
    node _levelNow_T_6 = eq(UInt<1>("h0"), io.s) @[Mux.scala 81:61]
    node _levelNow_T_7 = mux(_levelNow_T_6, UInt<2>("h3"), _levelNow_T_5) @[Mux.scala 81:58]
    levelNow <= _levelNow_T_7 @[dut.scala 42:12]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 50:26]
    wire sensorChanged : UInt<1> @[dut.scala 52:27]
    node _sensorChanged_T = neq(levelNow, prevLevel) @[dut.scala 53:29]
    sensorChanged <= _sensorChanged_T @[dut.scala 53:17]
    node _rising_T = lt(levelNow, prevLevel) @[dut.scala 56:43]
    node rising = and(sensorChanged, _rising_T) @[dut.scala 56:30]
    when io.reset : @[dut.scala 59:19]
      prevLevel <= UInt<2>("h3") @[dut.scala 60:15]
    else :
      when sensorChanged : @[dut.scala 61:31]
        prevLevel <= levelNow @[dut.scala 62:15]
    wire n_fr1 : UInt<1> @[dut.scala 66:26]
    n_fr1 <= UInt<1>("h0") @[dut.scala 66:26]
    wire n_fr2 : UInt<1> @[dut.scala 67:26]
    n_fr2 <= UInt<1>("h0") @[dut.scala 67:26]
    wire n_fr3 : UInt<1> @[dut.scala 68:26]
    n_fr3 <= UInt<1>("h0") @[dut.scala 68:26]
    node _T = eq(UInt<2>("h0"), levelNow) @[dut.scala 70:20]
    when _T : @[dut.scala 70:20]
      n_fr1 <= UInt<1>("h0") @[dut.scala 72:13]
      n_fr2 <= UInt<1>("h0") @[dut.scala 72:31]
      n_fr3 <= UInt<1>("h0") @[dut.scala 72:49]
    else :
      node _T_1 = eq(UInt<2>("h1"), levelNow) @[dut.scala 70:20]
      when _T_1 : @[dut.scala 70:20]
        n_fr1 <= UInt<1>("h1") @[dut.scala 75:13]
        n_fr2 <= UInt<1>("h0") @[dut.scala 75:31]
        n_fr3 <= UInt<1>("h0") @[dut.scala 75:49]
      else :
        node _T_2 = eq(UInt<2>("h2"), levelNow) @[dut.scala 70:20]
        when _T_2 : @[dut.scala 70:20]
          n_fr1 <= UInt<1>("h1") @[dut.scala 78:13]
          n_fr2 <= UInt<1>("h1") @[dut.scala 78:31]
          n_fr3 <= UInt<1>("h0") @[dut.scala 78:49]
        else :
          node _T_3 = eq(UInt<2>("h3"), levelNow) @[dut.scala 70:20]
          when _T_3 : @[dut.scala 70:20]
            n_fr1 <= UInt<1>("h1") @[dut.scala 81:13]
            n_fr2 <= UInt<1>("h1") @[dut.scala 81:31]
            n_fr3 <= UInt<1>("h1") @[dut.scala 81:49]
    reg dfrReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 87:23]
    when io.reset : @[dut.scala 88:19]
      dfrReg <= UInt<1>("h1") @[dut.scala 89:12]
    else :
      when sensorChanged : @[dut.scala 90:31]
        dfrReg <= rising @[dut.scala 91:12]
    node _io_fr1_T = mux(io.reset, UInt<1>("h1"), n_fr1) @[dut.scala 95:16]
    io.fr1 <= _io_fr1_T @[dut.scala 95:10]
    node _io_fr2_T = mux(io.reset, UInt<1>("h1"), n_fr2) @[dut.scala 96:16]
    io.fr2 <= _io_fr2_T @[dut.scala 96:10]
    node _io_fr3_T = mux(io.reset, UInt<1>("h1"), n_fr3) @[dut.scala 97:16]
    io.fr3 <= _io_fr3_T @[dut.scala 97:10]
    io.dfr <= dfrReg @[dut.scala 98:10]

