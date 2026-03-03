circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:20]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 28:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 29:20]
    reg a0 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 32:19]
    reg b0 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 33:19]
    when io.i_en : @[dut.scala 35:17]
      a0 <= io.adda @[dut.scala 36:8]
      b0 <= io.addb @[dut.scala 37:8]
    en0 <= io.i_en @[dut.scala 40:7]
    en1 <= en0 @[dut.scala 41:7]
    en2 <= en1 @[dut.scala 42:7]
    en3 <= en2 @[dut.scala 43:7]
    reg sum0_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 46:27]
    reg carry0_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 47:27]
    node _s0_T = bits(a0, 15, 0) @[dut.scala 49:14]
    node _s0_T_1 = bits(b0, 15, 0) @[dut.scala 49:27]
    node s0 = add(_s0_T, _s0_T_1) @[dut.scala 49:22]
    when en0 : @[dut.scala 50:13]
      node _sum0_reg_T = bits(s0, 15, 0) @[dut.scala 51:21]
      sum0_reg <= _sum0_reg_T @[dut.scala 51:16]
      node _carry0_reg_T = bits(s0, 16, 16) @[dut.scala 52:21]
      carry0_reg <= _carry0_reg_T @[dut.scala 52:16]
    reg a1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 56:19]
    reg b1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 57:19]
    when en0 : @[dut.scala 58:13]
      a1 <= a0 @[dut.scala 59:8]
      b1 <= b0 @[dut.scala 60:8]
    reg sum1_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:27]
    reg carry1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 64:27]
    node _s1_T = bits(a1, 31, 16) @[dut.scala 66:14]
    node _s1_T_1 = bits(b1, 31, 16) @[dut.scala 66:28]
    node _s1_T_2 = add(_s1_T, _s1_T_1) @[dut.scala 66:23]
    node _s1_T_3 = add(_s1_T_2, carry0_reg) @[dut.scala 66:37]
    node s1 = tail(_s1_T_3, 1) @[dut.scala 66:37]
    when en1 : @[dut.scala 67:13]
      node _sum1_reg_T = bits(s1, 15, 0) @[dut.scala 68:21]
      sum1_reg <= _sum1_reg_T @[dut.scala 68:16]
      node _carry1_reg_T = bits(s1, 16, 16) @[dut.scala 69:21]
      carry1_reg <= _carry1_reg_T @[dut.scala 69:16]
    reg a2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 73:19]
    reg b2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 74:19]
    when en1 : @[dut.scala 75:13]
      a2 <= a1 @[dut.scala 76:8]
      b2 <= b1 @[dut.scala 77:8]
    reg sum2_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 80:27]
    reg carry2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 81:27]
    node _s2_T = bits(a2, 47, 32) @[dut.scala 83:14]
    node _s2_T_1 = bits(b2, 47, 32) @[dut.scala 83:28]
    node _s2_T_2 = add(_s2_T, _s2_T_1) @[dut.scala 83:23]
    node _s2_T_3 = add(_s2_T_2, carry1_reg) @[dut.scala 83:37]
    node s2 = tail(_s2_T_3, 1) @[dut.scala 83:37]
    when en2 : @[dut.scala 84:13]
      node _sum2_reg_T = bits(s2, 15, 0) @[dut.scala 85:21]
      sum2_reg <= _sum2_reg_T @[dut.scala 85:16]
      node _carry2_reg_T = bits(s2, 16, 16) @[dut.scala 86:21]
      carry2_reg <= _carry2_reg_T @[dut.scala 86:16]
    reg a3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 90:19]
    reg b3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 91:19]
    when en2 : @[dut.scala 92:13]
      a3 <= a2 @[dut.scala 93:8]
      b3 <= b2 @[dut.scala 94:8]
    reg sum3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 97:31]
    reg finalCarry_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 98:31]
    node _s3_T = bits(a3, 63, 48) @[dut.scala 100:14]
    node _s3_T_1 = bits(b3, 63, 48) @[dut.scala 100:28]
    node _s3_T_2 = add(_s3_T, _s3_T_1) @[dut.scala 100:23]
    node _s3_T_3 = add(_s3_T_2, carry2_reg) @[dut.scala 100:37]
    node s3 = tail(_s3_T_3, 1) @[dut.scala 100:37]
    when en3 : @[dut.scala 101:13]
      node _sum3_reg_T = bits(s3, 15, 0) @[dut.scala 102:25]
      sum3_reg <= _sum3_reg_T @[dut.scala 102:20]
      node _finalCarry_reg_T = bits(s3, 16, 16) @[dut.scala 103:25]
      finalCarry_reg <= _finalCarry_reg_T @[dut.scala 103:20]
    node io_result_lo = cat(sum1_reg, sum0_reg) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(finalCarry_reg, sum3_reg) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2_reg) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 107:13]
    io.o_en <= en3 @[dut.scala 108:13]

