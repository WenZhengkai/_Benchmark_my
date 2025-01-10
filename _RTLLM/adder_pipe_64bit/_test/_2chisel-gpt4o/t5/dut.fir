circuit dut :
  module RippleCarryAdder16 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _result_T = add(io.a, io.b) @[dut.scala 16:21]
    node _result_T_1 = add(_result_T, io.cin) @[dut.scala 16:29]
    node result = tail(_result_T_1, 1) @[dut.scala 16:29]
    node _io_sum_T = bits(result, 15, 0) @[dut.scala 17:19]
    io.sum <= _io_sum_T @[dut.scala 17:10]
    node _io_cout_T = bits(result, 16, 16) @[dut.scala 18:20]
    io.cout <= _io_cout_T @[dut.scala 18:11]

  module RippleCarryAdder16_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _result_T = add(io.a, io.b) @[dut.scala 16:21]
    node _result_T_1 = add(_result_T, io.cin) @[dut.scala 16:29]
    node result = tail(_result_T_1, 1) @[dut.scala 16:29]
    node _io_sum_T = bits(result, 15, 0) @[dut.scala 17:19]
    io.sum <= _io_sum_T @[dut.scala 17:10]
    node _io_cout_T = bits(result, 16, 16) @[dut.scala 18:20]
    io.cout <= _io_cout_T @[dut.scala 18:11]

  module RippleCarryAdder16_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _result_T = add(io.a, io.b) @[dut.scala 16:21]
    node _result_T_1 = add(_result_T, io.cin) @[dut.scala 16:29]
    node result = tail(_result_T_1, 1) @[dut.scala 16:29]
    node _io_sum_T = bits(result, 15, 0) @[dut.scala 17:19]
    io.sum <= _io_sum_T @[dut.scala 17:10]
    node _io_cout_T = bits(result, 16, 16) @[dut.scala 18:20]
    io.cout <= _io_cout_T @[dut.scala 18:11]

  module RippleCarryAdder16_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<16>, flip b : UInt<16>, flip cin : UInt<1>, sum : UInt<16>, cout : UInt<1>}

    node _result_T = add(io.a, io.b) @[dut.scala 16:21]
    node _result_T_1 = add(_result_T, io.cin) @[dut.scala 16:29]
    node result = tail(_result_T_1, 1) @[dut.scala 16:29]
    node _io_sum_T = bits(result, 15, 0) @[dut.scala 17:19]
    io.sum <= _io_sum_T @[dut.scala 17:10]
    node _io_cout_T = bits(result, 16, 16) @[dut.scala 18:20]
    io.cout <= _io_cout_T @[dut.scala 18:11]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg enReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 32:22]
    enReg <= io.i_en @[dut.scala 32:22]
    reg stage1Sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage1Sum) @[dut.scala 33:22]
    reg stage1Cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage1Cout) @[dut.scala 34:23]
    reg stage2Sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage2Sum) @[dut.scala 35:22]
    reg stage2Cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage2Cout) @[dut.scala 36:23]
    reg stage3Sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage3Sum) @[dut.scala 37:22]
    reg stage3Cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage3Cout) @[dut.scala 38:23]
    reg stage4Sum : UInt<16>, clock with :
      reset => (UInt<1>("h0"), stage4Sum) @[dut.scala 39:22]
    reg stage4Cout : UInt<1>, clock with :
      reset => (UInt<1>("h0"), stage4Cout) @[dut.scala 40:23]
    inst adder1 of RippleCarryAdder16 @[dut.scala 43:22]
    adder1.clock <= clock
    adder1.reset <= reset
    node _adder1_io_a_T = bits(io.adda, 15, 0) @[dut.scala 44:25]
    adder1.io.a <= _adder1_io_a_T @[dut.scala 44:15]
    node _adder1_io_b_T = bits(io.addb, 15, 0) @[dut.scala 45:25]
    adder1.io.b <= _adder1_io_b_T @[dut.scala 45:15]
    adder1.io.cin <= UInt<1>("h0") @[dut.scala 46:17]
    when io.i_en : @[dut.scala 47:17]
      stage1Sum <= adder1.io.sum @[dut.scala 48:15]
      stage1Cout <= adder1.io.cout @[dut.scala 49:16]
    inst adder2 of RippleCarryAdder16_1 @[dut.scala 53:22]
    adder2.clock <= clock
    adder2.reset <= reset
    node _adder2_io_a_T = bits(io.adda, 31, 16) @[dut.scala 54:25]
    adder2.io.a <= _adder2_io_a_T @[dut.scala 54:15]
    node _adder2_io_b_T = bits(io.addb, 31, 16) @[dut.scala 55:25]
    adder2.io.b <= _adder2_io_b_T @[dut.scala 55:15]
    adder2.io.cin <= stage1Cout @[dut.scala 56:17]
    reg REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 57:15]
    REG <= io.i_en @[dut.scala 57:15]
    when REG : @[dut.scala 57:42]
      stage2Sum <= adder2.io.sum @[dut.scala 58:15]
      stage2Cout <= adder2.io.cout @[dut.scala 59:16]
    inst adder3 of RippleCarryAdder16_2 @[dut.scala 63:22]
    adder3.clock <= clock
    adder3.reset <= reset
    node _adder3_io_a_T = bits(io.adda, 47, 32) @[dut.scala 64:25]
    adder3.io.a <= _adder3_io_a_T @[dut.scala 64:15]
    node _adder3_io_b_T = bits(io.addb, 47, 32) @[dut.scala 65:25]
    adder3.io.b <= _adder3_io_b_T @[dut.scala 65:15]
    adder3.io.cin <= stage2Cout @[dut.scala 66:17]
    reg REG_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 67:23]
    REG_1 <= io.i_en @[dut.scala 67:23]
    reg REG_2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 67:15]
    REG_2 <= REG_1 @[dut.scala 67:15]
    when REG_2 : @[dut.scala 67:67]
      stage3Sum <= adder3.io.sum @[dut.scala 68:15]
      stage3Cout <= adder3.io.cout @[dut.scala 69:16]
    inst adder4 of RippleCarryAdder16_3 @[dut.scala 73:22]
    adder4.clock <= clock
    adder4.reset <= reset
    node _adder4_io_a_T = bits(io.adda, 63, 48) @[dut.scala 74:25]
    adder4.io.a <= _adder4_io_a_T @[dut.scala 74:15]
    node _adder4_io_b_T = bits(io.addb, 63, 48) @[dut.scala 75:25]
    adder4.io.b <= _adder4_io_b_T @[dut.scala 75:15]
    adder4.io.cin <= stage3Cout @[dut.scala 76:17]
    reg REG_3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 77:31]
    REG_3 <= io.i_en @[dut.scala 77:31]
    reg REG_4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 77:23]
    REG_4 <= REG_3 @[dut.scala 77:23]
    reg REG_5 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 77:15]
    REG_5 <= REG_4 @[dut.scala 77:15]
    when REG_5 : @[dut.scala 77:92]
      stage4Sum <= adder4.io.sum @[dut.scala 78:15]
      stage4Cout <= adder4.io.cout @[dut.scala 79:16]
    node io_result_lo = cat(stage2Sum, stage1Sum) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(stage4Cout, stage4Sum) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, stage3Sum) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 83:13]
    reg io_o_en_REG : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 84:37]
    io_o_en_REG <= enReg @[dut.scala 84:37]
    reg io_o_en_REG_1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 84:29]
    io_o_en_REG_1 <= io_o_en_REG @[dut.scala 84:29]
    reg io_o_en_REG_2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 84:21]
    io_o_en_REG_2 <= io_o_en_REG_1 @[dut.scala 84:21]
    io.o_en <= io_o_en_REG_2 @[dut.scala 84:11]

