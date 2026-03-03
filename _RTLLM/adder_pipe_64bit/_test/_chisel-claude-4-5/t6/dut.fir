circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg0 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 14:26]
    adda_reg0 <= io.adda @[dut.scala 14:26]
    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 15:26]
    adda_reg1 <= adda_reg0 @[dut.scala 15:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 16:26]
    adda_reg2 <= adda_reg1 @[dut.scala 16:26]
    reg addb_reg0 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 18:26]
    addb_reg0 <= io.addb @[dut.scala 18:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 19:26]
    addb_reg1 <= addb_reg0 @[dut.scala 19:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 20:26]
    addb_reg2 <= addb_reg1 @[dut.scala 20:26]
    reg i_en_reg0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:26]
    i_en_reg0 <= io.i_en @[dut.scala 23:26]
    reg i_en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    i_en_reg1 <= i_en_reg0 @[dut.scala 24:26]
    reg i_en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:26]
    i_en_reg2 <= i_en_reg1 @[dut.scala 25:26]
    reg i_en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:26]
    i_en_reg3 <= i_en_reg2 @[dut.scala 26:26]
    wire sum0 : UInt<17> @[dut.scala 29:25]
    sum0 <= UInt<17>("h0") @[dut.scala 29:25]
    reg carry0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 30:23]
    carry0 <= UInt<1>("h0") @[dut.scala 30:23]
    reg sum0_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:25]
    sum0_reg <= UInt<16>("h0") @[dut.scala 31:25]
    node _sum0_T = bits(io.adda, 15, 0) @[dut.scala 33:18]
    node _sum0_T_1 = bits(io.addb, 15, 0) @[dut.scala 33:36]
    node _sum0_T_2 = add(_sum0_T, _sum0_T_1) @[dut.scala 33:26]
    sum0 <= _sum0_T_2 @[dut.scala 33:8]
    node _sum0_reg_T = bits(sum0, 15, 0) @[dut.scala 34:19]
    sum0_reg <= _sum0_reg_T @[dut.scala 34:12]
    node _carry0_T = bits(sum0, 16, 16) @[dut.scala 35:17]
    carry0 <= _carry0_T @[dut.scala 35:10]
    wire sum1 : UInt<17> @[dut.scala 38:25]
    sum1 <= UInt<17>("h0") @[dut.scala 38:25]
    reg carry1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 39:23]
    carry1 <= UInt<1>("h0") @[dut.scala 39:23]
    reg sum1_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 40:25]
    sum1_reg <= UInt<16>("h0") @[dut.scala 40:25]
    node _sum1_T = bits(adda_reg0, 31, 16) @[dut.scala 42:20]
    node _sum1_T_1 = bits(addb_reg0, 31, 16) @[dut.scala 42:41]
    node _sum1_T_2 = add(_sum1_T, _sum1_T_1) @[dut.scala 42:29]
    node _sum1_T_3 = add(_sum1_T_2, carry0) @[dut.scala 42:50]
    sum1 <= _sum1_T_3 @[dut.scala 42:8]
    node _sum1_reg_T = bits(sum1, 15, 0) @[dut.scala 43:19]
    sum1_reg <= _sum1_reg_T @[dut.scala 43:12]
    node _carry1_T = bits(sum1, 16, 16) @[dut.scala 44:17]
    carry1 <= _carry1_T @[dut.scala 44:10]
    wire sum2 : UInt<17> @[dut.scala 47:25]
    sum2 <= UInt<17>("h0") @[dut.scala 47:25]
    reg carry2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 48:23]
    carry2 <= UInt<1>("h0") @[dut.scala 48:23]
    reg sum2_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 49:25]
    sum2_reg <= UInt<16>("h0") @[dut.scala 49:25]
    node _sum2_T = bits(adda_reg1, 47, 32) @[dut.scala 51:20]
    node _sum2_T_1 = bits(addb_reg1, 47, 32) @[dut.scala 51:41]
    node _sum2_T_2 = add(_sum2_T, _sum2_T_1) @[dut.scala 51:29]
    node _sum2_T_3 = add(_sum2_T_2, carry1) @[dut.scala 51:50]
    sum2 <= _sum2_T_3 @[dut.scala 51:8]
    node _sum2_reg_T = bits(sum2, 15, 0) @[dut.scala 52:19]
    sum2_reg <= _sum2_reg_T @[dut.scala 52:12]
    node _carry2_T = bits(sum2, 16, 16) @[dut.scala 53:17]
    carry2 <= _carry2_T @[dut.scala 53:10]
    wire sum3 : UInt<17> @[dut.scala 56:25]
    sum3 <= UInt<17>("h0") @[dut.scala 56:25]
    reg carry3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 57:23]
    carry3 <= UInt<1>("h0") @[dut.scala 57:23]
    reg sum3_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 58:25]
    sum3_reg <= UInt<16>("h0") @[dut.scala 58:25]
    node _sum3_T = bits(adda_reg2, 63, 48) @[dut.scala 60:20]
    node _sum3_T_1 = bits(addb_reg2, 63, 48) @[dut.scala 60:41]
    node _sum3_T_2 = add(_sum3_T, _sum3_T_1) @[dut.scala 60:29]
    node _sum3_T_3 = add(_sum3_T_2, carry2) @[dut.scala 60:50]
    sum3 <= _sum3_T_3 @[dut.scala 60:8]
    node _sum3_reg_T = bits(sum3, 15, 0) @[dut.scala 61:19]
    sum3_reg <= _sum3_reg_T @[dut.scala 61:12]
    node _carry3_T = bits(sum3, 16, 16) @[dut.scala 62:17]
    carry3 <= _carry3_T @[dut.scala 62:10]
    reg sum0_reg_stage1 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 65:32]
    sum0_reg_stage1 <= sum0_reg @[dut.scala 65:32]
    reg sum0_reg_stage2 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 66:32]
    sum0_reg_stage2 <= sum0_reg_stage1 @[dut.scala 66:32]
    reg sum0_reg_stage3 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 67:32]
    sum0_reg_stage3 <= sum0_reg_stage2 @[dut.scala 67:32]
    reg sum1_reg_stage2 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 69:32]
    sum1_reg_stage2 <= sum1_reg @[dut.scala 69:32]
    reg sum1_reg_stage3 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 70:32]
    sum1_reg_stage3 <= sum1_reg_stage2 @[dut.scala 70:32]
    reg sum2_reg_stage3 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 72:32]
    sum2_reg_stage3 <= sum2_reg @[dut.scala 72:32]
    node io_result_lo = cat(sum1_reg_stage3, sum0_reg_stage3) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry3, sum3_reg) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum2_reg_stage3) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 75:13]
    io.o_en <= i_en_reg3 @[dut.scala 78:11]

