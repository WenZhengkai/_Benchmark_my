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
      reset => (reset, UInt<3>("h4")) @[dut.scala 21:19]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:19]
    io.FULL <= _io_FULL_T @[dut.scala 25:12]
    io.dataOut <= UInt<1>("h0") @[dut.scala 28:14]
    node _T = bits(reset, 0, 0) @[dut.scala 31:14]
    when _T : @[dut.scala 31:22]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 34:20]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 34:20]
      SP <= UInt<3>("h4") @[dut.scala 36:8]
    else :
      when io.EN : @[dut.scala 37:22]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 38:16]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 38:27]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 38:24]
        when _T_3 : @[dut.scala 38:37]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 39:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 39:16]
          SP <= _SP_T_1 @[dut.scala 39:10]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 40:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 40:20]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 40:27]
        else :
          node _T_7 = eq(io.RW, UInt<1>("h1")) @[dut.scala 41:23]
          node _T_8 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 41:34]
          node _T_9 = and(_T_7, _T_8) @[dut.scala 41:31]
          when _T_9 : @[dut.scala 41:45]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 42:18]
            node _T_10 = bits(SP, 1, 0)
            stack_mem[_T_10] <= UInt<1>("h0") @[dut.scala 43:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 44:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 44:16]
            SP <= _SP_T_3 @[dut.scala 44:10]


