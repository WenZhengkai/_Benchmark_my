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
    io.dataOut <= UInt<1>("h0") @[dut.scala 21:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:19]
    io.FULL <= _io_FULL_T @[dut.scala 25:12]
    when io.EN : @[dut.scala 27:15]
      node _T = bits(reset, 0, 0) @[dut.scala 28:16]
      when _T : @[dut.scala 28:24]
        SP <= UInt<3>("h4") @[dut.scala 30:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 32:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 32:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 32:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 32:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 35:12]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 35:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 35:19]
        when _T_3 : @[dut.scala 35:32]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 37:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 37:18]
          SP <= _SP_T_1 @[dut.scala 37:12]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 38:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 38:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 38:29]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 39:28]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 39:25]
          when _T_8 : @[dut.scala 39:39]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 41:20]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 42:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 43:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 43:18]
            SP <= _SP_T_3 @[dut.scala 43:12]
    node _T_10 = and(io.EN, io.RW) @[dut.scala 49:14]
    node _T_11 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 49:26]
    node _T_12 = and(_T_10, _T_11) @[dut.scala 49:23]
    when _T_12 : @[dut.scala 49:37]
      node _io_dataOut_T_1 = bits(SP, 1, 0)
      io.dataOut <= stack_mem[_io_dataOut_T_1] @[dut.scala 50:16]


