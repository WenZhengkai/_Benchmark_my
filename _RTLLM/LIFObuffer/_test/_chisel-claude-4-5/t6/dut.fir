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
    reg dataOut_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 21:28]
    node _T = bits(reset, 0, 0) @[dut.scala 23:14]
    when _T : @[dut.scala 23:22]
      SP <= UInt<3>("h4") @[dut.scala 25:8]
      wire _WIRE : UInt<4>[4] @[dut.scala 26:25]
      _WIRE[0] <= UInt<4>("h0") @[dut.scala 26:25]
      _WIRE[1] <= UInt<4>("h0") @[dut.scala 26:25]
      _WIRE[2] <= UInt<4>("h0") @[dut.scala 26:25]
      _WIRE[3] <= UInt<4>("h0") @[dut.scala 26:25]
      stack_mem <= _WIRE @[dut.scala 26:15]
      dataOut_reg <= UInt<1>("h0") @[dut.scala 27:17]
    else :
      when io.EN : @[dut.scala 28:22]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 29:10]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 29:20]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 29:17]
        when _T_3 : @[dut.scala 29:30]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 31:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 31:16]
          SP <= _SP_T_1 @[dut.scala 31:10]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 32:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 32:20]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 32:27]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 33:26]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 33:23]
          when _T_8 : @[dut.scala 33:37]
            node _dataOut_reg_T = bits(SP, 1, 0)
            dataOut_reg <= stack_mem[_dataOut_reg_T] @[dut.scala 35:19]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 36:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 37:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 37:16]
            SP <= _SP_T_3 @[dut.scala 37:10]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 42:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 42:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 43:18]
    io.FULL <= _io_FULL_T @[dut.scala 43:11]
    io.dataOut <= dataOut_reg @[dut.scala 46:14]

