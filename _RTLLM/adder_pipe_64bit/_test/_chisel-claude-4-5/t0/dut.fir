circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    adda_reg0 <= io.adda @[dut.scala 14:26]
    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    adda_reg1 <= adda_reg0 @[dut.scala 15:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:26]
    adda_reg2 <= adda_reg1 @[dut.scala 16:26]
    reg addb_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    addb_reg0 <= io.addb @[dut.scala 18:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:26]
    addb_reg1 <= addb_reg0 @[dut.scala 19:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
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
    reg sum_stage0 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 29:27]
    reg sum_stage1 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 30:27]
    reg sum_stage2 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 31:27]
    reg sum_stage3 : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 32:27]
    reg carry_stage0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 34:29]
    reg carry_stage1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:29]
    reg carry_stage2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 36:29]
    reg carry_stage3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 37:29]
    node stage0_a = bits(io.adda, 15, 0) @[dut.scala 40:25]
    node stage0_b = bits(io.addb, 15, 0) @[dut.scala 41:25]
    node stage0_sum = add(stage0_a, stage0_b) @[dut.scala 42:29]
    node _sum_stage0_T = bits(stage0_sum, 15, 0) @[dut.scala 43:27]
    sum_stage0 <= _sum_stage0_T @[dut.scala 43:14]
    node _carry_stage0_T = bits(stage0_sum, 16, 16) @[dut.scala 44:29]
    carry_stage0 <= _carry_stage0_T @[dut.scala 44:16]
    node stage1_a = bits(adda_reg0, 31, 16) @[dut.scala 47:27]
    node stage1_b = bits(addb_reg0, 31, 16) @[dut.scala 48:27]
    node _stage1_sum_T = add(stage1_a, stage1_b) @[dut.scala 49:29]
    node stage1_sum = add(_stage1_sum_T, carry_stage0) @[dut.scala 49:41]
    node _sum_stage1_T = bits(stage1_sum, 15, 0) @[dut.scala 50:27]
    sum_stage1 <= _sum_stage1_T @[dut.scala 50:14]
    node _carry_stage1_T = bits(stage1_sum, 16, 16) @[dut.scala 51:29]
    carry_stage1 <= _carry_stage1_T @[dut.scala 51:16]
    node stage2_a = bits(adda_reg1, 47, 32) @[dut.scala 54:27]
    node stage2_b = bits(addb_reg1, 47, 32) @[dut.scala 55:27]
    node _stage2_sum_T = add(stage2_a, stage2_b) @[dut.scala 56:29]
    node stage2_sum = add(_stage2_sum_T, carry_stage1) @[dut.scala 56:41]
    node _sum_stage2_T = bits(stage2_sum, 15, 0) @[dut.scala 57:27]
    sum_stage2 <= _sum_stage2_T @[dut.scala 57:14]
    node _carry_stage2_T = bits(stage2_sum, 16, 16) @[dut.scala 58:29]
    carry_stage2 <= _carry_stage2_T @[dut.scala 58:16]
    node stage3_a = bits(adda_reg2, 63, 48) @[dut.scala 61:27]
    node stage3_b = bits(addb_reg2, 63, 48) @[dut.scala 62:27]
    node _stage3_sum_T = add(stage3_a, stage3_b) @[dut.scala 63:29]
    node stage3_sum = add(_stage3_sum_T, carry_stage2) @[dut.scala 63:41]
    node _sum_stage3_T = bits(stage3_sum, 15, 0) @[dut.scala 64:27]
    sum_stage3 <= _sum_stage3_T @[dut.scala 64:14]
    node _carry_stage3_T = bits(stage3_sum, 16, 16) @[dut.scala 65:29]
    carry_stage3 <= _carry_stage3_T @[dut.scala 65:16]
    node io_result_lo = cat(sum_stage1, sum_stage0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(carry_stage3, sum_stage3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, sum_stage2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 68:13]
    io.o_en <= i_en_reg3 @[dut.scala 71:11]

