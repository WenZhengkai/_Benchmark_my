circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 20:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:20]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:20]
    en1 <= io.i_en @[dut.scala 24:7]
    en2 <= en1 @[dut.scala 25:7]
    en3 <= en2 @[dut.scala 26:7]
    en4 <= en3 @[dut.scala 27:7]
    io.o_en <= en4 @[dut.scala 28:11]
    reg a0 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 31:19]
    reg b0 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 32:19]
    when io.i_en : @[dut.scala 33:17]
      a0 <= io.adda @[dut.scala 34:8]
      b0 <= io.addb @[dut.scala 35:8]
    reg s0_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 39:24]
    reg c1_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:24]
    reg a1_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 41:24]
    reg b1_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 42:24]
    node _part0_T = bits(a0, 15, 0) @[dut.scala 44:17]
    node _part0_T_1 = bits(b0, 15, 0) @[dut.scala 44:30]
    node part0 = add(_part0_T, _part0_T_1) @[dut.scala 44:25]
    when en1 : @[dut.scala 45:13]
      node _s0_reg_T = bits(part0, 15, 0) @[dut.scala 46:20]
      s0_reg <= _s0_reg_T @[dut.scala 46:12]
      node _c1_reg_T = bits(part0, 16, 16) @[dut.scala 47:20]
      c1_reg <= _c1_reg_T @[dut.scala 47:12]
      a1_reg <= a0 @[dut.scala 48:12]
      b1_reg <= b0 @[dut.scala 49:12]
    reg s1_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 53:24]
    reg c2_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:24]
    reg s01_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 55:24]
    reg a2_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 56:24]
    reg b2_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 57:24]
    node _part1_T = bits(a1_reg, 31, 16) @[dut.scala 59:21]
    node _part1_T_1 = bits(b1_reg, 31, 16) @[dut.scala 59:39]
    node _part1_T_2 = add(_part1_T, _part1_T_1) @[dut.scala 59:30]
    node _part1_T_3 = add(_part1_T_2, c1_reg) @[dut.scala 59:48]
    node part1 = tail(_part1_T_3, 1) @[dut.scala 59:48]
    when en2 : @[dut.scala 60:13]
      node _s1_reg_T = bits(part1, 15, 0) @[dut.scala 61:21]
      s1_reg <= _s1_reg_T @[dut.scala 61:13]
      node _c2_reg_T = bits(part1, 16, 16) @[dut.scala 62:21]
      c2_reg <= _c2_reg_T @[dut.scala 62:13]
      node _s01_reg_T = bits(part1, 15, 0) @[dut.scala 63:25]
      node _s01_reg_T_1 = cat(_s01_reg_T, s0_reg) @[Cat.scala 33:92]
      s01_reg <= _s01_reg_T_1 @[dut.scala 63:13]
      a2_reg <= a1_reg @[dut.scala 64:13]
      b2_reg <= b1_reg @[dut.scala 65:13]
    reg s2_reg : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 69:25]
    reg c3_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 70:25]
    reg s012_reg : UInt<48>, clock with :
      reset => (reset, UInt<48>("h0")) @[dut.scala 71:25]
    reg a3_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 72:25]
    reg b3_reg : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 73:25]
    node _part2_T = bits(a2_reg, 47, 32) @[dut.scala 75:21]
    node _part2_T_1 = bits(b2_reg, 47, 32) @[dut.scala 75:39]
    node _part2_T_2 = add(_part2_T, _part2_T_1) @[dut.scala 75:30]
    node _part2_T_3 = add(_part2_T_2, c2_reg) @[dut.scala 75:48]
    node part2 = tail(_part2_T_3, 1) @[dut.scala 75:48]
    when en3 : @[dut.scala 76:13]
      node _s2_reg_T = bits(part2, 15, 0) @[dut.scala 77:22]
      s2_reg <= _s2_reg_T @[dut.scala 77:14]
      node _c3_reg_T = bits(part2, 16, 16) @[dut.scala 78:22]
      c3_reg <= _c3_reg_T @[dut.scala 78:14]
      node _s012_reg_T = bits(part2, 15, 0) @[dut.scala 79:26]
      node _s012_reg_T_1 = cat(_s012_reg_T, s01_reg) @[Cat.scala 33:92]
      s012_reg <= _s012_reg_T_1 @[dut.scala 79:14]
      a3_reg <= a2_reg @[dut.scala 80:14]
      b3_reg <= b2_reg @[dut.scala 81:14]
    reg result_reg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 85:27]
    node _part3_T = bits(a3_reg, 63, 48) @[dut.scala 87:21]
    node _part3_T_1 = bits(b3_reg, 63, 48) @[dut.scala 87:39]
    node _part3_T_2 = add(_part3_T, _part3_T_1) @[dut.scala 87:30]
    node _part3_T_3 = add(_part3_T_2, c3_reg) @[dut.scala 87:48]
    node part3 = tail(_part3_T_3, 1) @[dut.scala 87:48]
    when en4 : @[dut.scala 88:13]
      node _result_reg_T = bits(part3, 16, 16) @[dut.scala 90:28]
      node _result_reg_T_1 = bits(part3, 15, 0) @[dut.scala 90:39]
      node result_reg_hi = cat(_result_reg_T, _result_reg_T_1) @[Cat.scala 33:92]
      node _result_reg_T_2 = cat(result_reg_hi, s012_reg) @[Cat.scala 33:92]
      result_reg <= _result_reg_T_2 @[dut.scala 90:16]
    io.result <= result_reg @[dut.scala 93:13]

