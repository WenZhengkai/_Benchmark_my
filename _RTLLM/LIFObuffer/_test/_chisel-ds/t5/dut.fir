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
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:19]
    reg EMPTY : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 17:22]
    reg FULL : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:21]
    node _EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 21:15]
    EMPTY <= _EMPTY_T @[dut.scala 21:9]
    node _FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 22:14]
    FULL <= _FULL_T @[dut.scala 22:8]
    when io.EN : @[dut.scala 25:15]
      node _T = bits(reset, 0, 0) @[dut.scala 26:16]
      when _T : @[dut.scala 26:24]
        SP <= UInt<3>("h4") @[dut.scala 28:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 29:27]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 29:27]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 29:27]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 29:27]
        EMPTY <= UInt<1>("h1") @[dut.scala 30:13]
        FULL <= UInt<1>("h0") @[dut.scala 31:12]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 33:12]
        node _T_2 = eq(FULL, UInt<1>("h0")) @[dut.scala 33:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 33:19]
        when _T_3 : @[dut.scala 33:29]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 35:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 35:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 35:29]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 36:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 36:18]
          SP <= _SP_T_1 @[dut.scala 36:12]
        else :
          node _T_7 = eq(EMPTY, UInt<1>("h0")) @[dut.scala 37:27]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 37:24]
          when _T_8 : @[dut.scala 37:35]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 39:20]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 40:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 41:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 41:18]
            SP <= _SP_T_3 @[dut.scala 41:12]
    io.EMPTY <= EMPTY @[dut.scala 47:12]
    io.FULL <= FULL @[dut.scala 48:11]
    node _io_dataOut_T_1 = bits(SP, 1, 0)
    io.dataOut <= stack_mem[_io_dataOut_T_1] @[dut.scala 49:14]

