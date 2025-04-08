circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg fr3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:20]
    reg fr2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:20]
    reg fr1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg dfr : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg prev_s : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 18:23]
    io.fr3 <= fr3 @[dut.scala 21:10]
    io.fr2 <= fr2 @[dut.scala 22:10]
    io.fr1 <= fr1 @[dut.scala 23:10]
    io.dfr <= dfr @[dut.scala 24:10]
    node _T = bits(reset, 0, 0) @[dut.scala 27:14]
    when _T : @[dut.scala 27:22]
      fr3 <= UInt<1>("h1") @[dut.scala 29:9]
      fr2 <= UInt<1>("h1") @[dut.scala 30:9]
      fr1 <= UInt<1>("h1") @[dut.scala 31:9]
      dfr <= UInt<1>("h1") @[dut.scala 32:9]
      prev_s <= UInt<1>("h0") @[dut.scala 33:12]
    else :
      node _T_1 = bits(io.s, 2, 2) @[dut.scala 37:14]
      when _T_1 : @[dut.scala 37:19]
        fr3 <= UInt<1>("h0") @[dut.scala 38:11]
        fr2 <= UInt<1>("h0") @[dut.scala 39:11]
        fr1 <= UInt<1>("h0") @[dut.scala 40:11]
      else :
        node _T_2 = bits(io.s, 1, 1) @[dut.scala 41:20]
        when _T_2 : @[dut.scala 41:25]
          fr3 <= UInt<1>("h0") @[dut.scala 42:11]
          fr2 <= UInt<1>("h0") @[dut.scala 43:11]
          fr1 <= UInt<1>("h1") @[dut.scala 44:11]
        else :
          node _T_3 = bits(io.s, 0, 0) @[dut.scala 45:20]
          when _T_3 : @[dut.scala 45:25]
            fr3 <= UInt<1>("h0") @[dut.scala 46:11]
            fr2 <= UInt<1>("h1") @[dut.scala 47:11]
            fr1 <= UInt<1>("h1") @[dut.scala 48:11]
          else :
            fr3 <= UInt<1>("h1") @[dut.scala 50:11]
            fr2 <= UInt<1>("h1") @[dut.scala 51:11]
            fr1 <= UInt<1>("h1") @[dut.scala 52:11]
      node _dfr_T = gt(io.s, prev_s) @[dut.scala 57:17]
      dfr <= _dfr_T @[dut.scala 57:9]
      prev_s <= io.s @[dut.scala 60:12]


