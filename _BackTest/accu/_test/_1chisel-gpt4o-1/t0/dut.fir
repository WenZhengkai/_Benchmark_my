circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg counter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 13:24]
    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 16:28]
    reg outputValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:28]
    io.valid_out <= outputValid @[dut.scala 22:16]
    io.data_out <= accumulator @[dut.scala 23:15]
    when io.valid_in : @[dut.scala 25:21]
      node _T = eq(counter, UInt<2>("h3")) @[dut.scala 26:18]
      when _T : @[dut.scala 26:27]
        node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 28:34]
        node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 28:34]
        accumulator <= _accumulator_T_1 @[dut.scala 28:19]
        node _io_data_out_T = add(accumulator, io.data_in) @[dut.scala 29:34]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 29:34]
        io.data_out <= _io_data_out_T_1 @[dut.scala 29:19]
        outputValid <= UInt<1>("h1") @[dut.scala 30:19]
        counter <= UInt<1>("h0") @[dut.scala 31:15]
      else :
        node _accumulator_T_2 = add(accumulator, io.data_in) @[dut.scala 34:34]
        node _accumulator_T_3 = tail(_accumulator_T_2, 1) @[dut.scala 34:34]
        accumulator <= _accumulator_T_3 @[dut.scala 34:19]
        node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 35:26]
        node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 35:26]
        counter <= _counter_T_1 @[dut.scala 35:15]
        outputValid <= UInt<1>("h0") @[dut.scala 36:19]
    else :
      outputValid <= UInt<1>("h0") @[dut.scala 40:17]
    when outputValid : @[dut.scala 44:21]
      accumulator <= UInt<1>("h0") @[dut.scala 45:17]


