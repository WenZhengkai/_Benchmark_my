circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 18:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 18:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 18:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 21:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 24:27]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 27:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 27:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 28:18]
    io.FULL <= _io_FULL_T @[dut.scala 28:11]
    io.dataOut <= dataOutReg @[dut.scala 31:14]
    node _T = eq(io.RW, UInt<1>("h0")) @[dut.scala 34:17]
    node _T_1 = and(io.EN, _T) @[dut.scala 34:14]
    node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 34:27]
    node _T_3 = and(_T_1, _T_2) @[dut.scala 34:24]
    when _T_3 : @[dut.scala 34:37]
      node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 35:14]
      node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 35:14]
      SP <= _SP_T_1 @[dut.scala 35:8]
      node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 36:18]
      node _T_5 = tail(_T_4, 1) @[dut.scala 36:18]
      node _T_6 = bits(_T_5, 1, 0)
      stack_mem[_T_6] <= io.dataIn @[dut.scala 36:25]
    node _T_7 = and(io.EN, io.RW) @[dut.scala 40:14]
    node _T_8 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 40:26]
    node _T_9 = and(_T_7, _T_8) @[dut.scala 40:23]
    when _T_9 : @[dut.scala 40:37]
      node _dataOutReg_T = bits(SP, 1, 0)
      dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 41:16]
      node _T_10 = bits(SP, 1, 0)
      stack_mem[_T_10] <= UInt<1>("h0") @[dut.scala 42:19]
      node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 43:14]
      node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 43:14]
      SP <= _SP_T_3 @[dut.scala 43:8]


