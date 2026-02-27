circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg count : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:22]
    reg sum : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 14:20]
    reg valid_out_reg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:30]
    io.data_out <= UInt<1>("h0") @[dut.scala 18:15]
    io.valid_out <= UInt<1>("h0") @[dut.scala 19:16]
    when io.valid_in : @[dut.scala 22:21]
      node _count_T = add(count, UInt<1>("h1")) @[dut.scala 24:20]
      node _count_T_1 = tail(_count_T, 1) @[dut.scala 24:20]
      count <= _count_T_1 @[dut.scala 24:11]
      node _sum_T = add(sum, io.data_in) @[dut.scala 25:16]
      node _sum_T_1 = tail(_sum_T, 1) @[dut.scala 25:16]
      sum <= _sum_T_1 @[dut.scala 25:9]
      node _T = eq(count, UInt<2>("h3")) @[dut.scala 28:16]
      when _T : @[dut.scala 28:25]
        node _io_data_out_T = add(sum, io.data_in) @[dut.scala 29:26]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 29:26]
        io.data_out <= _io_data_out_T_1 @[dut.scala 29:19]
        io.valid_out <= UInt<1>("h1") @[dut.scala 30:20]
        sum <= UInt<1>("h0") @[dut.scala 33:11]
        count <= UInt<1>("h0") @[dut.scala 34:13]
      else :
        io.valid_out <= UInt<1>("h0") @[dut.scala 37:20]


