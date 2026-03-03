circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:20]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    en1 <= io.i_en @[dut.scala 21:7]
    en2 <= en1 @[dut.scala 22:7]
    en3 <= en2 @[dut.scala 23:7]
    en4 <= en3 @[dut.scala 24:7]
    reg a_d1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_d1) @[dut.scala 29:17]
    reg a_d2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_d2) @[dut.scala 30:17]
    reg a_d3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_d3) @[dut.scala 31:17]
    reg b_d1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_d1) @[dut.scala 32:17]
    reg b_d2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_d2) @[dut.scala 33:17]
    reg b_d3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_d3) @[dut.scala 34:17]
    a_d1 <= io.adda @[dut.scala 36:8]
    a_d2 <= a_d1 @[dut.scala 37:8]
    a_d3 <= a_d2 @[dut.scala 38:8]
    b_d1 <= io.addb @[dut.scala 40:8]
    b_d2 <= b_d1 @[dut.scala 41:8]
    b_d3 <= b_d2 @[dut.scala 42:8]
    reg sum0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 47:21]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 48:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 49:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 50:21]
    reg c0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 52:19]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 53:19]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:19]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 55:19]
    reg sum0_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 58:24]
    reg sum0_d2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 59:24]
    reg sum0_d3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 60:24]
    reg sum1_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 62:24]
    reg sum1_d2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:24]
    reg sum2_d1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 65:24]
    when io.i_en : @[dut.scala 70:17]
      node _t0_T = bits(io.adda, 15, 0) @[dut.scala 71:21]
      node _t0_T_1 = bits(io.addb, 15, 0) @[dut.scala 71:39]
      node t0 = add(_t0_T, _t0_T_1) @[dut.scala 71:29]
      node _sum0_T = bits(t0, 15, 0) @[dut.scala 72:15]
      sum0 <= _sum0_T @[dut.scala 72:10]
      node _c0_T = bits(t0, 16, 16) @[dut.scala 73:13]
      c0 <= _c0_T @[dut.scala 73:8]
    when en1 : @[dut.scala 79:13]
      node _t1_T = bits(a_d1, 31, 16) @[dut.scala 80:18]
      node _t1_T_1 = bits(b_d1, 31, 16) @[dut.scala 80:34]
      node _t1_T_2 = add(_t1_T, _t1_T_1) @[dut.scala 80:27]
      node t1 = add(_t1_T_2, c0) @[dut.scala 80:43]
      node _sum1_T = bits(t1, 15, 0) @[dut.scala 81:15]
      sum1 <= _sum1_T @[dut.scala 81:10]
      node _c1_T = bits(t1, 16, 16) @[dut.scala 82:13]
      c1 <= _c1_T @[dut.scala 82:8]
      sum0_d1 <= sum0 @[dut.scala 84:13]
    when en2 : @[dut.scala 90:13]
      node _t2_T = bits(a_d2, 47, 32) @[dut.scala 91:18]
      node _t2_T_1 = bits(b_d2, 47, 32) @[dut.scala 91:34]
      node _t2_T_2 = add(_t2_T, _t2_T_1) @[dut.scala 91:27]
      node t2 = add(_t2_T_2, c1) @[dut.scala 91:43]
      node _sum2_T = bits(t2, 15, 0) @[dut.scala 92:15]
      sum2 <= _sum2_T @[dut.scala 92:10]
      node _c2_T = bits(t2, 16, 16) @[dut.scala 93:13]
      c2 <= _c2_T @[dut.scala 93:8]
      sum0_d2 <= sum0_d1 @[dut.scala 95:13]
      sum1_d1 <= sum1 @[dut.scala 96:13]
    when en3 : @[dut.scala 102:13]
      node _t3_T = bits(a_d3, 63, 48) @[dut.scala 103:18]
      node _t3_T_1 = bits(b_d3, 63, 48) @[dut.scala 103:34]
      node _t3_T_2 = add(_t3_T, _t3_T_1) @[dut.scala 103:27]
      node t3 = add(_t3_T_2, c2) @[dut.scala 103:43]
      node _sum3_T = bits(t3, 15, 0) @[dut.scala 104:15]
      sum3 <= _sum3_T @[dut.scala 104:10]
      node _c3_T = bits(t3, 16, 16) @[dut.scala 105:13]
      c3 <= _c3_T @[dut.scala 105:8]
      sum0_d3 <= sum0_d2 @[dut.scala 107:13]
      sum1_d2 <= sum1_d1 @[dut.scala 108:13]
      sum2_d1 <= sum2 @[dut.scala 109:13]
    node io_result_lo = cat(sum1_d2, sum0_d3) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(c3, sum3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2_d1) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 115:13]
    io.o_en <= en4 @[dut.scala 116:11]

