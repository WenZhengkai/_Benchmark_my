circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 18:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 18:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 18:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 18:26]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 22:19]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 25:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 25:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 26:18]
    io.FULL <= _io_FULL_T @[dut.scala 26:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 27:14]
    when io.EN : @[dut.scala 29:15]
      node _T = bits(reset, 0, 0) @[dut.scala 30:16]
      when _T : @[dut.scala 30:24]
        SP <= UInt<3>("h4") @[dut.scala 32:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 34:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 36:16]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 36:26]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 36:23]
        when _T_3 : @[dut.scala 36:36]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 38:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 38:20]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 38:27]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 39:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 39:16]
          SP <= _SP_T_1 @[dut.scala 39:10]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 40:25]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 40:22]
          when _T_8 : @[dut.scala 40:36]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 42:18]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 43:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 44:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 44:16]
            SP <= _SP_T_3 @[dut.scala 44:10]
    node _T_10 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 49:8]
    when _T_10 : @[dut.scala 49:19]
      node _io_dataOut_T_1 = bits(SP, 1, 0)
      io.dataOut <= stack_mem[_io_dataOut_T_1] @[dut.scala 50:16]


