circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, data_out : UInt<10>, valid_out : UInt<1>}

    reg sumReg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:23]
    reg countReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:25]
    io.data_out <= UInt<1>("h0") @[dut.scala 17:15]
    io.valid_out <= UInt<1>("h0") @[dut.scala 18:16]
    when io.valid_in : @[dut.scala 20:21]
      node _T = eq(countReg, UInt<2>("h3")) @[dut.scala 21:19]
      when _T : @[dut.scala 21:28]
        node _io_data_out_T = add(sumReg, io.data_in) @[dut.scala 23:29]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 23:29]
        io.data_out <= _io_data_out_T_1 @[dut.scala 23:19]
        io.valid_out <= UInt<1>("h1") @[dut.scala 24:20]
        sumReg <= UInt<1>("h0") @[dut.scala 25:14]
        countReg <= UInt<1>("h0") @[dut.scala 26:16]
      else :
        node _sumReg_T = add(sumReg, io.data_in) @[dut.scala 29:24]
        node _sumReg_T_1 = tail(_sumReg_T, 1) @[dut.scala 29:24]
        sumReg <= _sumReg_T_1 @[dut.scala 29:14]
        node _countReg_T = add(countReg, UInt<1>("h1")) @[dut.scala 30:28]
        node _countReg_T_1 = tail(_countReg_T, 1) @[dut.scala 30:28]
        countReg <= _countReg_T_1 @[dut.scala 30:16]


