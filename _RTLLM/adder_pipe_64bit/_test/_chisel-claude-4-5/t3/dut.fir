circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 14:26]
    adda_reg1 <= io.adda @[dut.scala 14:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 15:26]
    adda_reg2 <= adda_reg1 @[dut.scala 15:26]
    reg adda_reg3 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 16:26]
    adda_reg3 <= adda_reg2 @[dut.scala 16:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 18:26]
    addb_reg1 <= io.addb @[dut.scala 18:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 19:26]
    addb_reg2 <= addb_reg1 @[dut.scala 19:26]
    reg addb_reg3 : UInt, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 20:26]
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
    wire carry1 : UInt<1> @[dut.scala 30:20]
    node _sum1_T = bits(io.adda, 15, 0) @[dut.scala 31:18]
    node _sum1_T_1 = bits(io.addb, 15, 0) @[dut.scala 31:36]
    node _sum1_T_2 = add(_sum1_T, _sum1_T_1) @[dut.scala 31:26]
    sum1 <= _sum1_T_2 @[dut.scala 31:8]
    node _carry1_T = bits(sum1, 16, 16) @[dut.scala 32:17]
    carry1 <= _carry1_T @[dut.scala 32:10]
    node _sum1_reg_T = bits(sum1, 15, 0) @[dut.scala 34:30]
    reg sum1_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 34:25]
    sum1_reg <= _sum1_reg_T @[dut.scala 34:25]
    reg carry1_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 35:27]
    carry1_reg <= carry1 @[dut.scala 35:27]
    wire sum2 : UInt<17> @[dut.scala 38:18]
    wire carry2 : UInt<1> @[dut.scala 39:20]
    node _sum2_T = bits(adda_reg1, 31, 16) @[dut.scala 40:20]
    node _sum2_T_1 = bits(addb_reg1, 31, 16) @[dut.scala 40:41]
    node _sum2_T_2 = add(_sum2_T, _sum2_T_1) @[dut.scala 40:29]
    node _sum2_T_3 = add(_sum2_T_2, carry1_reg) @[dut.scala 40:50]
    sum2 <= _sum2_T_3 @[dut.scala 40:8]
    node _carry2_T = bits(sum2, 16, 16) @[dut.scala 41:17]
    carry2 <= _carry2_T @[dut.scala 41:10]
    node _sum2_reg_T = bits(sum2, 15, 0) @[dut.scala 43:30]
    reg sum2_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 43:25]
    sum2_reg <= _sum2_reg_T @[dut.scala 43:25]
    reg carry2_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:27]
    carry2_reg <= carry2 @[dut.scala 44:27]
    reg sum1_reg2 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 45:26]
    sum1_reg2 <= sum1_reg @[dut.scala 45:26]
    wire sum3 : UInt<17> @[dut.scala 48:18]
    wire carry3 : UInt<1> @[dut.scala 49:20]
    node _sum3_T = bits(adda_reg2, 47, 32) @[dut.scala 50:20]
    node _sum3_T_1 = bits(addb_reg2, 47, 32) @[dut.scala 50:41]
    node _sum3_T_2 = add(_sum3_T, _sum3_T_1) @[dut.scala 50:29]
    node _sum3_T_3 = add(_sum3_T_2, carry2_reg) @[dut.scala 50:50]
    sum3 <= _sum3_T_3 @[dut.scala 50:8]
    node _carry3_T = bits(sum3, 16, 16) @[dut.scala 51:17]
    carry3 <= _carry3_T @[dut.scala 51:10]
    node _sum3_reg_T = bits(sum3, 15, 0) @[dut.scala 53:30]
    reg sum3_reg : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 53:25]
    sum3_reg <= _sum3_reg_T @[dut.scala 53:25]
    reg carry3_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:27]
    carry3_reg <= carry3 @[dut.scala 54:27]
    reg sum2_reg2 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 55:26]
    sum2_reg2 <= sum2_reg @[dut.scala 55:26]
    reg sum1_reg3 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 56:26]
    sum1_reg3 <= sum1_reg2 @[dut.scala 56:26]
    wire sum4 : UInt<17> @[dut.scala 59:18]
    node _sum4_T = bits(adda_reg3, 63, 48) @[dut.scala 60:20]
    node _sum4_T_1 = bits(addb_reg3, 63, 48) @[dut.scala 60:41]
    node _sum4_T_2 = add(_sum4_T, _sum4_T_1) @[dut.scala 60:29]
    node _sum4_T_3 = add(_sum4_T_2, carry3_reg) @[dut.scala 60:50]
    sum4 <= _sum4_T_3 @[dut.scala 60:8]
    reg sum4_reg : UInt, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 62:25]
    sum4_reg <= sum4 @[dut.scala 62:25]
    reg sum3_reg2 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 63:26]
    sum3_reg2 <= sum3_reg @[dut.scala 63:26]
    reg sum2_reg3 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 64:26]
    sum2_reg3 <= sum2_reg2 @[dut.scala 64:26]
    reg sum1_reg4 : UInt, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 65:26]
    sum1_reg4 <= sum1_reg3 @[dut.scala 65:26]
    node io_result_lo = cat(sum2_reg3, sum1_reg4) @[Cat.scala 33:92]
    node io_result_hi = cat(sum4_reg, sum3_reg2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 68:13]
    io.o_en <= i_en_reg4 @[dut.scala 71:11]

