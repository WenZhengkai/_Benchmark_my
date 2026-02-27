circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, data_out : UInt<10>, valid_out : UInt<1>}

    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:28]
    reg counter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:24]
    reg outputReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 15:26]
    reg validReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:25]
    io.data_out <= outputReg @[dut.scala 19:15]
    io.valid_out <= validReg @[dut.scala 20:16]
    when io.valid_in : @[dut.scala 22:21]
      node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 24:32]
      node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 24:32]
      accumulator <= _accumulator_T_1 @[dut.scala 24:17]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 25:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 25:24]
      counter <= _counter_T_1 @[dut.scala 25:13]
      node _T = eq(counter, UInt<2>("h3")) @[dut.scala 28:18]
      when _T : @[dut.scala 28:27]
        node _outputReg_T = add(accumulator, io.data_in) @[dut.scala 29:32]
        node _outputReg_T_1 = tail(_outputReg_T, 1) @[dut.scala 29:32]
        outputReg <= _outputReg_T_1 @[dut.scala 29:17]
        validReg <= UInt<1>("h1") @[dut.scala 30:16]
        accumulator <= UInt<1>("h0") @[dut.scala 31:19]
        counter <= UInt<1>("h0") @[dut.scala 32:15]
      else :
        validReg <= UInt<1>("h0") @[dut.scala 34:16]
    else :
      validReg <= UInt<1>("h0") @[dut.scala 37:14]


