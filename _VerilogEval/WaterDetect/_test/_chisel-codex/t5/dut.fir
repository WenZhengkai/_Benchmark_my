circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    wire level : UInt<2> @[dut.scala 16:19]
    node _T = bits(io.s, 2, 2) @[dut.scala 17:12]
    when _T : @[dut.scala 17:17]
      level <= UInt<2>("h3") @[dut.scala 18:11]
    else :
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 19:18]
      when _T_1 : @[dut.scala 19:23]
        level <= UInt<2>("h2") @[dut.scala 20:11]
      else :
        node _T_2 = bits(io.s, 0, 0) @[dut.scala 21:18]
        when _T_2 : @[dut.scala 21:23]
          level <= UInt<1>("h1") @[dut.scala 22:11]
        else :
          level <= UInt<1>("h0") @[dut.scala 24:11]
    reg lastLevel : UInt<2>, clock with :
      reset => (UInt<1>("h0"), lastLevel) @[dut.scala 28:22]
    reg prevLevel : UInt<2>, clock with :
      reset => (UInt<1>("h0"), prevLevel) @[dut.scala 29:22]
    node _T_3 = bits(reset, 0, 0) @[dut.scala 31:14]
    when _T_3 : @[dut.scala 31:22]
      lastLevel <= UInt<1>("h0") @[dut.scala 32:15]
      prevLevel <= UInt<1>("h0") @[dut.scala 33:15]
    else :
      node _T_4 = neq(level, lastLevel) @[dut.scala 35:16]
      when _T_4 : @[dut.scala 35:31]
        prevLevel <= lastLevel @[dut.scala 36:17]
        lastLevel <= level @[dut.scala 37:17]
    node _effectivePrev_T = neq(level, lastLevel) @[dut.scala 42:33]
    node effectivePrev = mux(_effectivePrev_T, lastLevel, prevLevel) @[dut.scala 42:26]
    node fr1Nom = leq(level, UInt<2>("h2")) @[dut.scala 45:22]
    node fr2Nom = leq(level, UInt<1>("h1")) @[dut.scala 46:22]
    node fr3Nom = eq(level, UInt<1>("h0")) @[dut.scala 47:22]
    node dfrMid = lt(effectivePrev, level) @[dut.scala 53:30]
    node _dfrNom_T = eq(level, UInt<1>("h0")) @[dut.scala 54:26]
    node _dfrNom_T_1 = eq(level, UInt<2>("h3")) @[dut.scala 54:53]
    node _dfrNom_T_2 = mux(_dfrNom_T_1, UInt<1>("h0"), dfrMid) @[dut.scala 54:46]
    node dfrNom = mux(_dfrNom_T, UInt<1>("h1"), _dfrNom_T_2) @[dut.scala 54:19]
    node _io_fr1_T = bits(reset, 0, 0) @[dut.scala 57:23]
    node _io_fr1_T_1 = mux(_io_fr1_T, UInt<1>("h1"), fr1Nom) @[dut.scala 57:16]
    io.fr1 <= _io_fr1_T_1 @[dut.scala 57:10]
    node _io_fr2_T = bits(reset, 0, 0) @[dut.scala 58:23]
    node _io_fr2_T_1 = mux(_io_fr2_T, UInt<1>("h1"), fr2Nom) @[dut.scala 58:16]
    io.fr2 <= _io_fr2_T_1 @[dut.scala 58:10]
    node _io_fr3_T = bits(reset, 0, 0) @[dut.scala 59:23]
    node _io_fr3_T_1 = mux(_io_fr3_T, UInt<1>("h1"), fr3Nom) @[dut.scala 59:16]
    io.fr3 <= _io_fr3_T_1 @[dut.scala 59:10]
    node _io_dfr_T = bits(reset, 0, 0) @[dut.scala 60:23]
    node _io_dfr_T_1 = mux(_io_dfr_T, UInt<1>("h1"), dfrNom) @[dut.scala 60:16]
    io.dfr <= _io_dfr_T_1 @[dut.scala 60:10]

