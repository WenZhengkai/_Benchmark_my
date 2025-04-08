circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 20:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 20:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 20:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 20:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 20:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 20:26]
    reg SP : UInt, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 21:19]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:18]
    io.FULL <= _io_FULL_T @[dut.scala 25:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 28:14]
    node _T = bits(reset, 0, 0) @[dut.scala 31:14]
    when _T : @[dut.scala 31:22]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 34:20]
      SP <= UInt<3>("h4") @[dut.scala 36:8]
    else :
      when io.EN : @[dut.scala 37:21]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 38:10]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 38:20]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 38:17]
        when _T_3 : @[dut.scala 38:30]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 39:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 39:20]
          node _T_6 = or(_T_5, UInt<2>("h0"))
          node _T_7 = bits(_T_6, 1, 0)
          stack_mem[_T_7] <= io.dataIn @[dut.scala 39:27]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 40:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 40:16]
          SP <= _SP_T_1 @[dut.scala 40:10]
        else :
          node _T_8 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 41:25]
          node _T_9 = and(io.RW, _T_8) @[dut.scala 41:22]
          when _T_9 : @[dut.scala 41:36]
            node _io_dataOut_T = or(SP, UInt<2>("h0"))
            node _io_dataOut_T_1 = bits(_io_dataOut_T, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T_1] @[dut.scala 42:18]
            node _T_10 = or(SP, UInt<2>("h0"))
            node _T_11 = bits(_T_10, 1, 0)
            stack_mem[_T_11] <= UInt<1>("h0") @[dut.scala 43:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 44:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 44:16]
            SP <= _SP_T_3 @[dut.scala 44:10]


