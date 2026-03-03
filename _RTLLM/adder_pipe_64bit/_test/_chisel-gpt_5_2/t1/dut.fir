circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:20]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:20]
    en1 <= io.i_en @[dut.scala 24:7]
    en2 <= en1 @[dut.scala 25:7]
    en3 <= en2 @[dut.scala 26:7]
    en4 <= en3 @[dut.scala 27:7]
    io.o_en <= en4 @[dut.scala 28:11]
    reg a1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a1) @[dut.scala 31:15]
    reg b1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b1) @[dut.scala 32:15]
    reg a2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a2) @[dut.scala 33:15]
    reg b2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b2) @[dut.scala 34:15]
    reg a3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a3) @[dut.scala 35:15]
    reg b3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b3) @[dut.scala 36:15]
    reg a4 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a4) @[dut.scala 37:15]
    reg b4 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b4) @[dut.scala 38:15]
    a1 <= io.adda @[dut.scala 41:6]
    b1 <= io.addb @[dut.scala 41:21]
    a2 <= a1 @[dut.scala 42:6]
    b2 <= b1 @[dut.scala 42:20]
    a3 <= a2 @[dut.scala 43:6]
    b3 <= b2 @[dut.scala 43:20]
    a4 <= a3 @[dut.scala 44:6]
    b4 <= b3 @[dut.scala 44:20]
    reg sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 47:21]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 48:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 49:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 50:21]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 53:19]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:19]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 55:19]
    reg c4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 56:19]
    wire s1 : UInt<17> @[dut.scala 59:16]
    node _s1_T = bits(a1, 15, 0) @[dut.scala 60:11]
    node _s1_T_1 = bits(b1, 15, 0) @[dut.scala 60:24]
    node _s1_T_2 = add(_s1_T, _s1_T_1) @[dut.scala 60:19]
    node _s1_T_3 = add(_s1_T_2, UInt<1>("h0")) @[dut.scala 60:32]
    s1 <= _s1_T_3 @[dut.scala 60:6]
    node _sum0_T = bits(s1, 15, 0) @[dut.scala 61:13]
    sum0 <= _sum0_T @[dut.scala 61:8]
    node _c1_T = bits(s1, 16, 16) @[dut.scala 62:13]
    c1 <= _c1_T @[dut.scala 62:8]
    wire s2 : UInt<17> @[dut.scala 65:16]
    node _s2_T = bits(a2, 31, 16) @[dut.scala 66:11]
    node _s2_T_1 = bits(b2, 31, 16) @[dut.scala 66:25]
    node _s2_T_2 = add(_s2_T, _s2_T_1) @[dut.scala 66:20]
    node _s2_T_3 = add(_s2_T_2, c1) @[dut.scala 66:34]
    s2 <= _s2_T_3 @[dut.scala 66:6]
    node _sum1_T = bits(s2, 15, 0) @[dut.scala 67:13]
    sum1 <= _sum1_T @[dut.scala 67:8]
    node _c2_T = bits(s2, 16, 16) @[dut.scala 68:13]
    c2 <= _c2_T @[dut.scala 68:8]
    wire s3 : UInt<17> @[dut.scala 71:16]
    node _s3_T = bits(a3, 47, 32) @[dut.scala 72:11]
    node _s3_T_1 = bits(b3, 47, 32) @[dut.scala 72:25]
    node _s3_T_2 = add(_s3_T, _s3_T_1) @[dut.scala 72:20]
    node _s3_T_3 = add(_s3_T_2, c2) @[dut.scala 72:34]
    s3 <= _s3_T_3 @[dut.scala 72:6]
    node _sum2_T = bits(s3, 15, 0) @[dut.scala 73:13]
    sum2 <= _sum2_T @[dut.scala 73:8]
    node _c3_T = bits(s3, 16, 16) @[dut.scala 74:13]
    c3 <= _c3_T @[dut.scala 74:8]
    wire s4 : UInt<17> @[dut.scala 77:16]
    node _s4_T = bits(a4, 63, 48) @[dut.scala 78:11]
    node _s4_T_1 = bits(b4, 63, 48) @[dut.scala 78:25]
    node _s4_T_2 = add(_s4_T, _s4_T_1) @[dut.scala 78:20]
    node _s4_T_3 = add(_s4_T_2, c3) @[dut.scala 78:34]
    s4 <= _s4_T_3 @[dut.scala 78:6]
    node _sum3_T = bits(s4, 15, 0) @[dut.scala 79:13]
    sum3 <= _sum3_T @[dut.scala 79:8]
    node _c4_T = bits(s4, 16, 16) @[dut.scala 80:13]
    c4 <= _c4_T @[dut.scala 80:8]
    node io_result_lo = cat(sum1, sum0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(c4, sum3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 82:13]

