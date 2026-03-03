circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:20]
    en0 <= io.i_en @[dut.scala 21:7]
    en1 <= en0 @[dut.scala 22:7]
    en2 <= en1 @[dut.scala 23:7]
    en3 <= en2 @[dut.scala 24:7]
    io.o_en <= en3 @[dut.scala 26:11]
    reg a_r1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 31:21]
    reg b_r1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 32:21]
    reg a_r2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 33:21]
    reg b_r2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 34:21]
    reg a_r3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 35:21]
    reg b_r3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 36:21]
    a_r1 <= io.adda @[dut.scala 38:8]
    b_r1 <= io.addb @[dut.scala 39:8]
    a_r2 <= a_r1 @[dut.scala 40:8]
    b_r2 <= b_r1 @[dut.scala 41:8]
    a_r3 <= a_r2 @[dut.scala 42:8]
    b_r3 <= b_r2 @[dut.scala 43:8]
    node _sum0_w_T = bits(io.adda, 15, 0) @[dut.scala 48:23]
    node _sum0_w_T_1 = bits(io.addb, 15, 0) @[dut.scala 48:41]
    node sum0_w = add(_sum0_w_T, _sum0_w_T_1) @[dut.scala 48:31]
    reg sum0_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 49:23]
    reg c0_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 50:23]
    node _sum0_r_T = bits(sum0_w, 15, 0) @[dut.scala 52:19]
    sum0_r <= _sum0_r_T @[dut.scala 52:10]
    node _c0_r_T = bits(sum0_w, 16, 16) @[dut.scala 53:19]
    c0_r <= _c0_r_T @[dut.scala 53:10]
    node _sum1_w_T = bits(a_r1, 31, 16) @[dut.scala 58:20]
    node _sum1_w_T_1 = bits(b_r1, 31, 16) @[dut.scala 58:36]
    node _sum1_w_T_2 = add(_sum1_w_T, _sum1_w_T_1) @[dut.scala 58:29]
    node sum1_w = add(_sum1_w_T_2, c0_r) @[dut.scala 58:45]
    reg sum01_r : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 59:24]
    reg c1_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 60:24]
    node _sum01_r_T = bits(sum1_w, 15, 0) @[dut.scala 62:24]
    node _sum01_r_T_1 = cat(_sum01_r_T, sum0_r) @[Cat.scala 33:92]
    sum01_r <= _sum01_r_T_1 @[dut.scala 62:11]
    node _c1_r_T = bits(sum1_w, 16, 16) @[dut.scala 63:20]
    c1_r <= _c1_r_T @[dut.scala 63:11]
    node _sum2_w_T = bits(a_r2, 47, 32) @[dut.scala 68:20]
    node _sum2_w_T_1 = bits(b_r2, 47, 32) @[dut.scala 68:36]
    node _sum2_w_T_2 = add(_sum2_w_T, _sum2_w_T_1) @[dut.scala 68:29]
    node sum2_w = add(_sum2_w_T_2, c1_r) @[dut.scala 68:45]
    reg sum012_r : UInt<48>, clock with :
      reset => (reset, UInt<48>("h0")) @[dut.scala 69:25]
    reg c2_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 70:25]
    node _sum012_r_T = bits(sum2_w, 15, 0) @[dut.scala 72:25]
    node _sum012_r_T_1 = cat(_sum012_r_T, sum01_r) @[Cat.scala 33:92]
    sum012_r <= _sum012_r_T_1 @[dut.scala 72:12]
    node _c2_r_T = bits(sum2_w, 16, 16) @[dut.scala 73:21]
    c2_r <= _c2_r_T @[dut.scala 73:12]
    node _sum3_w_T = bits(a_r3, 63, 48) @[dut.scala 78:20]
    node _sum3_w_T_1 = bits(b_r3, 63, 48) @[dut.scala 78:36]
    node _sum3_w_T_2 = add(_sum3_w_T, _sum3_w_T_1) @[dut.scala 78:29]
    node sum3_w = add(_sum3_w_T_2, c2_r) @[dut.scala 78:45]
    reg result_r : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 79:25]
    node _result_r_T = bits(sum3_w, 16, 16) @[dut.scala 82:25]
    node _result_r_T_1 = bits(sum3_w, 15, 0) @[dut.scala 82:37]
    node result_r_hi = cat(_result_r_T, _result_r_T_1) @[Cat.scala 33:92]
    node _result_r_T_2 = cat(result_r_hi, sum012_r) @[Cat.scala 33:92]
    result_r <= _result_r_T_2 @[dut.scala 82:12]
    io.result <= result_r @[dut.scala 84:13]

