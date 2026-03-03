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
      reset => (reset, UInt<3>("h4")) @[dut.scala 20:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 22:27]
    io.dataOut <= dataOutReg @[dut.scala 23:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 26:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 26:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 27:19]
    io.FULL <= _io_FULL_T @[dut.scala 27:12]
    when io.EN : @[dut.scala 29:16]
      node _T = bits(reset, 0, 0) @[dut.scala 30:17]
      when _T : @[dut.scala 30:25]
        SP <= UInt<3>("h4") @[dut.scala 31:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 32:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 34:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 38:13]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 38:23]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 38:20]
        when _T_3 : @[dut.scala 38:33]
          node _nextSp_T = sub(SP, UInt<1>("h1")) @[dut.scala 40:25]
          node nextSp = tail(_nextSp_T, 1) @[dut.scala 40:25]
          node _T_4 = bits(nextSp, 1, 0)
          stack_mem[_T_4] <= io.dataIn @[dut.scala 41:27]
          SP <= nextSp @[dut.scala 42:12]
        else :
          node _T_5 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 45:27]
          node _T_6 = and(io.RW, _T_5) @[dut.scala 45:24]
          when _T_6 : @[dut.scala 45:38]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 47:20]
            node _T_7 = bits(SP, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 48:23]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 49:18]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 49:18]
            SP <= _SP_T_1 @[dut.scala 49:12]


