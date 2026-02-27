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
    reg adda_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 23:25]
    reg addb_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 24:25]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 27:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 28:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:21]
    reg carry1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 32:23]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 33:23]
    reg carry3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 34:23]
    reg carry4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:23]
    reg result_reg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 38:27]
    when io.i_en : @[dut.scala 41:17]
      adda_reg <= io.adda @[dut.scala 42:14]
      addb_reg <= io.addb @[dut.scala 43:14]
    en_reg1 <= io.i_en @[dut.scala 47:11]
    en_reg2 <= en_reg1 @[dut.scala 48:11]
    en_reg3 <= en_reg2 @[dut.scala 49:11]
    en_reg4 <= en_reg3 @[dut.scala 50:11]
    wire adda_chunks : UInt<16>[4] @[dut.scala 53:25]
    wire addb_chunks : UInt<16>[4] @[dut.scala 54:25]
    node _adda_chunks_0_T = bits(adda_reg, 15, 0) @[dut.scala 57:31]
    adda_chunks[0] <= _adda_chunks_0_T @[dut.scala 57:20]
    node _addb_chunks_0_T = bits(addb_reg, 15, 0) @[dut.scala 58:31]
    addb_chunks[0] <= _addb_chunks_0_T @[dut.scala 58:20]
    node _adda_chunks_1_T = bits(adda_reg, 31, 16) @[dut.scala 57:31]
    adda_chunks[1] <= _adda_chunks_1_T @[dut.scala 57:20]
    node _addb_chunks_1_T = bits(addb_reg, 31, 16) @[dut.scala 58:31]
    addb_chunks[1] <= _addb_chunks_1_T @[dut.scala 58:20]
    node _adda_chunks_2_T = bits(adda_reg, 47, 32) @[dut.scala 57:31]
    adda_chunks[2] <= _adda_chunks_2_T @[dut.scala 57:20]
    node _addb_chunks_2_T = bits(addb_reg, 47, 32) @[dut.scala 58:31]
    addb_chunks[2] <= _addb_chunks_2_T @[dut.scala 58:20]
    node _adda_chunks_3_T = bits(adda_reg, 63, 48) @[dut.scala 57:31]
    adda_chunks[3] <= _adda_chunks_3_T @[dut.scala 57:20]
    node _addb_chunks_3_T = bits(addb_reg, 63, 48) @[dut.scala 58:31]
    addb_chunks[3] <= _addb_chunks_3_T @[dut.scala 58:20]
    when en_reg1 : @[dut.scala 62:17]
      node temp = add(adda_chunks[0], addb_chunks[0]) @[dut.scala 63:31]
      node _sum1_T = bits(temp, 15, 0) @[dut.scala 64:17]
      sum1 <= _sum1_T @[dut.scala 64:10]
      node _carry1_T = bits(temp, 16, 16) @[dut.scala 65:19]
      carry1 <= _carry1_T @[dut.scala 65:12]
    when en_reg2 : @[dut.scala 69:17]
      node _temp_T = add(adda_chunks[1], addb_chunks[1]) @[dut.scala 70:31]
      node _temp_T_1 = add(_temp_T, carry1) @[dut.scala 70:49]
      node temp_1 = tail(_temp_T_1, 1) @[dut.scala 70:49]
      node _sum2_T = bits(temp_1, 15, 0) @[dut.scala 71:17]
      sum2 <= _sum2_T @[dut.scala 71:10]
      node _carry2_T = bits(temp_1, 16, 16) @[dut.scala 72:19]
      carry2 <= _carry2_T @[dut.scala 72:12]
    when en_reg3 : @[dut.scala 76:17]
      node _temp_T_2 = add(adda_chunks[2], addb_chunks[2]) @[dut.scala 77:31]
      node _temp_T_3 = add(_temp_T_2, carry2) @[dut.scala 77:49]
      node temp_2 = tail(_temp_T_3, 1) @[dut.scala 77:49]
      node _sum3_T = bits(temp_2, 15, 0) @[dut.scala 78:17]
      sum3 <= _sum3_T @[dut.scala 78:10]
      node _carry3_T = bits(temp_2, 16, 16) @[dut.scala 79:19]
      carry3 <= _carry3_T @[dut.scala 79:12]
    when en_reg4 : @[dut.scala 83:17]
      node _temp_T_4 = add(adda_chunks[3], addb_chunks[3]) @[dut.scala 84:31]
      node _temp_T_5 = add(_temp_T_4, carry3) @[dut.scala 84:49]
      node temp_3 = tail(_temp_T_5, 1) @[dut.scala 84:49]
      node high_sum = bits(temp_3, 15, 0) @[dut.scala 85:24]
      node _carry4_T = bits(temp_3, 16, 16) @[dut.scala 86:19]
      carry4 <= _carry4_T @[dut.scala 86:12]
      node result_reg_lo = cat(sum2, sum1) @[Cat.scala 33:92]
      node result_reg_hi_hi = cat(carry4, high_sum) @[Cat.scala 33:92]
      node result_reg_hi = cat(result_reg_hi_hi, sum3) @[Cat.scala 33:92]
      node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
      result_reg <= _result_reg_T @[dut.scala 89:16]
    io.result <= result_reg @[dut.scala 93:13]
    io.o_en <= en_reg4 @[dut.scala 94:11]

