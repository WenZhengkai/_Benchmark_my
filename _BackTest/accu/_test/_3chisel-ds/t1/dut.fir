circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:28]
    reg counter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:24]
    reg outputReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 15:26]
    reg validOutReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:28]
    when io.valid_in : @[dut.scala 18:21]
      node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 20:32]
      node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 20:32]
      accumulator <= _accumulator_T_1 @[dut.scala 20:17]
      node _counter_T = add(counter, UInt<1>("h1")) @[dut.scala 21:24]
      node _counter_T_1 = tail(_counter_T, 1) @[dut.scala 21:24]
      counter <= _counter_T_1 @[dut.scala 21:13]
      node _T = eq(counter, UInt<2>("h3")) @[dut.scala 24:18]
      when _T : @[dut.scala 24:27]
        node _outputReg_T = add(accumulator, io.data_in) @[dut.scala 25:32]
        node _outputReg_T_1 = tail(_outputReg_T, 1) @[dut.scala 25:32]
        outputReg <= _outputReg_T_1 @[dut.scala 25:17]
        validOutReg <= UInt<1>("h1") @[dut.scala 26:19]
        accumulator <= UInt<1>("h0") @[dut.scala 27:19]
        counter <= UInt<1>("h0") @[dut.scala 28:15]
      else :
        validOutReg <= UInt<1>("h0") @[dut.scala 30:19]
    else :
      validOutReg <= UInt<1>("h0") @[dut.scala 33:17]
    io.data_out <= outputReg @[dut.scala 36:15]
    io.valid_out <= validOutReg @[dut.scala 37:16]

