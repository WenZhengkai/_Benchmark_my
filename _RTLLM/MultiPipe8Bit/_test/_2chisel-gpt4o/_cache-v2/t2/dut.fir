circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip mul_en_in : UInt<1>, flip mul_a : UInt<8>, flip mul_b : UInt<8>, mul_en_out : UInt<1>, mul_out : UInt<16>}

    reg mul_en_out_reg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[dut.scala 14:31]
    reg mul_a_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 15:31]
    reg mul_b_reg : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[dut.scala 16:31]
    wire temp : UInt<16>[8] @[dut.scala 19:18]
    node _temp_0_T = bits(io.mul_b, 0, 0) @[dut.scala 21:28]
    node _temp_0_T_1 = shl(io.mul_a, 0) @[dut.scala 21:42]
    node _temp_0_T_2 = mux(_temp_0_T, _temp_0_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[0] <= _temp_0_T_2 @[dut.scala 21:13]
    node _temp_1_T = bits(io.mul_b, 1, 1) @[dut.scala 21:28]
    node _temp_1_T_1 = shl(io.mul_a, 1) @[dut.scala 21:42]
    node _temp_1_T_2 = mux(_temp_1_T, _temp_1_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[1] <= _temp_1_T_2 @[dut.scala 21:13]
    node _temp_2_T = bits(io.mul_b, 2, 2) @[dut.scala 21:28]
    node _temp_2_T_1 = shl(io.mul_a, 2) @[dut.scala 21:42]
    node _temp_2_T_2 = mux(_temp_2_T, _temp_2_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[2] <= _temp_2_T_2 @[dut.scala 21:13]
    node _temp_3_T = bits(io.mul_b, 3, 3) @[dut.scala 21:28]
    node _temp_3_T_1 = shl(io.mul_a, 3) @[dut.scala 21:42]
    node _temp_3_T_2 = mux(_temp_3_T, _temp_3_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[3] <= _temp_3_T_2 @[dut.scala 21:13]
    node _temp_4_T = bits(io.mul_b, 4, 4) @[dut.scala 21:28]
    node _temp_4_T_1 = shl(io.mul_a, 4) @[dut.scala 21:42]
    node _temp_4_T_2 = mux(_temp_4_T, _temp_4_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[4] <= _temp_4_T_2 @[dut.scala 21:13]
    node _temp_5_T = bits(io.mul_b, 5, 5) @[dut.scala 21:28]
    node _temp_5_T_1 = shl(io.mul_a, 5) @[dut.scala 21:42]
    node _temp_5_T_2 = mux(_temp_5_T, _temp_5_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[5] <= _temp_5_T_2 @[dut.scala 21:13]
    node _temp_6_T = bits(io.mul_b, 6, 6) @[dut.scala 21:28]
    node _temp_6_T_1 = shl(io.mul_a, 6) @[dut.scala 21:42]
    node _temp_6_T_2 = mux(_temp_6_T, _temp_6_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[6] <= _temp_6_T_2 @[dut.scala 21:13]
    node _temp_7_T = bits(io.mul_b, 7, 7) @[dut.scala 21:28]
    node _temp_7_T_1 = shl(io.mul_a, 7) @[dut.scala 21:42]
    node _temp_7_T_2 = mux(_temp_7_T, _temp_7_T_1, UInt<16>("h0")) @[dut.scala 21:19]
    temp[7] <= _temp_7_T_2 @[dut.scala 21:13]
    reg sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 25:21]
    reg sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 26:21]
    reg sum3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 27:21]
    reg sum4 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 28:21]
    node _sum1_T = add(temp[0], temp[1]) @[dut.scala 31:19]
    node _sum1_T_1 = tail(_sum1_T, 1) @[dut.scala 31:19]
    sum1 <= _sum1_T_1 @[dut.scala 31:8]
    node _sum2_T = add(temp[2], temp[3]) @[dut.scala 32:19]
    node _sum2_T_1 = tail(_sum2_T, 1) @[dut.scala 32:19]
    sum2 <= _sum2_T_1 @[dut.scala 32:8]
    reg partial_sum1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 35:29]
    reg partial_sum2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 36:29]
    node _partial_sum1_T = add(sum1, sum2) @[dut.scala 37:24]
    node _partial_sum1_T_1 = tail(_partial_sum1_T, 1) @[dut.scala 37:24]
    partial_sum1 <= _partial_sum1_T_1 @[dut.scala 37:16]
    node _sum3_T = add(temp[4], temp[5]) @[dut.scala 39:19]
    node _sum3_T_1 = tail(_sum3_T, 1) @[dut.scala 39:19]
    sum3 <= _sum3_T_1 @[dut.scala 39:8]
    node _sum4_T = add(temp[6], temp[7]) @[dut.scala 40:19]
    node _sum4_T_1 = tail(_sum4_T, 1) @[dut.scala 40:19]
    sum4 <= _sum4_T_1 @[dut.scala 40:8]
    reg final_sum : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 43:26]
    node _final_sum_T = add(sum3, sum4) @[dut.scala 44:37]
    node _final_sum_T_1 = tail(_final_sum_T, 1) @[dut.scala 44:37]
    node _final_sum_T_2 = add(partial_sum1, _final_sum_T_1) @[dut.scala 44:29]
    node _final_sum_T_3 = tail(_final_sum_T_2, 1) @[dut.scala 44:29]
    final_sum <= _final_sum_T_3 @[dut.scala 44:13]
    when io.mul_en_in : @[dut.scala 47:22]
      node _mul_en_out_reg_T = bits(mul_en_out_reg, 3, 0) @[dut.scala 48:41]
      node _mul_en_out_reg_T_1 = cat(_mul_en_out_reg_T, io.mul_en_in) @[Cat.scala 33:92]
      mul_en_out_reg <= _mul_en_out_reg_T_1 @[dut.scala 48:20]
      mul_a_reg <= io.mul_a @[dut.scala 49:20]
      mul_b_reg <= io.mul_b @[dut.scala 50:20]
    else :
      node _mul_en_out_reg_T_2 = bits(mul_en_out_reg, 3, 0) @[dut.scala 52:41]
      node _mul_en_out_reg_T_3 = cat(_mul_en_out_reg_T_2, UInt<1>("h0")) @[Cat.scala 33:92]
      mul_en_out_reg <= _mul_en_out_reg_T_3 @[dut.scala 52:20]
    node _io_mul_en_out_T = bits(mul_en_out_reg, 4, 4) @[dut.scala 56:34]
    io.mul_en_out <= _io_mul_en_out_T @[dut.scala 56:17]
    node _io_mul_out_T = mux(io.mul_en_out, final_sum, UInt<1>("h0")) @[dut.scala 57:23]
    io.mul_out <= _io_mul_out_T @[dut.scala 57:17]

