circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip mul_en_in : UInt<1>, flip mul_a : UInt<8>, flip mul_b : UInt<8>, mul_en_out : UInt<1>, mul_out : UInt<16>}

    reg mul_en_out_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:31]
    reg mul_a_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:31]
    reg mul_b_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 17:31]
    when io.mul_en_in : @[dut.scala 20:22]
      mul_en_out_reg <= UInt<1>("h1") @[dut.scala 21:20]
      mul_a_reg <= io.mul_a @[dut.scala 22:15]
      mul_b_reg <= io.mul_b @[dut.scala 23:15]
    else :
      mul_en_out_reg <= UInt<1>("h0") @[dut.scala 25:20]
    wire temp : UInt<16>[8] @[dut.scala 29:18]
    node _temp_0_T = bits(mul_b_reg, 0, 0) @[dut.scala 31:29]
    node _temp_0_T_1 = shl(mul_a_reg, 0) @[dut.scala 31:45]
    node _temp_0_T_2 = mux(_temp_0_T, _temp_0_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[0] <= _temp_0_T_2 @[dut.scala 31:13]
    node _temp_1_T = bits(mul_b_reg, 1, 1) @[dut.scala 31:29]
    node _temp_1_T_1 = shl(mul_a_reg, 1) @[dut.scala 31:45]
    node _temp_1_T_2 = mux(_temp_1_T, _temp_1_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[1] <= _temp_1_T_2 @[dut.scala 31:13]
    node _temp_2_T = bits(mul_b_reg, 2, 2) @[dut.scala 31:29]
    node _temp_2_T_1 = shl(mul_a_reg, 2) @[dut.scala 31:45]
    node _temp_2_T_2 = mux(_temp_2_T, _temp_2_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[2] <= _temp_2_T_2 @[dut.scala 31:13]
    node _temp_3_T = bits(mul_b_reg, 3, 3) @[dut.scala 31:29]
    node _temp_3_T_1 = shl(mul_a_reg, 3) @[dut.scala 31:45]
    node _temp_3_T_2 = mux(_temp_3_T, _temp_3_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[3] <= _temp_3_T_2 @[dut.scala 31:13]
    node _temp_4_T = bits(mul_b_reg, 4, 4) @[dut.scala 31:29]
    node _temp_4_T_1 = shl(mul_a_reg, 4) @[dut.scala 31:45]
    node _temp_4_T_2 = mux(_temp_4_T, _temp_4_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[4] <= _temp_4_T_2 @[dut.scala 31:13]
    node _temp_5_T = bits(mul_b_reg, 5, 5) @[dut.scala 31:29]
    node _temp_5_T_1 = shl(mul_a_reg, 5) @[dut.scala 31:45]
    node _temp_5_T_2 = mux(_temp_5_T, _temp_5_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[5] <= _temp_5_T_2 @[dut.scala 31:13]
    node _temp_6_T = bits(mul_b_reg, 6, 6) @[dut.scala 31:29]
    node _temp_6_T_1 = shl(mul_a_reg, 6) @[dut.scala 31:45]
    node _temp_6_T_2 = mux(_temp_6_T, _temp_6_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[6] <= _temp_6_T_2 @[dut.scala 31:13]
    node _temp_7_T = bits(mul_b_reg, 7, 7) @[dut.scala 31:29]
    node _temp_7_T_1 = shl(mul_a_reg, 7) @[dut.scala 31:45]
    node _temp_7_T_2 = mux(_temp_7_T, _temp_7_T_1, UInt<1>("h0")) @[dut.scala 31:19]
    temp[7] <= _temp_7_T_2 @[dut.scala 31:13]
    reg sum_reg1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:25]
    reg sum_reg2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:25]
    reg sum_reg3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 37:25]
    reg sum_reg4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 38:25]
    node _sum_reg1_T = add(temp[0], temp[1]) @[dut.scala 40:23]
    node _sum_reg1_T_1 = tail(_sum_reg1_T, 1) @[dut.scala 40:23]
    sum_reg1 <= _sum_reg1_T_1 @[dut.scala 40:12]
    node _sum_reg2_T = add(temp[2], temp[3]) @[dut.scala 41:23]
    node _sum_reg2_T_1 = tail(_sum_reg2_T, 1) @[dut.scala 41:23]
    sum_reg2 <= _sum_reg2_T_1 @[dut.scala 41:12]
    node _sum_reg3_T = add(temp[4], temp[5]) @[dut.scala 42:23]
    node _sum_reg3_T_1 = tail(_sum_reg3_T, 1) @[dut.scala 42:23]
    sum_reg3 <= _sum_reg3_T_1 @[dut.scala 42:12]
    node _sum_reg4_T = add(temp[6], temp[7]) @[dut.scala 43:23]
    node _sum_reg4_T_1 = tail(_sum_reg4_T, 1) @[dut.scala 43:23]
    sum_reg4 <= _sum_reg4_T_1 @[dut.scala 43:12]
    reg final_sum_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 45:30]
    node _final_sum_reg_T = add(sum_reg1, sum_reg2) @[dut.scala 46:29]
    node _final_sum_reg_T_1 = tail(_final_sum_reg_T, 1) @[dut.scala 46:29]
    node _final_sum_reg_T_2 = add(_final_sum_reg_T_1, sum_reg3) @[dut.scala 46:40]
    node _final_sum_reg_T_3 = tail(_final_sum_reg_T_2, 1) @[dut.scala 46:40]
    node _final_sum_reg_T_4 = add(_final_sum_reg_T_3, sum_reg4) @[dut.scala 46:51]
    node _final_sum_reg_T_5 = tail(_final_sum_reg_T_4, 1) @[dut.scala 46:51]
    final_sum_reg <= _final_sum_reg_T_5 @[dut.scala 46:17]
    io.mul_en_out <= mul_en_out_reg @[dut.scala 49:17]
    node _io_mul_out_T = mux(mul_en_out_reg, final_sum_reg, UInt<1>("h0")) @[dut.scala 50:20]
    io.mul_out <= _io_mul_out_T @[dut.scala 50:14]

