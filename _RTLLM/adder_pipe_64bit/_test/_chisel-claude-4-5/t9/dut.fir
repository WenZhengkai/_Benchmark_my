circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg adda_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:26]
    adda_reg0 <= io.adda @[dut.scala 14:26]
    reg addb_reg0 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:26]
    addb_reg0 <= io.addb @[dut.scala 15:26]
    reg adda_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:26]
    adda_reg1 <= adda_reg0 @[dut.scala 17:26]
    reg addb_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:26]
    addb_reg1 <= addb_reg0 @[dut.scala 18:26]
    reg adda_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:26]
    adda_reg2 <= adda_reg1 @[dut.scala 20:26]
    reg addb_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:26]
    addb_reg2 <= addb_reg1 @[dut.scala 21:26]
    reg i_en_reg0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:26]
    i_en_reg0 <= io.i_en @[dut.scala 24:26]
    reg i_en_reg1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:26]
    i_en_reg1 <= i_en_reg0 @[dut.scala 25:26]
    reg i_en_reg2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 26:26]
    i_en_reg2 <= i_en_reg1 @[dut.scala 26:26]
    reg i_en_reg3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 27:26]
    i_en_reg3 <= i_en_reg2 @[dut.scala 27:26]
    wire sum0 : UInt<17> @[dut.scala 30:18]
    wire carry0 : UInt<1> @[dut.scala 31:20]
    node _temp0_T = bits(io.adda, 15, 0) @[dut.scala 32:22]
    node _temp0_T_1 = bits(io.addb, 15, 0) @[dut.scala 32:40]
    node temp0 = add(_temp0_T, _temp0_T_1) @[dut.scala 32:30]
    sum0 <= temp0 @[dut.scala 33:8]
    node _carry0_T = bits(temp0, 16, 16) @[dut.scala 34:18]
    carry0 <= _carry0_T @[dut.scala 34:10]
    node _sum0_reg_T = bits(sum0, 15, 0) @[dut.scala 36:30]
    reg sum0_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 36:25]
    sum0_reg <= _sum0_reg_T @[dut.scala 36:25]
    reg carry0_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 37:27]
    carry0_reg <= carry0 @[dut.scala 37:27]
    wire sum1 : UInt<17> @[dut.scala 40:18]
    wire carry1 : UInt<1> @[dut.scala 41:20]
    node _temp1_T = bits(adda_reg0, 31, 16) @[dut.scala 42:24]
    node _temp1_T_1 = bits(addb_reg0, 31, 16) @[dut.scala 42:45]
    node _temp1_T_2 = add(_temp1_T, _temp1_T_1) @[dut.scala 42:33]
    node temp1 = add(_temp1_T_2, carry0_reg) @[dut.scala 42:54]
    sum1 <= temp1 @[dut.scala 43:8]
    node _carry1_T = bits(temp1, 16, 16) @[dut.scala 44:18]
    carry1 <= _carry1_T @[dut.scala 44:10]
    node _sum1_reg_T = bits(sum1, 15, 0) @[dut.scala 46:30]
    reg sum1_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 46:25]
    sum1_reg <= _sum1_reg_T @[dut.scala 46:25]
    reg carry1_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 47:27]
    carry1_reg <= carry1 @[dut.scala 47:27]
    reg sum0_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 48:26]
    sum0_reg1 <= sum0_reg @[dut.scala 48:26]
    wire sum2 : UInt<17> @[dut.scala 51:18]
    wire carry2 : UInt<1> @[dut.scala 52:20]
    node _temp2_T = bits(adda_reg1, 47, 32) @[dut.scala 53:24]
    node _temp2_T_1 = bits(addb_reg1, 47, 32) @[dut.scala 53:45]
    node _temp2_T_2 = add(_temp2_T, _temp2_T_1) @[dut.scala 53:33]
    node temp2 = add(_temp2_T_2, carry1_reg) @[dut.scala 53:54]
    sum2 <= temp2 @[dut.scala 54:8]
    node _carry2_T = bits(temp2, 16, 16) @[dut.scala 55:18]
    carry2 <= _carry2_T @[dut.scala 55:10]
    node _sum2_reg_T = bits(sum2, 15, 0) @[dut.scala 57:30]
    reg sum2_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 57:25]
    sum2_reg <= _sum2_reg_T @[dut.scala 57:25]
    reg carry2_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 58:27]
    carry2_reg <= carry2 @[dut.scala 58:27]
    reg sum1_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 59:26]
    sum1_reg1 <= sum1_reg @[dut.scala 59:26]
    reg sum0_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 60:26]
    sum0_reg2 <= sum0_reg1 @[dut.scala 60:26]
    wire sum3 : UInt<17> @[dut.scala 63:18]
    node _temp3_T = bits(adda_reg2, 63, 48) @[dut.scala 64:24]
    node _temp3_T_1 = bits(addb_reg2, 63, 48) @[dut.scala 64:45]
    node _temp3_T_2 = add(_temp3_T, _temp3_T_1) @[dut.scala 64:33]
    node temp3 = add(_temp3_T_2, carry2_reg) @[dut.scala 64:54]
    sum3 <= temp3 @[dut.scala 65:8]
    reg sum3_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 67:25]
    sum3_reg <= sum3 @[dut.scala 67:25]
    reg sum2_reg1 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 68:26]
    sum2_reg1 <= sum2_reg @[dut.scala 68:26]
    reg sum1_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 69:26]
    sum1_reg2 <= sum1_reg1 @[dut.scala 69:26]
    reg sum0_reg3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 70:26]
    sum0_reg3 <= sum0_reg2 @[dut.scala 70:26]
    node io_result_lo = cat(sum1_reg2, sum0_reg3) @[Cat.scala 33:92]
    node io_result_hi = cat(sum3_reg, sum2_reg1) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 73:13]
    io.o_en <= i_en_reg3 @[dut.scala 76:11]

