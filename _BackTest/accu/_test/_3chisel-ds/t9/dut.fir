circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, data_out : UInt<10>, valid_out : UInt<1>}

    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:28]
    reg counter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:24]
    reg outputValid : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:28]
    when io.valid_in : @[dut.scala 17:21]
      node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 19:32]
      node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 19:32]
      accumulator <= _accumulator_T_1 @[dut.scala 19:17]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 20:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 20:24]
      counter <= _counter_T_1 @[dut.scala 20:13]
      node _T = eq(counter, UInt<2>("h3")) @[dut.scala 23:18]
      when _T : @[dut.scala 23:27]
        node _io_data_out_T = add(accumulator, io.data_in) @[dut.scala 24:34]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 24:34]
        io.data_out <= _io_data_out_T_1 @[dut.scala 24:19]
        outputValid <= UInt<1>("h1") @[dut.scala 25:19]
        accumulator <= UInt<1>("h0") @[dut.scala 27:19]
        counter <= UInt<1>("h0") @[dut.scala 28:15]
      else :
        io.data_out <= UInt<1>("h0") @[dut.scala 30:19]
        outputValid <= UInt<1>("h0") @[dut.scala 31:19]
    else :
      io.data_out <= UInt<1>("h0") @[dut.scala 34:17]
      outputValid <= UInt<1>("h0") @[dut.scala 35:17]
    io.valid_out <= outputValid @[dut.scala 38:16]

