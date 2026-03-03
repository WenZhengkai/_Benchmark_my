circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip i_en : UInt<1>, flip adda : UInt<64>, flip addb : UInt<64>, result : UInt<65>, o_en : UInt<1>}

    reg s0_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg s0_adda : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s0_adda) @[dut.scala 23:20]
    reg s0_addb : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s0_addb) @[dut.scala 24:20]
    s0_en <= io.i_en @[dut.scala 26:11]
    s0_adda <= io.adda @[dut.scala 27:11]
    s0_addb <= io.addb @[dut.scala 28:11]
    reg s1_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 40:25]
    reg s1_adda : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s1_adda) @[dut.scala 41:21]
    reg s1_addb : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s1_addb) @[dut.scala 42:21]
    reg s1_sum0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s1_sum0) @[dut.scala 43:21]
    reg s1_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 44:25]
    node _T = bits(s0_adda, 15, 0) @[dut.scala 46:37]
    node _T_1 = bits(s0_addb, 15, 0) @[dut.scala 46:53]
    wire tmp : UInt<17> @[dut.scala 32:19]
    node _tmp_T = add(_T, _T_1) @[dut.scala 33:14]
    node _tmp_T_1 = add(_tmp_T, UInt<1>("h0")) @[dut.scala 33:19]
    node _tmp_T_2 = tail(_tmp_T_1, 1) @[dut.scala 33:19]
    tmp <= _tmp_T_2 @[dut.scala 33:9]
    node sum0_w = bits(tmp, 15, 0) @[dut.scala 34:9]
    node c1_w = bits(tmp, 16, 16) @[dut.scala 34:21]
    s1_en <= s0_en @[dut.scala 48:12]
    s1_adda <= s0_adda @[dut.scala 49:12]
    s1_addb <= s0_addb @[dut.scala 50:12]
    s1_sum0 <= sum0_w @[dut.scala 51:12]
    s1_carry <= c1_w @[dut.scala 52:12]
    reg s2_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 57:26]
    reg s2_adda : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s2_adda) @[dut.scala 58:22]
    reg s2_addb : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s2_addb) @[dut.scala 59:22]
    reg s2_sum0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s2_sum0) @[dut.scala 60:22]
    reg s2_sum1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s2_sum1) @[dut.scala 61:22]
    reg s2_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 62:26]
    node _T_2 = bits(s1_adda, 31, 16) @[dut.scala 64:37]
    node _T_3 = bits(s1_addb, 31, 16) @[dut.scala 64:54]
    wire tmp_1 : UInt<17> @[dut.scala 32:19]
    node _tmp_T_3 = add(_T_2, _T_3) @[dut.scala 33:14]
    node _tmp_T_4 = add(_tmp_T_3, s1_carry) @[dut.scala 33:19]
    node _tmp_T_5 = tail(_tmp_T_4, 1) @[dut.scala 33:19]
    tmp_1 <= _tmp_T_5 @[dut.scala 33:9]
    node sum1_w = bits(tmp_1, 15, 0) @[dut.scala 34:9]
    node c2_w = bits(tmp_1, 16, 16) @[dut.scala 34:21]
    s2_en <= s1_en @[dut.scala 66:12]
    s2_adda <= s1_adda @[dut.scala 67:12]
    s2_addb <= s1_addb @[dut.scala 68:12]
    s2_sum0 <= s1_sum0 @[dut.scala 69:12]
    s2_sum1 <= sum1_w @[dut.scala 70:12]
    s2_carry <= c2_w @[dut.scala 71:12]
    reg s3_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 76:26]
    reg s3_adda : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s3_adda) @[dut.scala 77:22]
    reg s3_addb : UInt<64>, clock with :
      reset => (UInt<1>("h0"), s3_addb) @[dut.scala 78:22]
    reg s3_sum0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s3_sum0) @[dut.scala 79:22]
    reg s3_sum1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s3_sum1) @[dut.scala 80:22]
    reg s3_sum2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s3_sum2) @[dut.scala 81:22]
    reg s3_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 82:26]
    node _T_4 = bits(s2_adda, 47, 32) @[dut.scala 84:37]
    node _T_5 = bits(s2_addb, 47, 32) @[dut.scala 84:54]
    wire tmp_2 : UInt<17> @[dut.scala 32:19]
    node _tmp_T_6 = add(_T_4, _T_5) @[dut.scala 33:14]
    node _tmp_T_7 = add(_tmp_T_6, s2_carry) @[dut.scala 33:19]
    node _tmp_T_8 = tail(_tmp_T_7, 1) @[dut.scala 33:19]
    tmp_2 <= _tmp_T_8 @[dut.scala 33:9]
    node sum2_w = bits(tmp_2, 15, 0) @[dut.scala 34:9]
    node c3_w = bits(tmp_2, 16, 16) @[dut.scala 34:21]
    s3_en <= s2_en @[dut.scala 86:12]
    s3_adda <= s2_adda @[dut.scala 87:12]
    s3_addb <= s2_addb @[dut.scala 88:12]
    s3_sum0 <= s2_sum0 @[dut.scala 89:12]
    s3_sum1 <= s2_sum1 @[dut.scala 90:12]
    s3_sum2 <= sum2_w @[dut.scala 91:12]
    s3_carry <= c3_w @[dut.scala 92:12]
    reg s4_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 97:26]
    reg s4_sum0 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s4_sum0) @[dut.scala 98:22]
    reg s4_sum1 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s4_sum1) @[dut.scala 99:22]
    reg s4_sum2 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s4_sum2) @[dut.scala 100:22]
    reg s4_sum3 : UInt<16>, clock with :
      reset => (UInt<1>("h0"), s4_sum3) @[dut.scala 101:22]
    reg s4_carry : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 102:26]
    node _T_6 = bits(s3_adda, 63, 48) @[dut.scala 104:37]
    node _T_7 = bits(s3_addb, 63, 48) @[dut.scala 104:54]
    wire tmp_3 : UInt<17> @[dut.scala 32:19]
    node _tmp_T_9 = add(_T_6, _T_7) @[dut.scala 33:14]
    node _tmp_T_10 = add(_tmp_T_9, s3_carry) @[dut.scala 33:19]
    node _tmp_T_11 = tail(_tmp_T_10, 1) @[dut.scala 33:19]
    tmp_3 <= _tmp_T_11 @[dut.scala 33:9]
    node sum3_w = bits(tmp_3, 15, 0) @[dut.scala 34:9]
    node c4_w = bits(tmp_3, 16, 16) @[dut.scala 34:21]
    s4_en <= s3_en @[dut.scala 106:12]
    s4_sum0 <= s3_sum0 @[dut.scala 107:12]
    s4_sum1 <= s3_sum1 @[dut.scala 108:12]
    s4_sum2 <= s3_sum2 @[dut.scala 109:12]
    s4_sum3 <= sum3_w @[dut.scala 110:12]
    s4_carry <= c4_w @[dut.scala 111:12]
    io.o_en <= s4_en @[dut.scala 114:13]
    node io_result_lo = cat(s4_sum1, s4_sum0) @[Cat.scala 33:92]
    node io_result_hi_hi = cat(s4_carry, s4_sum3) @[Cat.scala 33:92]
    node io_result_hi = cat(io_result_hi_hi, s4_sum2) @[Cat.scala 33:92]
    node _io_result_T = cat(io_result_hi, io_result_lo) @[Cat.scala 33:92]
    io.result <= _io_result_T @[dut.scala 115:13]

