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
      reset => (reset, UInt<3>("h4")) @[dut.scala 17:19]
    io.dataOut <= UInt<1>("h0") @[dut.scala 20:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 23:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 23:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 24:18]
    io.FULL <= _io_FULL_T @[dut.scala 24:11]
    when io.EN : @[dut.scala 27:15]
      node _T = bits(reset, 0, 0) @[dut.scala 29:16]
      when _T : @[dut.scala 29:24]
        SP <= UInt<3>("h4") @[dut.scala 30:10]
        wire _WIRE : UInt<4>[4] @[dut.scala 31:27]
        _WIRE[0] <= UInt<4>("h0") @[dut.scala 31:27]
        _WIRE[1] <= UInt<4>("h0") @[dut.scala 31:27]
        _WIRE[2] <= UInt<4>("h0") @[dut.scala 31:27]
        _WIRE[3] <= UInt<4>("h0") @[dut.scala 31:27]
        stack_mem <= _WIRE @[dut.scala 31:17]
      else :
        when io.RW : @[dut.scala 33:19]
          node _T_1 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 35:14]
          when _T_1 : @[dut.scala 35:25]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 36:22]
            node _T_2 = bits(SP, 1, 0)
            stack_mem[_T_2] <= UInt<1>("h0") @[dut.scala 37:25]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 38:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 38:20]
            SP <= _SP_T_1 @[dut.scala 38:14]
        else :
          node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 42:14]
          when _T_3 : @[dut.scala 42:24]
            node _SP_T_2 = sub(SP, UInt<1>("h1")) @[dut.scala 43:20]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 43:20]
            SP <= _SP_T_3 @[dut.scala 43:14]
            node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 44:24]
            node _T_5 = tail(_T_4, 1) @[dut.scala 44:24]
            node _T_6 = bits(_T_5, 1, 0)
            stack_mem[_T_6] <= io.dataIn @[dut.scala 44:31]


