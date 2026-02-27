circuit dut :
  module LIFO :
    input clock : Clock
    input reset : Reset
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
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:18]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:17]
    io.FULL <= _io_FULL_T @[dut.scala 25:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 28:14]
    when io.EN : @[dut.scala 30:15]
      node _T = asUInt(reset) @[dut.scala 31:16]
      when _T : @[dut.scala 31:24]
        SP <= UInt<3>("h4") @[dut.scala 33:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 35:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 35:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 35:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 35:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 38:12]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 38:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 38:19]
        when _T_3 : @[dut.scala 38:32]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 40:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 40:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 40:29]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 41:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 41:18]
          SP <= _SP_T_1 @[dut.scala 41:12]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 42:27]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 42:24]
          when _T_8 : @[dut.scala 42:38]
            node _io_dataOut_T = bits(SP, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 44:20]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 45:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 46:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 46:18]
            SP <= _SP_T_3 @[dut.scala 46:12]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    inst lifo of LIFO @[dut.scala 63:20]
    lifo.clock <= clock
    lifo.reset <= reset
    lifo.io.dataIn <= io.dataIn @[dut.scala 66:18]
    lifo.io.RW <= io.RW @[dut.scala 67:14]
    lifo.io.EN <= io.EN @[dut.scala 68:14]
    io.EMPTY <= lifo.io.EMPTY @[dut.scala 71:12]
    io.FULL <= lifo.io.FULL @[dut.scala 72:11]
    io.dataOut <= lifo.io.dataOut @[dut.scala 73:14]

