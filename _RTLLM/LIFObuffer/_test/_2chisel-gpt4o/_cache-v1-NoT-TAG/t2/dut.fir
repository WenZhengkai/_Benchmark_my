circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 16:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 16:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 16:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 16:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 16:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 16:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 17:19]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 20:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 20:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 21:18]
    io.FULL <= _io_FULL_T @[dut.scala 21:11]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 24:27]
    io.dataOut <= dataOutReg @[dut.scala 25:14]
    node _T = bits(reset, 0, 0) @[dut.scala 30:20]
    when _T : @[dut.scala 30:24]
      SP <= UInt<3>("h4") @[dut.scala 31:8]
      dataOutReg <= UInt<1>("h0") @[dut.scala 32:16]
    node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 36:17]
    node _T_2 = and(io.EN, _T_1) @[dut.scala 36:14]
    when _T_2 : @[dut.scala 36:25]
      node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 37:10]
      when _T_3 : @[dut.scala 37:20]
        node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 38:16]
        node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 38:16]
        SP <= _SP_T_1 @[dut.scala 38:10]
        node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 39:20]
        node _T_5 = tail(_T_4, 1) @[dut.scala 39:20]
        node _T_6 = bits(_T_5, 1, 0)
        stack_mem[_T_6] <= io.dataIn @[dut.scala 39:27]
    node _T_7 = and(io.EN, io.RW) @[dut.scala 44:14]
    when _T_7 : @[dut.scala 44:24]
      node _T_8 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 45:10]
      when _T_8 : @[dut.scala 45:21]
        node _dataOutReg_T = bits(SP, 1, 0)
        dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 46:18]
        node _T_9 = bits(SP, 1, 0)
        stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 47:21]
        node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 48:16]
        node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 48:16]
        SP <= _SP_T_3 @[dut.scala 48:10]


