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
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:18]
    io.FULL <= _io_FULL_T @[dut.scala 25:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 28:14]
    when io.EN : @[dut.scala 31:16]
      node _T = bits(reset, 0, 0) @[dut.scala 32:18]
      node _T_1 = eq(_T, UInt<1>("h0")) @[dut.scala 32:11]
      when _T_1 : @[dut.scala 32:26]
        node _T_2 = eq(io.RW, UInt<1>("h0")) @[dut.scala 33:19]
        node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 33:34]
        node _T_4 = and(_T_2, _T_3) @[dut.scala 33:31]
        when _T_4 : @[dut.scala 33:44]
          node _T_5 = sub(SP, UInt<1>("h1")) @[dut.scala 34:22]
          node _T_6 = tail(_T_5, 1) @[dut.scala 34:22]
          node _T_7 = bits(_T_6, 1, 0)
          stack_mem[_T_7] <= io.dataIn @[dut.scala 34:29]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 35:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 35:18]
          SP <= _SP_T_1 @[dut.scala 35:12]
        else :
          node _T_8 = eq(io.RW, UInt<1>("h1")) @[dut.scala 36:26]
          node _T_9 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 36:40]
          node _T_10 = and(_T_8, _T_9) @[dut.scala 36:37]
          when _T_10 : @[dut.scala 36:51]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 37:20]
            node _T_11 = bits(SP, 1, 0)
            stack_mem[_T_11] <= UInt<1>("h0") @[dut.scala 38:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 39:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 39:18]
            SP <= _SP_T_3 @[dut.scala 39:12]
    node _T_12 = bits(reset, 0, 0) @[dut.scala 45:15]
    when _T_12 : @[dut.scala 45:23]
      wire _WIRE : UInt<4>[4] @[dut.scala 46:25]
      _WIRE[0] <= UInt<4>("h0") @[dut.scala 46:25]
      _WIRE[1] <= UInt<4>("h0") @[dut.scala 46:25]
      _WIRE[2] <= UInt<4>("h0") @[dut.scala 46:25]
      _WIRE[3] <= UInt<4>("h0") @[dut.scala 46:25]
      stack_mem <= _WIRE @[dut.scala 46:15]
      SP <= UInt<3>("h4") @[dut.scala 47:8]


