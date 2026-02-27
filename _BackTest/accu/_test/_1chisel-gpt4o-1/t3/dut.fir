circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : UInt<8>, flip valid_in : UInt<1>, valid_out : UInt<1>, data_out : UInt<10>}

    reg accumulator : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[dut.scala 13:28]
    reg dataCounter : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 14:28]
    reg validOut : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 15:25]
    io.valid_out <= validOut @[dut.scala 18:16]
    io.data_out <= UInt<1>("h0") @[dut.scala 19:15]
    when io.valid_in : @[dut.scala 21:21]
      node _accumulator_T = add(accumulator, io.data_in) @[dut.scala 22:32]
      node _accumulator_T_1 = tail(_accumulator_T, 1) @[dut.scala 22:32]
      accumulator <= _accumulator_T_1 @[dut.scala 22:17]
      node _dataCounter_T = add(dataCounter, UInt<1>("h1")) @[dut.scala 23:32]
      node _dataCounter_T_1 = tail(_dataCounter_T, 1) @[dut.scala 23:32]
      dataCounter <= _dataCounter_T_1 @[dut.scala 23:17]
      node _T = eq(dataCounter, UInt<2>("h3")) @[dut.scala 25:22]
      when _T : @[dut.scala 25:31]
        node _io_data_out_T = add(accumulator, io.data_in) @[dut.scala 27:34]
        node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[dut.scala 27:34]
        io.data_out <= _io_data_out_T_1 @[dut.scala 27:19]
        validOut <= UInt<1>("h1") @[dut.scala 28:16]
        accumulator <= UInt<1>("h0") @[dut.scala 29:19]
        dataCounter <= UInt<1>("h0") @[dut.scala 30:19]
      else :
        validOut <= UInt<1>("h0") @[dut.scala 32:16]
    else :
      validOut <= UInt<1>("h0") @[dut.scala 35:14]


