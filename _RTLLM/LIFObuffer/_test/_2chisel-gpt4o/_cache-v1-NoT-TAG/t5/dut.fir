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
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 22:27]
    node _T = eq(io.RW, UInt<1>("h0")) @[dut.scala 25:17]
    node _T_1 = and(io.EN, _T) @[dut.scala 25:14]
    when _T_1 : @[dut.scala 25:25]
      node _T_2 = neq(SP, UInt<1>("h0")) @[dut.scala 26:13]
      when _T_2 : @[dut.scala 26:22]
        node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 27:16]
        node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 27:16]
        SP <= _SP_T_1 @[dut.scala 27:10]
        node _T_3 = sub(SP, UInt<1>("h1")) @[dut.scala 28:20]
        node _T_4 = tail(_T_3, 1) @[dut.scala 28:20]
        node _T_5 = bits(_T_4, 1, 0)
        stack_mem[_T_5] <= io.dataIn @[dut.scala 28:27]
    node _T_6 = and(io.EN, io.RW) @[dut.scala 33:14]
    when _T_6 : @[dut.scala 33:24]
      node _T_7 = neq(SP, UInt<3>("h4")) @[dut.scala 34:13]
      when _T_7 : @[dut.scala 34:22]
        node _dataOutReg_T = bits(SP, 1, 0)
        dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 35:18]
        node _T_8 = bits(SP, 1, 0)
        stack_mem[_T_8] <= UInt<1>("h0") @[dut.scala 36:21]
        node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 37:16]
        node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 37:16]
        SP <= _SP_T_3 @[dut.scala 37:10]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 42:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 42:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 43:18]
    io.FULL <= _io_FULL_T @[dut.scala 43:11]
    io.dataOut <= dataOutReg @[dut.scala 46:14]

