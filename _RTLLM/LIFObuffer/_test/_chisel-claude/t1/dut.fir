circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 17:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 17:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 17:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 17:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 17:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 17:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:19]
    reg emptyReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 21:25]
    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 22:24]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:27]
    node _emptyReg_T = eq(SP, UInt<3>("h4")) @[dut.scala 26:19]
    emptyReg <= _emptyReg_T @[dut.scala 26:12]
    node _fullReg_T = eq(SP, UInt<1>("h0")) @[dut.scala 27:18]
    fullReg <= _fullReg_T @[dut.scala 27:11]
    io.EMPTY <= emptyReg @[dut.scala 30:12]
    io.FULL <= fullReg @[dut.scala 31:11]
    io.dataOut <= dataOutReg @[dut.scala 32:14]
    when io.EN : @[dut.scala 35:15]
      node _T = bits(reset, 0, 0) @[dut.scala 36:16]
      when _T : @[dut.scala 36:24]
        SP <= UInt<3>("h4") @[dut.scala 38:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 39:27]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 39:27]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 39:27]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 39:27]
        dataOutReg <= UInt<1>("h0") @[dut.scala 40:18]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 41:16]
        node _T_2 = eq(fullReg, UInt<1>("h0")) @[dut.scala 41:26]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 41:23]
        when _T_3 : @[dut.scala 41:36]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 43:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 43:20]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 43:27]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 44:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 44:16]
          SP <= _SP_T_1 @[dut.scala 44:10]
        else :
          node _T_7 = eq(emptyReg, UInt<1>("h0")) @[dut.scala 45:25]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 45:22]
          when _T_8 : @[dut.scala 45:36]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 47:18]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 48:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 49:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 49:16]
            SP <= _SP_T_3 @[dut.scala 49:10]


