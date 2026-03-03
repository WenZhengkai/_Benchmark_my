circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 14:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 14:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 14:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 14:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 14:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 14:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:27]
    when io.EN : @[dut.scala 19:15]
      node _T = bits(reset, 0, 0) @[dut.scala 20:16]
      when _T : @[dut.scala 20:24]
        SP <= UInt<3>("h4") @[dut.scala 21:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 22:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 24:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 24:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 24:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 24:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 28:12]
        node _T_2 = neq(SP, UInt<1>("h0")) @[dut.scala 28:26]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 28:19]
        when _T_3 : @[dut.scala 28:36]
          node _nextSP_T = sub(SP, UInt<1>("h1")) @[dut.scala 29:25]
          node nextSP = tail(_nextSP_T, 1) @[dut.scala 29:25]
          node _T_4 = bits(nextSP, 1, 0)
          stack_mem[_T_4] <= io.dataIn @[dut.scala 30:27]
          SP <= nextSP @[dut.scala 31:12]
        else :
          node _T_5 = neq(SP, UInt<3>("h4")) @[dut.scala 34:30]
          node _T_6 = and(io.RW, _T_5) @[dut.scala 34:23]
          when _T_6 : @[dut.scala 34:40]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 35:20]
            node _T_7 = bits(SP, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 36:23]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 37:18]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 37:18]
            SP <= _SP_T_1 @[dut.scala 37:12]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 42:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 42:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 43:19]
    io.FULL <= _io_FULL_T @[dut.scala 43:12]
    io.dataOut <= dataOutReg @[dut.scala 44:14]

