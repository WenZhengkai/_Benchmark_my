circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    adda_reg1 <= io.adda @[dut.scala 14:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    adda_reg2 <= adda_reg1 @[dut.scala 15:26]
    reg adda_reg3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    adda_reg3 <= adda_reg2 @[dut.scala 16:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    addb_reg1 <= io.addb @[dut.scala 18:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    addb_reg2 <= addb_reg1 @[dut.scala 19:26]
    reg addb_reg3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
    addb_reg3 <= addb_reg2 @[dut.scala 20:26]
    reg i_en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:26]
    i_en_reg1 <= io.i_en @[dut.scala 23:26]
    reg i_en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    i_en_reg2 <= i_en_reg1 @[dut.scala 24:26]
    reg i_en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:26]
    i_en_reg3 <= i_en_reg2 @[dut.scala 25:26]
    reg i_en_reg4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:26]
    i_en_reg4 <= i_en_reg3 @[dut.scala 26:26]
    wire sum1 : UInt<17> @[dut.scala 29:18]
    reg carry1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:23]
    carry1 <= UInt<1>("h0") @[dut.scala 30:23]
    reg partial_sum1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:29]
    partial_sum1 <= UInt<16>("h0") @[dut.scala 31:29]
    node _sum1_T = bits(io.adda, 15, 0) @[dut.scala 33:18]
    node _sum1_T_1 = bits(io.addb, 15, 0) @[dut.scala 33:35]
    node _sum1_T_2 = add(_sum1_T, _sum1_T_1) @[dut.scala 33:26]
    node _sum1_T_3 = tail(_sum1_T_2, 1) @[dut.scala 33:26]
    sum1 <= _sum1_T_3 @[dut.scala 33:8]
    node _partial_sum1_T = bits(sum1, 15, 0) @[dut.scala 34:23]
    partial_sum1 <= _partial_sum1_T @[dut.scala 34:16]
    node _carry1_T = bits(sum1, 16, 16) @[dut.scala 35:17]
    carry1 <= _carry1_T @[dut.scala 35:10]
    wire sum2 : UInt<17> @[dut.scala 38:18]
    reg carry2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:23]
    carry2 <= UInt<1>("h0") @[dut.scala 39:23]
    reg partial_sum2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:29]
    partial_sum2 <= UInt<16>("h0") @[dut.scala 40:29]
    node _sum2_T = bits(adda_reg1, 31, 16) @[dut.scala 42:20]
    node _sum2_T_1 = bits(addb_reg1, 31, 16) @[dut.scala 42:40]
    node _sum2_T_2 = add(_sum2_T, _sum2_T_1) @[dut.scala 42:29]
    node _sum2_T_3 = tail(_sum2_T_2, 1) @[dut.scala 42:29]
    node _sum2_T_4 = add(_sum2_T_3, carry1) @[dut.scala 42:49]
    node _sum2_T_5 = tail(_sum2_T_4, 1) @[dut.scala 42:49]
    sum2 <= _sum2_T_5 @[dut.scala 42:8]
    node _partial_sum2_T = bits(sum2, 15, 0) @[dut.scala 43:23]
    partial_sum2 <= _partial_sum2_T @[dut.scala 43:16]
    node _carry2_T = bits(sum2, 16, 16) @[dut.scala 44:17]
    carry2 <= _carry2_T @[dut.scala 44:10]
    wire sum3 : UInt<17> @[dut.scala 47:18]
    reg carry3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 48:23]
    carry3 <= UInt<1>("h0") @[dut.scala 48:23]
    reg partial_sum3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 49:29]
    partial_sum3 <= UInt<16>("h0") @[dut.scala 49:29]
    node _sum3_T = bits(adda_reg2, 47, 32) @[dut.scala 51:20]
    node _sum3_T_1 = bits(addb_reg2, 47, 32) @[dut.scala 51:40]
    node _sum3_T_2 = add(_sum3_T, _sum3_T_1) @[dut.scala 51:29]
    node _sum3_T_3 = tail(_sum3_T_2, 1) @[dut.scala 51:29]
    node _sum3_T_4 = add(_sum3_T_3, carry2) @[dut.scala 51:49]
    node _sum3_T_5 = tail(_sum3_T_4, 1) @[dut.scala 51:49]
    sum3 <= _sum3_T_5 @[dut.scala 51:8]
    node _partial_sum3_T = bits(sum3, 15, 0) @[dut.scala 52:23]
    partial_sum3 <= _partial_sum3_T @[dut.scala 52:16]
    node _carry3_T = bits(sum3, 16, 16) @[dut.scala 53:17]
    carry3 <= _carry3_T @[dut.scala 53:10]
    wire sum4 : UInt<17> @[dut.scala 56:18]
    reg carry4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 57:23]
    carry4 <= UInt<1>("h0") @[dut.scala 57:23]
    reg partial_sum4 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 58:29]
    partial_sum4 <= UInt<16>("h0") @[dut.scala 58:29]
    node _sum4_T = bits(adda_reg3, 63, 48) @[dut.scala 60:20]
    node _sum4_T_1 = bits(addb_reg3, 63, 48) @[dut.scala 60:40]
    node _sum4_T_2 = add(_sum4_T, _sum4_T_1) @[dut.scala 60:29]
    node _sum4_T_3 = tail(_sum4_T_2, 1) @[dut.scala 60:29]
    node _sum4_T_4 = add(_sum4_T_3, carry3) @[dut.scala 60:49]
    node _sum4_T_5 = tail(_sum4_T_4, 1) @[dut.scala 60:49]
    sum4 <= _sum4_T_5 @[dut.scala 60:8]
    node _partial_sum4_T = bits(sum4, 15, 0) @[dut.scala 61:23]
    partial_sum4 <= _partial_sum4_T @[dut.scala 61:16]
    node _carry4_T = bits(sum4, 16, 16) @[dut.scala 62:17]
    carry4 <= _carry4_T @[dut.scala 62:10]
    node io_result_lo = cat(partial_sum2, partial_sum1) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry4, partial_sum4) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, partial_sum3) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 65:13]
    io.o_en <= i_en_reg4 @[dut.scala 68:11]

