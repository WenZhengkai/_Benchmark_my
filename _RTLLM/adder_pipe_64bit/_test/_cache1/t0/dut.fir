circuit dut :
  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<17> @[dut.scala 13:17]
    node _sum_T = add(io.a, io.b) @[dut.scala 14:15]
    node _sum_T_1 = tail(_sum_T, 1) @[dut.scala 14:15]
    node _sum_T_2 = add(_sum_T_1, io.cin) @[dut.scala 14:22]
    node _sum_T_3 = tail(_sum_T_2, 1) @[dut.scala 14:22]
    sum <= _sum_T_3 @[dut.scala 14:7]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 15:16]
    io.sum <= _io_sum_T @[dut.scala 15:10]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 16:17]
    io.cout <= _io_cout_T @[dut.scala 16:11]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<17> @[dut.scala 13:17]
    node _sum_T = add(io.a, io.b) @[dut.scala 14:15]
    node _sum_T_1 = tail(_sum_T, 1) @[dut.scala 14:15]
    node _sum_T_2 = add(_sum_T_1, io.cin) @[dut.scala 14:22]
    node _sum_T_3 = tail(_sum_T_2, 1) @[dut.scala 14:22]
    sum <= _sum_T_3 @[dut.scala 14:7]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 15:16]
    io.sum <= _io_sum_T @[dut.scala 15:10]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 16:17]
    io.cout <= _io_cout_T @[dut.scala 16:11]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<17> @[dut.scala 13:17]
    node _sum_T = add(io.a, io.b) @[dut.scala 14:15]
    node _sum_T_1 = tail(_sum_T, 1) @[dut.scala 14:15]
    node _sum_T_2 = add(_sum_T_1, io.cin) @[dut.scala 14:22]
    node _sum_T_3 = tail(_sum_T_2, 1) @[dut.scala 14:22]
    sum <= _sum_T_3 @[dut.scala 14:7]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 15:16]
    io.sum <= _io_sum_T @[dut.scala 15:10]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 16:17]
    io.cout <= _io_cout_T @[dut.scala 16:11]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    wire sum : UInt<17> @[dut.scala 13:17]
    node _sum_T = add(io.a, io.b) @[dut.scala 14:15]
    node _sum_T_1 = tail(_sum_T, 1) @[dut.scala 14:15]
    node _sum_T_2 = add(_sum_T_1, io.cin) @[dut.scala 14:22]
    node _sum_T_3 = tail(_sum_T_2, 1) @[dut.scala 14:22]
    sum <= _sum_T_3 @[dut.scala 14:7]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 15:16]
    io.sum <= _io_sum_T @[dut.scala 15:10]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 16:17]
    io.cout <= _io_cout_T @[dut.scala 16:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      adda_reg <= io.adda @[Reg.scala 36:22]
    reg addb_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Reg.scala 35:20]
    when io.i_en : @[Reg.scala 36:18]
      addb_reg <= io.addb @[Reg.scala 36:22]
    wire _en_pipeline_WIRE : UInt<1>[4] @[dut.scala 33:36]
    _en_pipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 33:36]
    _en_pipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 33:36]
    _en_pipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 33:36]
    _en_pipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 33:36]
    reg en_pipeline : UInt<1>[4], clock with :
      reset => (reset, _en_pipeline_WIRE) @[dut.scala 33:28]
    when io.i_en : @[dut.scala 34:18]
      en_pipeline[0] <= UInt<1>("h1") @[dut.scala 35:20]
    else :
      en_pipeline[0] <= UInt<1>("h0") @[dut.scala 38:20]
    en_pipeline[1] <= en_pipeline[0] @[dut.scala 42:20]
    en_pipeline[2] <= en_pipeline[1] @[dut.scala 42:20]
    en_pipeline[3] <= en_pipeline[2] @[dut.scala 42:20]
    inst rca0 of RCA16 @[dut.scala 46:20]
    rca0.clock <= clock
    rca0.reset <= reset
    node _rca0_io_a_T = bits(adda_reg, 15, 0) @[dut.scala 47:24]
    rca0.io.a <= _rca0_io_a_T @[dut.scala 47:13]
    node _rca0_io_b_T = bits(addb_reg, 15, 0) @[dut.scala 48:24]
    rca0.io.b <= _rca0_io_b_T @[dut.scala 48:13]
    rca0.io.cin <= UInt<1>("h0") @[dut.scala 49:15]
    reg stage1_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 51:27]
    stage1_sum <= rca0.io.sum @[dut.scala 51:27]
    reg stage1_cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage1_cout) @[dut.scala 52:28]
    stage1_cout <= rca0.io.cout @[dut.scala 52:28]
    inst rca1 of RCA16_1 @[dut.scala 54:20]
    rca1.clock <= clock
    rca1.reset <= reset
    node _rca1_io_a_T = bits(adda_reg, 31, 16) @[dut.scala 55:24]
    rca1.io.a <= _rca1_io_a_T @[dut.scala 55:13]
    node _rca1_io_b_T = bits(addb_reg, 31, 16) @[dut.scala 56:24]
    rca1.io.b <= _rca1_io_b_T @[dut.scala 56:13]
    rca1.io.cin <= stage1_cout @[dut.scala 57:15]
    reg stage2_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 59:27]
    stage2_sum <= rca1.io.sum @[dut.scala 59:27]
    reg stage2_cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage2_cout) @[dut.scala 60:28]
    stage2_cout <= rca1.io.cout @[dut.scala 60:28]
    inst rca2 of RCA16_2 @[dut.scala 62:20]
    rca2.clock <= clock
    rca2.reset <= reset
    node _rca2_io_a_T = bits(adda_reg, 47, 32) @[dut.scala 63:24]
    rca2.io.a <= _rca2_io_a_T @[dut.scala 63:13]
    node _rca2_io_b_T = bits(addb_reg, 47, 32) @[dut.scala 64:24]
    rca2.io.b <= _rca2_io_b_T @[dut.scala 64:13]
    rca2.io.cin <= stage2_cout @[dut.scala 65:15]
    reg stage3_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 67:27]
    stage3_sum <= rca2.io.sum @[dut.scala 67:27]
    reg stage3_cout : UInt, clock with :
      reset => (UInt<1>("h0"), stage3_cout) @[dut.scala 68:28]
    stage3_cout <= rca2.io.cout @[dut.scala 68:28]
    inst rca3 of RCA16_3 @[dut.scala 70:20]
    rca3.clock <= clock
    rca3.reset <= reset
    node _rca3_io_a_T = bits(adda_reg, 63, 48) @[dut.scala 71:24]
    rca3.io.a <= _rca3_io_a_T @[dut.scala 71:13]
    node _rca3_io_b_T = bits(addb_reg, 63, 48) @[dut.scala 72:24]
    rca3.io.b <= _rca3_io_b_T @[dut.scala 72:13]
    rca3.io.cin <= stage3_cout @[dut.scala 73:15]
    reg stage4_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 75:27]
    stage4_sum <= rca3.io.sum @[dut.scala 75:27]
    reg final_carry : UInt, clock with :
      reset => (UInt<1>("h0"), final_carry) @[dut.scala 76:28]
    final_carry <= rca3.io.cout @[dut.scala 76:28]
    node result_reg_lo = cat(stage2_sum, stage1_sum) @[Cat.scala 33:92]
    node result_reg_hi_hi = cat(final_carry, stage4_sum) @[Cat.scala 33:92]
    node result_reg_hi = cat(result_reg_hi_hi, stage3_sum) @[Cat.scala 33:92]
    node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
    reg result_reg : UInt, clock with :
      reset => (UInt<1>("h0"), result_reg) @[dut.scala 79:27]
    result_reg <= _result_reg_T @[dut.scala 79:27]
    io.result <= result_reg @[dut.scala 82:13]
    io.o_en <= en_pipeline[3] @[dut.scala 83:11]

