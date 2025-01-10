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
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 19:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 19:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 20:18]
    io.FULL <= _io_FULL_T @[dut.scala 20:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 22:14]
    when io.EN : @[dut.scala 24:16]
      node _T = bits(reset, 0, 0) @[dut.scala 25:17]
      when _T : @[dut.scala 25:25]
        SP <= UInt<3>("h4") @[dut.scala 26:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 28:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 28:22]
      else :
        when io.RW : @[dut.scala 31:20]
          node _T_1 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 32:15]
          when _T_1 : @[dut.scala 32:26]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 33:22]
            node _T_2 = bits(SP, 1, 0)
            stack_mem[_T_2] <= UInt<1>("h0") @[dut.scala 34:25]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 35:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 35:20]
            SP <= _SP_T_1 @[dut.scala 35:14]
        else :
          node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 38:15]
          when _T_3 : @[dut.scala 38:25]
            node _SP_T_2 = sub(SP, UInt<1>("h1")) @[dut.scala 39:20]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 39:20]
            SP <= _SP_T_3 @[dut.scala 39:14]
            node _T_4 = bits(SP, 1, 0)
            stack_mem[_T_4] <= io.dataIn @[dut.scala 40:25]


