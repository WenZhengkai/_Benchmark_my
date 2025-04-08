circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 15:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 15:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 15:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 15:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 15:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 15:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 21:27]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 24:18]
    io.FULL <= _io_FULL_T @[dut.scala 24:11]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 27:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 27:12]
    io.dataOut <= dataOutReg @[dut.scala 30:14]
    when io.EN : @[dut.scala 33:15]
      when io.RW : @[dut.scala 34:17]
        node _T = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 35:12]
        when _T : @[dut.scala 35:23]
          node _dataOutReg_T = bits(SP, 1, 0)
          dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 36:20]
          node _T_1 = bits(SP, 1, 0)
          stack_mem[_T_1] <= UInt<1>("h0") @[dut.scala 37:23]
          node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 38:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 38:18]
          SP <= _SP_T_1 @[dut.scala 38:12]
      else :
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 41:12]
        when _T_2 : @[dut.scala 41:22]
          node _SP_T_2 = sub(SP, UInt<1>("h1")) @[dut.scala 42:18]
          node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 42:18]
          SP <= _SP_T_3 @[dut.scala 42:12]
          node _T_3 = sub(SP, UInt<1>("h1")) @[dut.scala 43:22]
          node _T_4 = tail(_T_3, 1) @[dut.scala 43:22]
          node _T_5 = bits(_T_4, 1, 0)
          stack_mem[_T_5] <= io.dataIn @[dut.scala 43:29]


