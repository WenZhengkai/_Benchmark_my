circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip d : UInt<4>, valid_out : UInt<1>, dout : UInt<1>}

    reg data : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 12:21]
    reg cnt : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:20]
    reg valid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 14:22]
    io.valid_out <= valid @[dut.scala 17:16]
    node _io_dout_T = bits(data, 3, 3) @[dut.scala 18:18]
    io.dout <= _io_dout_T @[dut.scala 18:11]
    node _T = eq(UInt<2>("h3"), cnt) @[dut.scala 21:15]
    when _T : @[dut.scala 21:15]
      data <= io.d @[dut.scala 23:12]
      cnt <= UInt<1>("h0") @[dut.scala 24:11]
      valid <= UInt<1>("h1") @[dut.scala 25:13]
    else :
      node _T_1 = eq(UInt<1>("h0"), cnt) @[dut.scala 21:15]
      when _T_1 : @[dut.scala 21:15]
        node _cnt_T = add(cnt, UInt<1>("h1")) @[dut.scala 28:18]
        node _cnt_T_1 = tail(_cnt_T, 1) @[dut.scala 28:18]
        cnt <= _cnt_T_1 @[dut.scala 28:11]
        valid <= UInt<1>("h0") @[dut.scala 29:13]
        node _data_T = bits(data, 2, 0) @[dut.scala 30:23]
        node _data_T_1 = bits(data, 3, 3) @[dut.scala 30:35]
        node _data_T_2 = cat(_data_T, _data_T_1) @[Cat.scala 33:92]
        data <= _data_T_2 @[dut.scala 30:12]
      else :
        node _T_2 = eq(UInt<1>("h1"), cnt) @[dut.scala 21:15]
        when _T_2 : @[dut.scala 21:15]
          node _cnt_T_2 = add(cnt, UInt<1>("h1")) @[dut.scala 33:18]
          node _cnt_T_3 = tail(_cnt_T_2, 1) @[dut.scala 33:18]
          cnt <= _cnt_T_3 @[dut.scala 33:11]
          valid <= UInt<1>("h0") @[dut.scala 34:13]
          node _data_T_3 = bits(data, 2, 0) @[dut.scala 35:23]
          node _data_T_4 = bits(data, 3, 3) @[dut.scala 35:35]
          node _data_T_5 = cat(_data_T_3, _data_T_4) @[Cat.scala 33:92]
          data <= _data_T_5 @[dut.scala 35:12]
        else :
          node _T_3 = eq(UInt<2>("h2"), cnt) @[dut.scala 21:15]
          when _T_3 : @[dut.scala 21:15]
            node _cnt_T_4 = add(cnt, UInt<1>("h1")) @[dut.scala 38:18]
            node _cnt_T_5 = tail(_cnt_T_4, 1) @[dut.scala 38:18]
            cnt <= _cnt_T_5 @[dut.scala 38:11]
            valid <= UInt<1>("h1") @[dut.scala 39:13]
            node _data_T_6 = bits(data, 2, 0) @[dut.scala 40:23]
            node _data_T_7 = bits(data, 3, 3) @[dut.scala 40:35]
            node _data_T_8 = cat(_data_T_6, _data_T_7) @[Cat.scala 33:92]
            data <= _data_T_8 @[dut.scala 40:12]


