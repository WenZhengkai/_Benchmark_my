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
    when io.EN : @[dut.scala 23:15]
      node _T = bits(reset, 0, 0) @[dut.scala 24:16]
      when _T : @[dut.scala 24:24]
        SP <= UInt<3>("h4") @[dut.scala 25:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 26:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 28:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 32:12]
        node _T_2 = neq(SP, UInt<1>("h0")) @[dut.scala 32:26]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 32:19]
        when _T_3 : @[dut.scala 32:36]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 33:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 33:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 33:29]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 34:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 34:18]
          SP <= _SP_T_1 @[dut.scala 34:12]
        else :
          node _T_7 = neq(SP, UInt<3>("h4")) @[dut.scala 37:30]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 37:23]
          when _T_8 : @[dut.scala 37:40]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 38:20]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 39:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 40:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 40:18]
            SP <= _SP_T_3 @[dut.scala 40:12]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 45:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 45:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 46:19]
    io.FULL <= _io_FULL_T @[dut.scala 46:12]
    io.dataOut <= dataOutReg @[dut.scala 47:14]

