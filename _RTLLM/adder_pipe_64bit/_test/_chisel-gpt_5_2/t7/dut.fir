circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_s0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:22]
    reg en_s1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:22]
    reg en_s2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:22]
    reg en_s3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:22]
    en_s0 <= io.i_en @[dut.scala 29:9]
    en_s1 <= en_s0 @[dut.scala 30:9]
    en_s2 <= en_s1 @[dut.scala 31:9]
    en_s3 <= en_s2 @[dut.scala 32:9]
    io.o_en <= en_s3 @[dut.scala 34:11]
    reg a_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s0) @[dut.scala 40:17]
    reg b_s0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s0) @[dut.scala 41:17]
    when io.i_en : @[dut.scala 42:17]
      a_s0 <= io.adda @[dut.scala 43:10]
      b_s0 <= io.addb @[dut.scala 44:10]
    reg a_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s1) @[dut.scala 47:17]
    reg b_s1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s1) @[dut.scala 48:17]
    when en_s0 : @[dut.scala 49:15]
      a_s1 <= a_s0 @[dut.scala 50:10]
      b_s1 <= b_s0 @[dut.scala 51:10]
    reg a_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s2) @[dut.scala 54:17]
    reg b_s2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s2) @[dut.scala 55:17]
    when en_s1 : @[dut.scala 56:15]
      a_s2 <= a_s1 @[dut.scala 57:10]
      b_s2 <= b_s1 @[dut.scala 58:10]
    reg a_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a_s3) @[dut.scala 61:17]
    reg b_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b_s3) @[dut.scala 62:17]
    when en_s2 : @[dut.scala 63:15]
      a_s3 <= a_s2 @[dut.scala 64:10]
      b_s3 <= b_s2 @[dut.scala 65:10]
    reg sum16_s0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), sum16_s0) @[dut.scala 71:22]
    reg carry_s0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 72:26]
    wire add0 : UInt<17> @[dut.scala 74:18]
    node _add0_T = bits(a_s0, 15, 0) @[dut.scala 75:15]
    node _add0_T_1 = bits(b_s0, 15, 0) @[dut.scala 75:30]
    node _add0_T_2 = add(_add0_T, _add0_T_1) @[dut.scala 75:23]
    node _add0_T_3 = add(_add0_T_2, UInt<1>("h0")) @[dut.scala 75:38]
    add0 <= _add0_T_3 @[dut.scala 75:8]
    when io.i_en : @[dut.scala 77:17]
      node _sum16_s0_T = bits(add0, 15, 0) @[dut.scala 78:21]
      sum16_s0 <= _sum16_s0_T @[dut.scala 78:14]
      node _carry_s0_T = bits(add0, 16, 16) @[dut.scala 79:21]
      carry_s0 <= _carry_s0_T @[dut.scala 79:14]
    reg sum_lo_s1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), sum_lo_s1) @[dut.scala 83:22]
    reg sum_lo_s2 : UInt<48>, clock with :
      reset => (UInt<1>("h0"), sum_lo_s2) @[dut.scala 84:22]
    reg sum_lo_s3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), sum_lo_s3) @[dut.scala 85:22]
    reg carry_s1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 86:26]
    reg carry_s2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 87:26]
    reg carry_s3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 88:26]
    wire add1 : UInt<17> @[dut.scala 93:18]
    node _add1_T = bits(a_s1, 31, 16) @[dut.scala 94:15]
    node _add1_T_1 = bits(b_s1, 31, 16) @[dut.scala 94:31]
    node _add1_T_2 = add(_add1_T, _add1_T_1) @[dut.scala 94:24]
    node _add1_T_3 = add(_add1_T_2, carry_s0) @[dut.scala 94:40]
    add1 <= _add1_T_3 @[dut.scala 94:8]
    when en_s0 : @[dut.scala 96:15]
      node _sum_lo_s1_T = bits(add1, 15, 0) @[dut.scala 97:26]
      node _sum_lo_s1_T_1 = cat(_sum_lo_s1_T, sum16_s0) @[Cat.scala 33:92]
      sum_lo_s1 <= _sum_lo_s1_T_1 @[dut.scala 97:15]
      node _carry_s1_T = bits(add1, 16, 16) @[dut.scala 98:22]
      carry_s1 <= _carry_s1_T @[dut.scala 98:15]
    wire add2 : UInt<17> @[dut.scala 104:18]
    node _add2_T = bits(a_s2, 47, 32) @[dut.scala 105:15]
    node _add2_T_1 = bits(b_s2, 47, 32) @[dut.scala 105:31]
    node _add2_T_2 = add(_add2_T, _add2_T_1) @[dut.scala 105:24]
    node _add2_T_3 = add(_add2_T_2, carry_s1) @[dut.scala 105:40]
    add2 <= _add2_T_3 @[dut.scala 105:8]
    when en_s1 : @[dut.scala 107:15]
      node _sum_lo_s2_T = bits(add2, 15, 0) @[dut.scala 108:26]
      node _sum_lo_s2_T_1 = cat(_sum_lo_s2_T, sum_lo_s1) @[Cat.scala 33:92]
      sum_lo_s2 <= _sum_lo_s2_T_1 @[dut.scala 108:15]
      node _carry_s2_T = bits(add2, 16, 16) @[dut.scala 109:22]
      carry_s2 <= _carry_s2_T @[dut.scala 109:15]
    wire add3 : UInt<17> @[dut.scala 115:18]
    node _add3_T = bits(a_s3, 63, 48) @[dut.scala 116:15]
    node _add3_T_1 = bits(b_s3, 63, 48) @[dut.scala 116:31]
    node _add3_T_2 = add(_add3_T, _add3_T_1) @[dut.scala 116:24]
    node _add3_T_3 = add(_add3_T_2, carry_s2) @[dut.scala 116:40]
    add3 <= _add3_T_3 @[dut.scala 116:8]
    when en_s2 : @[dut.scala 118:15]
      node _sum_lo_s3_T = bits(add3, 15, 0) @[dut.scala 119:26]
      node _sum_lo_s3_T_1 = cat(_sum_lo_s3_T, sum_lo_s2) @[Cat.scala 33:92]
      sum_lo_s3 <= _sum_lo_s3_T_1 @[dut.scala 119:15]
      node _carry_s3_T = bits(add3, 16, 16) @[dut.scala 120:22]
      carry_s3 <= _carry_s3_T @[dut.scala 120:15]
    reg result_r : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 126:25]
    when en_s3 : @[dut.scala 127:15]
      node _result_r_T = cat(carry_s3, sum_lo_s3) @[Cat.scala 33:92]
      result_r <= _result_r_T @[dut.scala 128:14]
    io.result <= result_r @[dut.scala 131:13]

