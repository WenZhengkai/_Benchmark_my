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
      reset => (reset, UInt<3>("h4")) @[dut.scala 19:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 22:27]
    io.dataOut <= dataOutReg @[dut.scala 23:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 26:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 26:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 27:19]
    io.FULL <= _io_FULL_T @[dut.scala 27:12]
    node _T = bits(reset, 0, 0) @[dut.scala 29:15]
    when _T : @[dut.scala 29:23]
      SP <= UInt<3>("h4") @[dut.scala 30:8]
      dataOutReg <= UInt<1>("h0") @[dut.scala 31:16]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 32:41]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 32:41]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 32:41]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 32:41]
    else :
      when io.EN : @[dut.scala 33:23]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 34:11]
        when _T_1 : @[dut.scala 34:19]
          node _T_2 = neq(SP, UInt<1>("h0")) @[dut.scala 35:16]
          when _T_2 : @[dut.scala 35:25]
            node _nextSp_T = sub(SP, UInt<1>("h1")) @[dut.scala 36:25]
            node nextSp = tail(_nextSp_T, 1) @[dut.scala 36:25]
            node _T_3 = bits(nextSp, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 37:27]
            SP <= nextSp @[dut.scala 38:12]
        else :
          node _T_4 = neq(SP, UInt<3>("h4")) @[dut.scala 41:16]
          when _T_4 : @[dut.scala 41:25]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 42:20]
            node _T_5 = bits(SP, 1, 0)
            stack_mem[_T_5] <= UInt<1>("h0") @[dut.scala 43:23]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 44:18]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 44:18]
            SP <= _SP_T_1 @[dut.scala 44:12]


