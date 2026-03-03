circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    en0 <= io.i_en @[dut.scala 21:7]
    en1 <= en0 @[dut.scala 22:7]
    en2 <= en1 @[dut.scala 23:7]
    en3 <= en2 @[dut.scala 24:7]
    io.o_en <= en3 @[dut.scala 25:11]
    reg a0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a0) @[dut.scala 31:15]
    reg b0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b0) @[dut.scala 32:15]
    reg a1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a1) @[dut.scala 33:15]
    reg b1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b1) @[dut.scala 34:15]
    reg a2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a2) @[dut.scala 35:15]
    reg b2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b2) @[dut.scala 36:15]
    reg a3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a3) @[dut.scala 37:15]
    reg b3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b3) @[dut.scala 38:15]
    when io.i_en : @[dut.scala 40:17]
      a0 <= io.adda @[dut.scala 41:8]
      b0 <= io.addb @[dut.scala 42:8]
    when en0 : @[dut.scala 45:13]
      a1 <= a0 @[dut.scala 46:8]
      b1 <= b0 @[dut.scala 46:18]
    when en1 : @[dut.scala 48:13]
      a2 <= a1 @[dut.scala 49:8]
      b2 <= b1 @[dut.scala 49:18]
    when en2 : @[dut.scala 51:13]
      a3 <= a2 @[dut.scala 52:8]
      b3 <= b2 @[dut.scala 52:18]
    reg sum16_s0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum16_s0) @[dut.scala 58:21]
    reg sum16_s1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum16_s1) @[dut.scala 59:21]
    reg sum16_s2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum16_s2) @[dut.scala 60:21]
    reg sum16_s3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum16_s3) @[dut.scala 61:21]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 63:19]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 64:19]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 65:19]
    reg c4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 66:19]
    when io.i_en : @[dut.scala 69:17]
      node _add0_T = bits(a0, 15, 0) @[dut.scala 70:18]
      node _add0_T_1 = bits(b0, 15, 0) @[dut.scala 70:31]
      node add0 = add(_add0_T, _add0_T_1) @[dut.scala 70:26]
      node _sum16_s0_T = bits(add0, 15, 0) @[dut.scala 71:21]
      sum16_s0 <= _sum16_s0_T @[dut.scala 71:14]
      node _c1_T = bits(add0, 16, 16) @[dut.scala 72:21]
      c1 <= _c1_T @[dut.scala 72:14]
    when en0 : @[dut.scala 76:13]
      node _add1_T = bits(a1, 31, 16) @[dut.scala 77:18]
      node _add1_T_1 = bits(b1, 31, 16) @[dut.scala 77:32]
      node _add1_T_2 = add(_add1_T, _add1_T_1) @[dut.scala 77:27]
      node _add1_T_3 = add(_add1_T_2, c1) @[dut.scala 77:41]
      node add1 = tail(_add1_T_3, 1) @[dut.scala 77:41]
      node _sum16_s1_T = bits(add1, 15, 0) @[dut.scala 78:21]
      sum16_s1 <= _sum16_s1_T @[dut.scala 78:14]
      node _c2_T = bits(add1, 16, 16) @[dut.scala 79:21]
      c2 <= _c2_T @[dut.scala 79:14]
    when en1 : @[dut.scala 83:13]
      node _add2_T = bits(a2, 47, 32) @[dut.scala 84:18]
      node _add2_T_1 = bits(b2, 47, 32) @[dut.scala 84:32]
      node _add2_T_2 = add(_add2_T, _add2_T_1) @[dut.scala 84:27]
      node _add2_T_3 = add(_add2_T_2, c2) @[dut.scala 84:41]
      node add2 = tail(_add2_T_3, 1) @[dut.scala 84:41]
      node _sum16_s2_T = bits(add2, 15, 0) @[dut.scala 85:21]
      sum16_s2 <= _sum16_s2_T @[dut.scala 85:14]
      node _c3_T = bits(add2, 16, 16) @[dut.scala 86:21]
      c3 <= _c3_T @[dut.scala 86:14]
    when en2 : @[dut.scala 90:13]
      node _add3_T = bits(a3, 63, 48) @[dut.scala 91:18]
      node _add3_T_1 = bits(b3, 63, 48) @[dut.scala 91:32]
      node _add3_T_2 = add(_add3_T, _add3_T_1) @[dut.scala 91:27]
      node _add3_T_3 = add(_add3_T_2, c3) @[dut.scala 91:41]
      node add3 = tail(_add3_T_3, 1) @[dut.scala 91:41]
      node _sum16_s3_T = bits(add3, 15, 0) @[dut.scala 92:21]
      sum16_s3 <= _sum16_s3_T @[dut.scala 92:14]
      node _c4_T = bits(add3, 16, 16) @[dut.scala 93:21]
      c4 <= _c4_T @[dut.scala 93:14]
    node io_result_lo = cat(sum16_s1, sum16_s0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(c4, sum16_s3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum16_s2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 99:13]

