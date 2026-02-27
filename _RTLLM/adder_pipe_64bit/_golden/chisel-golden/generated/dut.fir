circuit dut :
  module RCA16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _sum_T = add(io.a, io.b) @[dut.scala 44:25]
    node _sum_T_1 = add(_sum_T, io.cin) @[dut.scala 44:33]
    node sum = tail(_sum_T_1, 1) @[dut.scala 44:33]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 45:22]
    io.sum <= _io_sum_T @[dut.scala 45:16]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 46:23]
    io.cout <= _io_cout_T @[dut.scala 46:17]

  module RCA16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _sum_T = add(io.a, io.b) @[dut.scala 44:25]
    node _sum_T_1 = add(_sum_T, io.cin) @[dut.scala 44:33]
    node sum = tail(_sum_T_1, 1) @[dut.scala 44:33]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 45:22]
    io.sum <= _io_sum_T @[dut.scala 45:16]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 46:23]
    io.cout <= _io_cout_T @[dut.scala 46:17]

  module RCA16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _sum_T = add(io.a, io.b) @[dut.scala 44:25]
    node _sum_T_1 = add(_sum_T, io.cin) @[dut.scala 44:33]
    node sum = tail(_sum_T_1, 1) @[dut.scala 44:33]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 45:22]
    io.sum <= _io_sum_T @[dut.scala 45:16]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 46:23]
    io.cout <= _io_cout_T @[dut.scala 46:17]

  module RCA16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _sum_T = add(io.a, io.b) @[dut.scala 44:25]
    node _sum_T_1 = add(_sum_T, io.cin) @[dut.scala 44:33]
    node sum = tail(_sum_T_1, 1) @[dut.scala 44:33]
    node _io_sum_T = bits(sum, 15, 0) @[dut.scala 45:22]
    io.sum <= _io_sum_T @[dut.scala 45:16]
    node _io_cout_T = bits(sum, 16, 16) @[dut.scala 46:23]
    io.cout <= _io_cout_T @[dut.scala 46:17]

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
    wire _en_pipeline_WIRE : UInt<1>[4] @[dut.scala 19:38]
    _en_pipeline_WIRE[0] <= UInt<1>("h0") @[dut.scala 19:38]
    _en_pipeline_WIRE[1] <= UInt<1>("h0") @[dut.scala 19:38]
    _en_pipeline_WIRE[2] <= UInt<1>("h0") @[dut.scala 19:38]
    _en_pipeline_WIRE[3] <= UInt<1>("h0") @[dut.scala 19:38]
    reg en_pipeline : UInt<1>[4], clock with :
      reset => (reset, _en_pipeline_WIRE) @[dut.scala 19:30]
    when io.i_en : @[dut.scala 21:19]
      en_pipeline[0] <= UInt<1>("h1") @[dut.scala 22:24]
    en_pipeline[1] <= en_pipeline[0] @[dut.scala 27:24]
    en_pipeline[2] <= en_pipeline[1] @[dut.scala 27:24]
    en_pipeline[3] <= en_pipeline[2] @[dut.scala 27:24]
    inst stage1 of RCA16 @[dut.scala 53:24]
    stage1.clock <= clock
    stage1.reset <= reset
    node _stage1_io_a_T = bits(adda_reg, 15, 0) @[dut.scala 54:28]
    stage1.io.a <= _stage1_io_a_T @[dut.scala 54:17]
    node _stage1_io_b_T = bits(addb_reg, 15, 0) @[dut.scala 55:28]
    stage1.io.b <= _stage1_io_b_T @[dut.scala 55:17]
    stage1.io.cin <= UInt<1>("h0") @[dut.scala 56:19]
    reg stage1_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage1_sum) @[dut.scala 58:29]
    stage1_sum <= stage1.io.sum @[dut.scala 58:29]
    reg carry1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry1) @[dut.scala 59:25]
    carry1 <= stage1.io.cout @[dut.scala 59:25]
    inst stage2 of RCA16_1 @[dut.scala 61:24]
    stage2.clock <= clock
    stage2.reset <= reset
    node _stage2_io_a_T = bits(adda_reg, 31, 16) @[dut.scala 62:28]
    stage2.io.a <= _stage2_io_a_T @[dut.scala 62:17]
    node _stage2_io_b_T = bits(addb_reg, 31, 16) @[dut.scala 63:28]
    stage2.io.b <= _stage2_io_b_T @[dut.scala 63:17]
    stage2.io.cin <= carry1 @[dut.scala 64:19]
    reg stage2_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage2_sum) @[dut.scala 66:29]
    stage2_sum <= stage2.io.sum @[dut.scala 66:29]
    reg carry2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry2) @[dut.scala 67:25]
    carry2 <= stage2.io.cout @[dut.scala 67:25]
    inst stage3 of RCA16_2 @[dut.scala 69:24]
    stage3.clock <= clock
    stage3.reset <= reset
    node _stage3_io_a_T = bits(adda_reg, 47, 32) @[dut.scala 70:28]
    stage3.io.a <= _stage3_io_a_T @[dut.scala 70:17]
    node _stage3_io_b_T = bits(addb_reg, 47, 32) @[dut.scala 71:28]
    stage3.io.b <= _stage3_io_b_T @[dut.scala 71:17]
    stage3.io.cin <= carry2 @[dut.scala 72:19]
    reg stage3_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage3_sum) @[dut.scala 74:29]
    stage3_sum <= stage3.io.sum @[dut.scala 74:29]
    reg carry3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), carry3) @[dut.scala 75:25]
    carry3 <= stage3.io.cout @[dut.scala 75:25]
    inst stage4 of RCA16_3 @[dut.scala 77:24]
    stage4.clock <= clock
    stage4.reset <= reset
    node _stage4_io_a_T = bits(adda_reg, 63, 48) @[dut.scala 78:28]
    stage4.io.a <= _stage4_io_a_T @[dut.scala 78:17]
    node _stage4_io_b_T = bits(addb_reg, 63, 48) @[dut.scala 79:28]
    stage4.io.b <= _stage4_io_b_T @[dut.scala 79:17]
    stage4.io.cin <= carry3 @[dut.scala 80:19]
    reg stage4_sum : UInt, clock with :
      reset => (UInt<1>("h0"), stage4_sum) @[dut.scala 82:29]
    stage4_sum <= stage4.io.sum @[dut.scala 82:29]
    reg final_carry : UInt<1>, clock with :
      reset => (UInt<1>("h0"), final_carry) @[dut.scala 83:30]
    final_carry <= stage4.io.cout @[dut.scala 83:30]
    reg result_reg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 89:29]
    node result_reg_lo = cat(stage2_sum, stage1_sum) @[Cat.scala 33:92]
    node result_reg_hi_hi = cat(final_carry, stage4_sum) @[Cat.scala 33:92]
    node result_reg_hi = cat(result_reg_hi_hi, stage3_sum) @[Cat.scala 33:92]
    node _result_reg_T = cat(result_reg_hi, result_reg_lo) @[Cat.scala 33:92]
    result_reg <= _result_reg_T @[dut.scala 90:16]
    io.result <= result_reg @[dut.scala 92:15]
    io.o_en <= en_pipeline[3] @[dut.scala 98:13]

