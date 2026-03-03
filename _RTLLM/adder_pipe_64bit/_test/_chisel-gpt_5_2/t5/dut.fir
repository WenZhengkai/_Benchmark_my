circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg en0 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:20]
    reg en1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:20]
    reg en2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:20]
    reg en3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 25:20]
    en0 <= io.i_en @[dut.scala 27:7]
    en1 <= en0 @[dut.scala 28:7]
    en2 <= en1 @[dut.scala 29:7]
    en3 <= en2 @[dut.scala 30:7]
    io.o_en <= en3 @[dut.scala 31:11]
    reg a0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a0) @[dut.scala 34:15]
    reg b0 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b0) @[dut.scala 35:15]
    reg a1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a1) @[dut.scala 36:15]
    reg b1 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b1) @[dut.scala 37:15]
    reg a2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a2) @[dut.scala 38:15]
    reg b2 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b2) @[dut.scala 39:15]
    reg a3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), a3) @[dut.scala 40:15]
    reg b3 : UInt<64>, clock with :
      reset => (UInt<1>("h0"), b3) @[dut.scala 41:15]
    when io.i_en : @[dut.scala 43:17]
      a0 <= io.adda @[dut.scala 44:8]
      b0 <= io.addb @[dut.scala 45:8]
    when en0 : @[dut.scala 47:13]
      a1 <= a0 @[dut.scala 47:18]
      b1 <= b0 @[dut.scala 47:28]
    when en1 : @[dut.scala 48:13]
      a2 <= a1 @[dut.scala 48:18]
      b2 <= b1 @[dut.scala 48:28]
    when en2 : @[dut.scala 49:13]
      a3 <= a2 @[dut.scala 49:18]
      b3 <= b2 @[dut.scala 49:28]
    reg c1 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 52:19]
    reg c2 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 53:19]
    reg c3 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 54:19]
    reg c4 : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 55:19]
    reg s0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s0) @[dut.scala 58:15]
    reg s1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s1) @[dut.scala 59:15]
    reg s2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s2) @[dut.scala 60:15]
    reg s3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s3) @[dut.scala 61:15]
    wire add0 : UInt<17> @[dut.scala 64:18]
    node _add0_T = bits(a0, 15, 0) @[dut.scala 65:13]
    node _add0_T_1 = bits(b0, 15, 0) @[dut.scala 65:26]
    node _add0_T_2 = add(_add0_T, _add0_T_1) @[dut.scala 65:21]
    add0 <= _add0_T_2 @[dut.scala 65:8]
    when io.i_en : @[dut.scala 67:17]
      node _s0_T = bits(add0, 15, 0) @[dut.scala 68:15]
      s0 <= _s0_T @[dut.scala 68:8]
      node _c1_T = bits(add0, 16, 16) @[dut.scala 69:15]
      c1 <= _c1_T @[dut.scala 69:8]
    wire add1 : UInt<17> @[dut.scala 73:18]
    node _add1_T = bits(a1, 31, 16) @[dut.scala 74:13]
    node _add1_T_1 = bits(b1, 31, 16) @[dut.scala 74:27]
    node _add1_T_2 = add(_add1_T, _add1_T_1) @[dut.scala 74:22]
    node _add1_T_3 = add(_add1_T_2, c1) @[dut.scala 74:36]
    node _add1_T_4 = tail(_add1_T_3, 1) @[dut.scala 74:36]
    add1 <= _add1_T_4 @[dut.scala 74:8]
    when en0 : @[dut.scala 76:13]
      node _s1_T = bits(add1, 15, 0) @[dut.scala 77:15]
      s1 <= _s1_T @[dut.scala 77:8]
      node _c2_T = bits(add1, 16, 16) @[dut.scala 78:15]
      c2 <= _c2_T @[dut.scala 78:8]
    wire add2 : UInt<17> @[dut.scala 82:18]
    node _add2_T = bits(a2, 47, 32) @[dut.scala 83:13]
    node _add2_T_1 = bits(b2, 47, 32) @[dut.scala 83:27]
    node _add2_T_2 = add(_add2_T, _add2_T_1) @[dut.scala 83:22]
    node _add2_T_3 = add(_add2_T_2, c2) @[dut.scala 83:36]
    node _add2_T_4 = tail(_add2_T_3, 1) @[dut.scala 83:36]
    add2 <= _add2_T_4 @[dut.scala 83:8]
    when en1 : @[dut.scala 85:13]
      node _s2_T = bits(add2, 15, 0) @[dut.scala 86:15]
      s2 <= _s2_T @[dut.scala 86:8]
      node _c3_T = bits(add2, 16, 16) @[dut.scala 87:15]
      c3 <= _c3_T @[dut.scala 87:8]
    wire add3 : UInt<17> @[dut.scala 91:18]
    node _add3_T = bits(a3, 63, 48) @[dut.scala 92:13]
    node _add3_T_1 = bits(b3, 63, 48) @[dut.scala 92:27]
    node _add3_T_2 = add(_add3_T, _add3_T_1) @[dut.scala 92:22]
    node _add3_T_3 = add(_add3_T_2, c3) @[dut.scala 92:36]
    node _add3_T_4 = tail(_add3_T_3, 1) @[dut.scala 92:36]
    add3 <= _add3_T_4 @[dut.scala 92:8]
    when en2 : @[dut.scala 94:13]
      node _s3_T = bits(add3, 15, 0) @[dut.scala 95:15]
      s3 <= _s3_T @[dut.scala 95:8]
      node _c4_T = bits(add3, 16, 16) @[dut.scala 96:15]
      c4 <= _c4_T @[dut.scala 96:8]
    reg resultReg : UInt<65>, clock with :
      reset => (reset, UInt<65>("h0")) @[dut.scala 100:26]
    when en3 : @[dut.scala 101:13]
      node resultReg_lo = cat(s1, s0) @[Cat.scala 33:92]
      node resultReg_hi_hi = cat(c4, s3) @[Cat.scala 33:92]
      node resultReg_hi = cat(resultReg_hi_hi, s2) @[Cat.scala 33:92]
      node _resultReg_T = cat(resultReg_hi, resultReg_lo) @[Cat.scala 33:92]
      resultReg <= _resultReg_T @[dut.scala 102:15]
    io.result <= resultReg @[dut.scala 105:13]

