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
    node _T = bits(reset, 0, 0) @[dut.scala 19:20]
    when _T : @[dut.scala 19:24]
      SP <= UInt<3>("h4") @[dut.scala 20:8]
      wire _WIRE : UInt<4>[4] @[dut.scala 21:25]
      _WIRE[0] <= UInt<4>("h0") @[dut.scala 21:25]
      _WIRE[1] <= UInt<4>("h0") @[dut.scala 21:25]
      _WIRE[2] <= UInt<4>("h0") @[dut.scala 21:25]
      _WIRE[3] <= UInt<4>("h0") @[dut.scala 21:25]
      stack_mem <= _WIRE @[dut.scala 21:15]
    node isEmpty = eq(SP, UInt<3>("h4")) @[dut.scala 25:21]
    node isFull = eq(SP, UInt<1>("h0")) @[dut.scala 26:20]
    io.EMPTY <= isEmpty @[dut.scala 28:12]
    io.FULL <= isFull @[dut.scala 29:11]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 32:27]
    io.dataOut <= dataOutReg @[dut.scala 33:14]
    when io.EN : @[dut.scala 36:15]
      node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 37:16]
      node _T_2 = eq(isFull, UInt<1>("h0")) @[dut.scala 37:27]
      node _T_3 = and(_T_1, _T_2) @[dut.scala 37:24]
      when _T_3 : @[dut.scala 37:36]
        node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 39:16]
        node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 39:16]
        SP <= _SP_T_1 @[dut.scala 39:10]
        node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 40:20]
        node _T_5 = tail(_T_4, 1) @[dut.scala 40:20]
        node _T_6 = bits(_T_5, 1, 0)
        stack_mem[_T_6] <= io.dataIn @[dut.scala 40:27]
      else :
        node _T_7 = eq(io.RW, UInt<1>("h1")) @[dut.scala 41:22]
        node _T_8 = eq(isEmpty, UInt<1>("h0")) @[dut.scala 41:33]
        node _T_9 = and(_T_7, _T_8) @[dut.scala 41:30]
        when _T_9 : @[dut.scala 41:43]
          node _dataOutReg_T = bits(SP, 1, 0)
          dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 43:18]
          node _T_10 = bits(SP, 1, 0)
          stack_mem[_T_10] <= UInt<1>("h0") @[dut.scala 44:21]
          node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 45:16]
          node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 45:16]
          SP <= _SP_T_3 @[dut.scala 45:10]


