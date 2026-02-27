circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:28]
    reg counter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:24]
    reg validReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:25]
    io.valid_out <= UInt<1>("h0") @[dut.scala 18:16]
    io.data_out <= UInt<1>("h0") @[dut.scala 19:15]
    when io.valid_in : @[dut.scala 21:21]
      node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 22:32]
      node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 22:32]
      accumulator <= _accumulator_T_1 @[dut.scala 22:17]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 23:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 23:24]
      counter <= _counter_T_1 @[dut.scala 23:13]
      node _T = eq(counter, UInt<2>("h3")) @[dut.scala 25:18]
      when _T : @[dut.scala 25:27]
        node _io_data_out_T = add(accumulator, io.data_in) @[dut.scala 27:34]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 27:34]
        io.data_out <= _io_data_out_T_1 @[dut.scala 27:19]
        io.valid_out <= UInt<1>("h1") @[dut.scala 28:20]
        accumulator <= UInt<1>("h0") @[dut.scala 29:19]
        counter <= UInt<1>("h0") @[dut.scala 30:15]
    when validReg : @[dut.scala 35:18]
      validReg <= UInt<1>("h0") @[dut.scala 36:14]
    else :
      when io.valid_out : @[dut.scala 37:28]
        validReg <= UInt<1>("h1") @[dut.scala 38:14]


