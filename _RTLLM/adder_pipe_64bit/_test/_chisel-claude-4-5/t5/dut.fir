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
    reg sum0 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 30:21]
    reg carry0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 31:23]
    when io.i_en : @[dut.scala 33:17]
      node _temp_sum0_T = bits(io.adda, 15, 0) @[dut.scala 34:28]
      node _temp_sum0_T_1 = bits(io.addb, 15, 0) @[dut.scala 34:46]
      node temp_sum0 = add(_temp_sum0_T, _temp_sum0_T_1) @[dut.scala 34:36]
      sum0 <= temp_sum0 @[dut.scala 35:10]
      node _carry0_T = bits(temp_sum0, 16, 16) @[dut.scala 36:24]
      carry0 <= _carry0_T @[dut.scala 36:12]
    else :
      sum0 <= UInt<1>("h0") @[dut.scala 38:10]
      carry0 <= UInt<1>("h0") @[dut.scala 39:12]
    reg sum1 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 43:21]
    reg carry1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:23]
    reg sum0_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 45:25]
    sum0_reg <= sum0 @[dut.scala 45:25]
    when i_en_reg0 : @[dut.scala 47:19]
      node _temp_sum1_T = bits(adda_reg0, 31, 16) @[dut.scala 48:30]
      node _temp_sum1_T_1 = bits(addb_reg0, 31, 16) @[dut.scala 48:51]
      node _temp_sum1_T_2 = add(_temp_sum1_T, _temp_sum1_T_1) @[dut.scala 48:39]
      node temp_sum1 = add(_temp_sum1_T_2, carry0) @[dut.scala 48:60]
      sum1 <= temp_sum1 @[dut.scala 49:10]
      node _carry1_T = bits(temp_sum1, 16, 16) @[dut.scala 50:24]
      carry1 <= _carry1_T @[dut.scala 50:12]
    else :
      sum1 <= UInt<1>("h0") @[dut.scala 52:10]
      carry1 <= UInt<1>("h0") @[dut.scala 53:12]
    reg sum2 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 57:21]
    reg carry2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 58:23]
    reg sum1_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 59:25]
    sum1_reg <= sum1 @[dut.scala 59:25]
    reg sum0_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 60:26]
    sum0_reg2 <= sum0_reg @[dut.scala 60:26]
    when i_en_reg1 : @[dut.scala 62:19]
      node _temp_sum2_T = bits(adda_reg1, 47, 32) @[dut.scala 63:30]
      node _temp_sum2_T_1 = bits(addb_reg1, 47, 32) @[dut.scala 63:51]
      node _temp_sum2_T_2 = add(_temp_sum2_T, _temp_sum2_T_1) @[dut.scala 63:39]
      node temp_sum2 = add(_temp_sum2_T_2, carry1) @[dut.scala 63:60]
      sum2 <= temp_sum2 @[dut.scala 64:10]
      node _carry2_T = bits(temp_sum2, 16, 16) @[dut.scala 65:24]
      carry2 <= _carry2_T @[dut.scala 65:12]
    else :
      sum2 <= UInt<1>("h0") @[dut.scala 67:10]
      carry2 <= UInt<1>("h0") @[dut.scala 68:12]
    reg sum3 : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[dut.scala 72:21]
    reg sum2_reg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 73:25]
    sum2_reg <= sum2 @[dut.scala 73:25]
    reg sum1_reg2 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 74:26]
    sum1_reg2 <= sum1_reg @[dut.scala 74:26]
    reg sum0_reg3 : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 75:26]
    sum0_reg3 <= sum0_reg2 @[dut.scala 75:26]
    when i_en_reg2 : @[dut.scala 77:19]
      node _temp_sum3_T = bits(adda_reg2, 63, 48) @[dut.scala 78:30]
      node _temp_sum3_T_1 = bits(addb_reg2, 63, 48) @[dut.scala 78:51]
      node _temp_sum3_T_2 = add(_temp_sum3_T, _temp_sum3_T_1) @[dut.scala 78:39]
      node temp_sum3 = add(_temp_sum3_T_2, carry2) @[dut.scala 78:60]
      sum3 <= temp_sum3 @[dut.scala 79:10]
    else :
      sum3 <= UInt<1>("h0") @[dut.scala 81:10]
    node _io_result_T = bits(sum2_reg, 15, 0) @[dut.scala 85:34]
    node _io_result_T_1 = bits(sum1_reg2, 15, 0) @[dut.scala 85:52]
    node _io_result_T_2 = bits(sum0_reg3, 15, 0) @[dut.scala 85:70]
    node io_result_lo = cat(_io_result_T_1, _io_result_T_2) @[Cat.scala 33:92]
    node io_result_hi = cat(sum3, _io_result_T) @[Cat.scala 33:92]
    node _io_result_T_3 = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T_3 @[dut.scala 85:13]
    io.o_en <= i_en_reg3 @[dut.scala 88:11]

