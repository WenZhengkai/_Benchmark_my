circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip rst : UInt<1>}

    node s1 = bits(io.s, 0, 0) @[dut.scala 18:16]
    node s2 = bits(io.s, 1, 1) @[dut.scala 19:16]
    node s3 = bits(io.s, 2, 2) @[dut.scala 20:16]
    wire level : UInt<2> @[dut.scala 27:19]
    when s3 : @[dut.scala 28:12]
      level <= UInt<2>("h3") @[dut.scala 29:11]
    else :
      when s2 : @[dut.scala 30:18]
        level <= UInt<2>("h2") @[dut.scala 31:11]
      else :
        when s1 : @[dut.scala 32:18]
          level <= UInt<1>("h1") @[dut.scala 33:11]
        else :
          level <= UInt<1>("h0") @[dut.scala 35:11]
    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 40:26]
    node rising = gt(level, prevLevel) @[dut.scala 41:25]
    when io.rst : @[dut.scala 44:16]
      prevLevel <= UInt<1>("h0") @[dut.scala 45:15]
    else :
      prevLevel <= level @[dut.scala 47:15]
    wire n_fr1 : UInt<1> @[dut.scala 51:26]
    n_fr1 <= UInt<1>("h0") @[dut.scala 51:26]
    wire n_fr2 : UInt<1> @[dut.scala 52:26]
    n_fr2 <= UInt<1>("h0") @[dut.scala 52:26]
    wire n_fr3 : UInt<1> @[dut.scala 53:26]
    n_fr3 <= UInt<1>("h0") @[dut.scala 53:26]
    node _T = eq(UInt<2>("h3"), level) @[dut.scala 55:17]
    when _T : @[dut.scala 55:17]
      n_fr1 <= UInt<1>("h0") @[dut.scala 57:13]
      n_fr2 <= UInt<1>("h0") @[dut.scala 57:31]
      n_fr3 <= UInt<1>("h0") @[dut.scala 57:49]
    else :
      node _T_1 = eq(UInt<2>("h2"), level) @[dut.scala 55:17]
      when _T_1 : @[dut.scala 55:17]
        n_fr1 <= UInt<1>("h1") @[dut.scala 60:13]
        n_fr2 <= UInt<1>("h0") @[dut.scala 60:31]
        n_fr3 <= UInt<1>("h0") @[dut.scala 60:49]
      else :
        node _T_2 = eq(UInt<1>("h1"), level) @[dut.scala 55:17]
        when _T_2 : @[dut.scala 55:17]
          n_fr1 <= UInt<1>("h1") @[dut.scala 63:13]
          n_fr2 <= UInt<1>("h1") @[dut.scala 63:31]
          n_fr3 <= UInt<1>("h0") @[dut.scala 63:49]
        else :
          node _T_3 = eq(UInt<1>("h0"), level) @[dut.scala 55:17]
          when _T_3 : @[dut.scala 55:17]
            n_fr1 <= UInt<1>("h1") @[dut.scala 66:13]
            n_fr2 <= UInt<1>("h1") @[dut.scala 66:31]
            n_fr3 <= UInt<1>("h1") @[dut.scala 66:49]
    when io.rst : @[dut.scala 72:16]
      io.fr1 <= UInt<1>("h1") @[dut.scala 73:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 74:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 75:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 76:12]
    else :
      io.fr1 <= n_fr1 @[dut.scala 78:12]
      io.fr2 <= n_fr2 @[dut.scala 79:12]
      io.fr3 <= n_fr3 @[dut.scala 80:12]
      io.dfr <= rising @[dut.scala 81:12]


