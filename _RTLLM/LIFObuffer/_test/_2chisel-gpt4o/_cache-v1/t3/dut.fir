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
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 20:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 20:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 21:18]
    io.FULL <= _io_FULL_T @[dut.scala 21:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 24:14]
    when io.EN : @[dut.scala 27:15]
      when io.RW : @[dut.scala 28:17]
        node _T = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 29:12]
        when _T : @[dut.scala 29:23]
          node _io_dataOut_T = bits(SP, 1, 0)
          io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 30:20]
          node _T_1 = bits(SP, 1, 0)
          stack_mem[_T_1] <= UInt<1>("h0") @[dut.scala 31:23]
          node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 32:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 32:18]
          SP <= _SP_T_1 @[dut.scala 32:12]
      else :
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 35:12]
        when _T_2 : @[dut.scala 35:22]
          node _SP_T_2 = sub(SP, UInt<1>("h1")) @[dut.scala 36:18]
          node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 36:18]
          SP <= _SP_T_3 @[dut.scala 36:12]
          node _T_3 = sub(SP, UInt<1>("h1")) @[dut.scala 37:22]
          node _T_4 = tail(_T_3, 1) @[dut.scala 37:22]
          node _T_5 = bits(_T_4, 1, 0)
          stack_mem[_T_5] <= io.dataIn @[dut.scala 37:29]


