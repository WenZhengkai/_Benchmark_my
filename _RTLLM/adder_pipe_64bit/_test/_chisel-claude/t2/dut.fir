circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:24]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    reg adda_reg1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 23:26]
    reg addb_reg1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 24:26]
    reg carry_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:27]
    reg adda_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 28:26]
    reg addb_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:26]
    reg carry_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:27]
    reg sum_reg1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:25]
    reg adda_reg3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:26]
    reg addb_reg3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:26]
    reg carry_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 36:27]
    reg sum_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:25]
    reg adda_reg4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 40:26]
    reg addb_reg4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 41:26]
    reg sum_reg3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 42:25]
    reg sum_reg4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 45:25]
    reg final_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 46:28]
    when io.i_en : @[dut.scala 49:18]
      node _adda_reg1_T = bits(io.adda, 15, 0) @[dut.scala 50:25]
      adda_reg1 <= _adda_reg1_T @[dut.scala 50:15]
      node _addb_reg1_T = bits(io.addb, 15, 0) @[dut.scala 51:25]
      addb_reg1 <= _addb_reg1_T @[dut.scala 51:15]
      node _adda_reg2_T = bits(io.adda, 31, 16) @[dut.scala 52:25]
      adda_reg2 <= _adda_reg2_T @[dut.scala 52:15]
      node _addb_reg2_T = bits(io.addb, 31, 16) @[dut.scala 53:25]
      addb_reg2 <= _addb_reg2_T @[dut.scala 53:15]
      node _adda_reg3_T = bits(io.adda, 47, 32) @[dut.scala 54:25]
      adda_reg3 <= _adda_reg3_T @[dut.scala 54:15]
      node _addb_reg3_T = bits(io.addb, 47, 32) @[dut.scala 55:25]
      addb_reg3 <= _addb_reg3_T @[dut.scala 55:15]
      node _adda_reg4_T = bits(io.adda, 63, 48) @[dut.scala 56:25]
      adda_reg4 <= _adda_reg4_T @[dut.scala 56:15]
      node _addb_reg4_T = bits(io.addb, 63, 48) @[dut.scala 57:25]
      addb_reg4 <= _addb_reg4_T @[dut.scala 57:15]
      en_reg1 <= UInt<1>("h1") @[dut.scala 58:13]
    else :
      en_reg1 <= UInt<1>("h0") @[dut.scala 60:13]
    node sum1 = add(adda_reg1, addb_reg1) @[dut.scala 64:24]
    when en_reg1 : @[dut.scala 67:18]
      node _sum_reg1_T = bits(sum1, 15, 0) @[dut.scala 68:21]
      sum_reg1 <= _sum_reg1_T @[dut.scala 68:14]
      node _carry_reg2_T = bits(sum1, 16, 16) @[dut.scala 69:23]
      carry_reg2 <= _carry_reg2_T @[dut.scala 69:16]
      en_reg2 <= UInt<1>("h1") @[dut.scala 70:13]
    else :
      en_reg2 <= UInt<1>("h0") @[dut.scala 72:13]
    node _sum2_T = add(adda_reg2, addb_reg2) @[dut.scala 76:24]
    node _sum2_T_1 = add(_sum2_T, carry_reg2) @[dut.scala 76:37]
    node sum2 = tail(_sum2_T_1, 1) @[dut.scala 76:37]
    when en_reg2 : @[dut.scala 79:18]
      node _sum_reg2_T = bits(sum2, 15, 0) @[dut.scala 80:21]
      sum_reg2 <= _sum_reg2_T @[dut.scala 80:14]
      node _carry_reg3_T = bits(sum2, 16, 16) @[dut.scala 81:23]
      carry_reg3 <= _carry_reg3_T @[dut.scala 81:16]
      en_reg3 <= UInt<1>("h1") @[dut.scala 82:13]
    else :
      en_reg3 <= UInt<1>("h0") @[dut.scala 84:13]
    node _sum3_T = add(adda_reg3, addb_reg3) @[dut.scala 88:24]
    node _sum3_T_1 = add(_sum3_T, carry_reg3) @[dut.scala 88:37]
    node sum3 = tail(_sum3_T_1, 1) @[dut.scala 88:37]
    when en_reg3 : @[dut.scala 91:18]
      node _sum_reg3_T = bits(sum3, 15, 0) @[dut.scala 92:21]
      sum_reg3 <= _sum_reg3_T @[dut.scala 92:14]
      node _carry_reg1_T = bits(sum3, 16, 16) @[dut.scala 93:23]
      carry_reg1 <= _carry_reg1_T @[dut.scala 93:16]
      en_reg4 <= UInt<1>("h1") @[dut.scala 94:13]
    else :
      en_reg4 <= UInt<1>("h0") @[dut.scala 96:13]
    node _sum4_T = add(adda_reg4, addb_reg4) @[dut.scala 100:24]
    node _sum4_T_1 = add(_sum4_T, carry_reg1) @[dut.scala 100:37]
    node sum4 = tail(_sum4_T_1, 1) @[dut.scala 100:37]
    when en_reg4 : @[dut.scala 103:18]
      node _sum_reg4_T = bits(sum4, 15, 0) @[dut.scala 104:21]
      sum_reg4 <= _sum_reg4_T @[dut.scala 104:14]
      node _final_carry_T = bits(sum4, 16, 16) @[dut.scala 105:24]
      final_carry <= _final_carry_T @[dut.scala 105:17]
    node io_result_lo = cat(sum_reg2, sum_reg1) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(final_carry, sum_reg4) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum_reg3) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 109:13]
    io.o_en <= en_reg4 @[dut.scala 118:11]

