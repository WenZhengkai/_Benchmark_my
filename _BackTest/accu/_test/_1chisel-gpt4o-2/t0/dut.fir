circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg sumReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:23]
    reg countReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 16:25]
    reg validOutReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:28]
    io.valid_out <= validOutReg @[dut.scala 22:16]
    io.data_out <= UInt<1>("h0") @[dut.scala 23:15]
    when io.valid_in : @[dut.scala 26:21]
      node _sumReg_T = add(sumReg, io.data_in) @[dut.scala 27:22]
      node _sumReg_T_1 = tail(_sumReg_T, 1) @[dut.scala 27:22]
      sumReg <= _sumReg_T_1 @[dut.scala 27:12]
      node _countReg_T = add(countReg, UInt<1>("h1")) @[dut.scala 28:26]
      node _countReg_T_1 = tail(_countReg_T, 1) @[dut.scala 28:26]
      countReg <= _countReg_T_1 @[dut.scala 28:14]
      node _T = eq(countReg, UInt<2>("h3")) @[dut.scala 30:19]
      when _T : @[dut.scala 30:28]
        node _io_data_out_T = add(sumReg, io.data_in) @[dut.scala 31:29]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 31:29]
        io.data_out <= _io_data_out_T_1 @[dut.scala 31:19]
        validOutReg <= UInt<1>("h1") @[dut.scala 32:19]
        sumReg <= UInt<1>("h0") @[dut.scala 33:14]
        countReg <= UInt<1>("h0") @[dut.scala 34:16]
      else :
        validOutReg <= UInt<1>("h0") @[dut.scala 36:19]
    else :
      validOutReg <= UInt<1>("h0") @[dut.scala 39:17]


