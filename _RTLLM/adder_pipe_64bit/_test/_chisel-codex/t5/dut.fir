circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:20]
    reg en4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 17:20]
    en1 <= io.i_en @[dut.scala 19:7]
    en2 <= en1 @[dut.scala 20:7]
    en3 <= en2 @[dut.scala 21:7]
    en4 <= en3 @[dut.scala 22:7]
    reg a_r1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 25:21]
    reg a_r2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 26:21]
    reg a_r3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 27:21]
    reg b_r1 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 28:21]
    reg b_r2 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 29:21]
    reg b_r3 : UInt<64>, clock with :
      reset => (reset, UInt<64>("h0")) @[dut.scala 30:21]
    a_r1 <= io.adda @[dut.scala 32:8]
    a_r2 <= a_r1 @[dut.scala 33:8]
    a_r3 <= a_r2 @[dut.scala 34:8]
    b_r1 <= io.addb @[dut.scala 35:8]
    b_r2 <= b_r1 @[dut.scala 36:8]
    b_r3 <= b_r2 @[dut.scala 37:8]
    node _s0_T = bits(io.adda, 15, 0) @[dut.scala 40:19]
    node _s0_T_1 = bits(io.addb, 15, 0) @[dut.scala 40:37]
    node s0 = add(_s0_T, _s0_T_1) @[dut.scala 40:27]
    reg sum0_r : UInt<16>, clock with :
      reset => (reset, UInt<16>("h0")) @[dut.scala 41:25]
    reg carry0_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 42:25]
    node _sum0_r_T = bits(s0, 15, 0) @[dut.scala 43:17]
    sum0_r <= _sum0_r_T @[dut.scala 43:12]
    node _carry0_r_T = bits(s0, 16, 16) @[dut.scala 44:17]
    carry0_r <= _carry0_r_T @[dut.scala 44:12]
    node _s1_T = bits(a_r1, 31, 16) @[dut.scala 47:16]
    node _s1_T_1 = bits(b_r1, 31, 16) @[dut.scala 47:32]
    node _s1_T_2 = add(_s1_T, _s1_T_1) @[dut.scala 47:25]
    node _s1_T_3 = add(_s1_T_2, carry0_r) @[dut.scala 47:41]
    node s1 = tail(_s1_T_3, 1) @[dut.scala 47:41]
    reg psum1_r : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 48:25]
    reg carry1_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 49:25]
    node _psum1_r_T = bits(s1, 15, 0) @[dut.scala 50:21]
    node _psum1_r_T_1 = cat(_psum1_r_T, sum0_r) @[Cat.scala 33:92]
    psum1_r <= _psum1_r_T_1 @[dut.scala 50:12]
    node _carry1_r_T = bits(s1, 16, 16) @[dut.scala 51:17]
    carry1_r <= _carry1_r_T @[dut.scala 51:12]
    node _s2_T = bits(a_r2, 47, 32) @[dut.scala 54:16]
    node _s2_T_1 = bits(b_r2, 47, 32) @[dut.scala 54:32]
    node _s2_T_2 = add(_s2_T, _s2_T_1) @[dut.scala 54:25]
    node _s2_T_3 = add(_s2_T_2, carry1_r) @[dut.scala 54:41]
    node s2 = tail(_s2_T_3, 1) @[dut.scala 54:41]
    reg psum2_r : UInt<48>, clock with :
      reset => (reset, UInt<48>("h0")) @[dut.scala 55:25]
    reg carry2_r : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 56:25]
    node _psum2_r_T = bits(s2, 15, 0) @[dut.scala 57:21]
    node _psum2_r_T_1 = cat(_psum2_r_T, psum1_r) @[Cat.scala 33:92]
    psum2_r <= _psum2_r_T_1 @[dut.scala 57:12]
    node _carry2_r_T = bits(s2, 16, 16) @[dut.scala 58:17]
    carry2_r <= _carry2_r_T @[dut.scala 58:12]
    node _s3_T = bits(a_r3, 63, 48) @[dut.scala 61:16]
    node _s3_T_1 = bits(b_r3, 63, 48) @[dut.scala 61:32]
    node _s3_T_2 = add(_s3_T, _s3_T_1) @[dut.scala 61:25]
    node _s3_T_3 = add(_s3_T_2, carry2_r) @[dut.scala 61:41]
    node s3 = tail(_s3_T_3, 1) @[dut.scala 61:41]
    reg result_r : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 62:25]
    node _result_r_T = bits(s3, 16, 16) @[dut.scala 63:21]
    node _result_r_T_1 = bits(s3, 15, 0) @[dut.scala 63:29]
    node result_r_hi = cat(_result_r_T, _result_r_T_1) @[Cat.scala 33:92]
    node _result_r_T_2 = cat(result_r_hi, psum2_r) @[Cat.scala 33:92]
    result_r <= _result_r_T_2 @[dut.scala 63:12]
    io.result <= result_r @[dut.scala 65:13]
    io.o_en <= en4 @[dut.scala 66:13]

