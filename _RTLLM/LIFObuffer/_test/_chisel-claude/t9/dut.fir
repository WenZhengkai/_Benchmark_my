circuit dut :
  module LIFO :
    input clock : Clock
    input reset : Reset
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 18:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 18:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 18:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 19:19]
    reg emptyReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 22:25]
    reg fullReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 23:24]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 24:27]
    io.EMPTY <= emptyReg @[dut.scala 27:12]
    io.FULL <= fullReg @[dut.scala 28:11]
    io.dataOut <= dataOutReg @[dut.scala 29:14]
    when io.EN : @[dut.scala 31:15]
      node _T = asUInt(reset) @[dut.scala 32:16]
      when _T : @[dut.scala 32:24]
        SP <= UInt<3>("h4") @[dut.scala 34:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 36:22]
        emptyReg <= UInt<1>("h1") @[dut.scala 38:16]
        fullReg <= UInt<1>("h0") @[dut.scala 39:15]
        dataOutReg <= UInt<1>("h0") @[dut.scala 40:18]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 43:12]
        node _T_2 = eq(fullReg, UInt<1>("h0")) @[dut.scala 43:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 43:19]
        when _T_3 : @[dut.scala 43:32]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 44:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 44:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 44:29]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 45:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 45:18]
          SP <= _SP_T_1 @[dut.scala 45:12]
          emptyReg <= UInt<1>("h0") @[dut.scala 46:18]
          node _fullReg_T = sub(SP, UInt<1>("h1")) @[dut.scala 47:24]
          node _fullReg_T_1 = tail(_fullReg_T, 1) @[dut.scala 47:24]
          node _fullReg_T_2 = eq(_fullReg_T_1, UInt<1>("h0")) @[dut.scala 47:31]
          fullReg <= _fullReg_T_2 @[dut.scala 47:17]
        node _T_7 = eq(emptyReg, UInt<1>("h0")) @[dut.scala 51:21]
        node _T_8 = and(io.RW, _T_7) @[dut.scala 51:18]
        when _T_8 : @[dut.scala 51:32]
          node _dataOutReg_T = bits(SP, 1, 0)
          dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 52:20]
          node _T_9 = bits(SP, 1, 0)
          stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 53:23]
          node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 54:18]
          node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 54:18]
          SP <= _SP_T_3 @[dut.scala 54:12]
          fullReg <= UInt<1>("h0") @[dut.scala 55:17]
          node _emptyReg_T = add(SP, UInt<1>("h1")) @[dut.scala 56:25]
          node _emptyReg_T_1 = tail(_emptyReg_T, 1) @[dut.scala 56:25]
          node _emptyReg_T_2 = eq(_emptyReg_T_1, UInt<3>("h4")) @[dut.scala 56:32]
          emptyReg <= _emptyReg_T_2 @[dut.scala 56:18]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    inst lifo of LIFO @[dut.scala 74:20]
    lifo.clock <= clock
    lifo.reset <= reset
    lifo.io.dataIn <= io.dataIn @[dut.scala 77:18]
    lifo.io.RW <= io.RW @[dut.scala 78:14]
    lifo.io.EN <= io.EN @[dut.scala 79:14]
    io.EMPTY <= lifo.io.EMPTY @[dut.scala 81:12]
    io.FULL <= lifo.io.FULL @[dut.scala 82:11]
    io.dataOut <= lifo.io.dataOut @[dut.scala 83:14]

