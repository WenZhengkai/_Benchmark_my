circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:23]
    reg en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:24]
    reg en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:24]
    reg en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:24]
    en_reg <= io.i_en @[dut.scala 23:10]
    en_reg2 <= en_reg @[dut.scala 24:11]
    en_reg3 <= en_reg2 @[dut.scala 25:11]
    en_reg4 <= en_reg3 @[dut.scala 26:11]
    io.o_en <= en_reg4 @[dut.scala 29:11]
    wire adda_segments : UInt<16>[4] @[dut.scala 32:27]
    wire addb_segments : UInt<16>[4] @[dut.scala 33:27]
    node _adda_segments_0_T = bits(io.adda, 15, 0) @[dut.scala 36:32]
    adda_segments[0] <= _adda_segments_0_T @[dut.scala 36:22]
    node _addb_segments_0_T = bits(io.addb, 15, 0) @[dut.scala 37:32]
    addb_segments[0] <= _addb_segments_0_T @[dut.scala 37:22]
    node _adda_segments_1_T = bits(io.adda, 31, 16) @[dut.scala 36:32]
    adda_segments[1] <= _adda_segments_1_T @[dut.scala 36:22]
    node _addb_segments_1_T = bits(io.addb, 31, 16) @[dut.scala 37:32]
    addb_segments[1] <= _addb_segments_1_T @[dut.scala 37:22]
    node _adda_segments_2_T = bits(io.adda, 47, 32) @[dut.scala 36:32]
    adda_segments[2] <= _adda_segments_2_T @[dut.scala 36:22]
    node _addb_segments_2_T = bits(io.addb, 47, 32) @[dut.scala 37:32]
    addb_segments[2] <= _addb_segments_2_T @[dut.scala 37:22]
    node _adda_segments_3_T = bits(io.adda, 63, 48) @[dut.scala 36:32]
    adda_segments[3] <= _adda_segments_3_T @[dut.scala 36:22]
    node _addb_segments_3_T = bits(io.addb, 63, 48) @[dut.scala 37:32]
    addb_segments[3] <= _addb_segments_3_T @[dut.scala 37:22]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 41:21]
    reg carry1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:23]
    when io.i_en : @[dut.scala 44:18]
      node temp_sum = add(adda_segments[0], addb_segments[0]) @[dut.scala 45:37]
      node _sum1_T = bits(temp_sum, 15, 0) @[dut.scala 46:21]
      sum1 <= _sum1_T @[dut.scala 46:10]
      node _carry1_T = bits(temp_sum, 16, 16) @[dut.scala 47:23]
      carry1 <= _carry1_T @[dut.scala 47:12]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 51:21]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 52:23]
    reg sum1_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 53:25]
    when en_reg : @[dut.scala 55:17]
      node _temp_sum_T = add(adda_segments[1], addb_segments[1]) @[dut.scala 56:37]
      node _temp_sum_T_1 = add(_temp_sum_T, carry1) @[dut.scala 56:57]
      node temp_sum_1 = tail(_temp_sum_T_1, 1) @[dut.scala 56:57]
      node _sum2_T = bits(temp_sum_1, 15, 0) @[dut.scala 57:21]
      sum2 <= _sum2_T @[dut.scala 57:10]
      node _carry2_T = bits(temp_sum_1, 16, 16) @[dut.scala 58:23]
      carry2 <= _carry2_T @[dut.scala 58:12]
      sum1_reg <= sum1 @[dut.scala 59:14]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:21]
    reg carry3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 64:23]
    reg sum2_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 65:25]
    reg sum1_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 66:26]
    when en_reg2 : @[dut.scala 68:18]
      node _temp_sum_T_2 = add(adda_segments[2], addb_segments[2]) @[dut.scala 69:37]
      node _temp_sum_T_3 = add(_temp_sum_T_2, carry2) @[dut.scala 69:57]
      node temp_sum_2 = tail(_temp_sum_T_3, 1) @[dut.scala 69:57]
      node _sum3_T = bits(temp_sum_2, 15, 0) @[dut.scala 70:21]
      sum3 <= _sum3_T @[dut.scala 70:10]
      node _carry3_T = bits(temp_sum_2, 16, 16) @[dut.scala 71:23]
      carry3 <= _carry3_T @[dut.scala 71:12]
      sum2_reg <= sum2 @[dut.scala 72:14]
      sum1_reg2 <= sum1_reg @[dut.scala 73:15]
    reg sum4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 77:21]
    reg carry4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 78:23]
    reg sum3_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 79:25]
    reg sum2_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 80:26]
    reg sum1_reg3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 81:26]
    when en_reg3 : @[dut.scala 83:18]
      node _temp_sum_T_4 = add(adda_segments[3], addb_segments[3]) @[dut.scala 84:37]
      node _temp_sum_T_5 = add(_temp_sum_T_4, carry3) @[dut.scala 84:57]
      node temp_sum_3 = tail(_temp_sum_T_5, 1) @[dut.scala 84:57]
      node _sum4_T = bits(temp_sum_3, 15, 0) @[dut.scala 85:21]
      sum4 <= _sum4_T @[dut.scala 85:10]
      node _carry4_T = bits(temp_sum_3, 16, 16) @[dut.scala 86:23]
      carry4 <= _carry4_T @[dut.scala 86:12]
      sum3_reg <= sum3 @[dut.scala 87:14]
      sum2_reg2 <= sum2_reg @[dut.scala 88:15]
      sum1_reg3 <= sum1_reg2 @[dut.scala 89:15]
    node io_result_lo = cat(sum2_reg2, sum1_reg3) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry4, sum4) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum3_reg) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 93:13]

