circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, data_out : UInt<10>, valid_out : UInt<1>}

    reg sumReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:23]
    reg countReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:25]
    reg outputReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 15:26]
    reg validOutReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 16:28]
    when io.valid_in : @[dut.scala 18:21]
      node _sumReg_T = add(sumReg, io.data_in) @[dut.scala 20:22]
      node _sumReg_T_1 = tail(_sumReg_T, 1) @[dut.scala 20:22]
      sumReg <= _sumReg_T_1 @[dut.scala 20:12]
      node _countReg_T = add(countReg, UInt<1>("h1")) @[dut.scala 21:26]
      node _countReg_T_1 = tail(_countReg_T, 1) @[dut.scala 21:26]
      countReg <= _countReg_T_1 @[dut.scala 21:14]
      node _T = eq(countReg, UInt<2>("h3")) @[dut.scala 24:19]
      when _T : @[dut.scala 24:28]
        node _outputReg_T = add(sumReg, io.data_in) @[dut.scala 25:27]
        node _outputReg_T_1 = tail(_outputReg_T, 1) @[dut.scala 25:27]
        outputReg <= _outputReg_T_1 @[dut.scala 25:17]
        validOutReg <= UInt<1>("h1") @[dut.scala 26:19]
        sumReg <= UInt<1>("h0") @[dut.scala 27:14]
        countReg <= UInt<1>("h0") @[dut.scala 28:16]
      else :
        validOutReg <= UInt<1>("h0") @[dut.scala 30:19]
    else :
      validOutReg <= UInt<1>("h0") @[dut.scala 33:17]
    io.data_out <= outputReg @[dut.scala 36:15]
    io.valid_out <= validOutReg @[dut.scala 37:16]

