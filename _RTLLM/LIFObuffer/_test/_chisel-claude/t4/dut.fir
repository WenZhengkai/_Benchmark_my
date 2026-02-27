circuit dut :
  module LIFO :
    input clock : Clock
    input reset : Reset
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 19:34]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 19:34]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 19:34]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 19:34]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 19:34]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 19:26]
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 20:19]
    io.dataOut <= UInt<1>("h0") @[dut.scala 23:14]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 24:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 25:18]
    io.FULL <= _io_FULL_T @[dut.scala 25:11]
    when io.EN : @[dut.scala 28:15]
      node _T = asUInt(reset) @[dut.scala 29:16]
      when _T : @[dut.scala 29:24]
        sp <= UInt<3>("h4") @[dut.scala 31:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 33:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 36:12]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 36:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 36:19]
        when _T_3 : @[dut.scala 36:32]
          node _sp_T = sub(sp, UInt<1>("h1")) @[dut.scala 38:18]
          node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 38:18]
          sp <= _sp_T_1 @[dut.scala 38:12]
          node _T_4 = sub(sp, UInt<1>("h1")) @[dut.scala 39:22]
          node _T_5 = tail(_T_4, 1) @[dut.scala 39:22]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 39:29]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 40:27]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 40:24]
          when _T_8 : @[dut.scala 40:38]
            node _io_dataOut_T = bits(sp, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 42:20]
            node _T_9 = bits(sp, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 43:23]
            node _sp_T_2 = add(sp, UInt<1>("h1")) @[dut.scala 44:18]
            node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 44:18]
            sp <= _sp_T_3 @[dut.scala 44:12]


  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    inst lifo of LIFO @[dut.scala 62:20]
    lifo.clock <= clock
    lifo.reset <= reset
    lifo.io.dataIn <= io.dataIn @[dut.scala 65:18]
    lifo.io.RW <= io.RW @[dut.scala 66:14]
    lifo.io.EN <= io.EN @[dut.scala 67:14]
    io.EMPTY <= lifo.io.EMPTY @[dut.scala 69:12]
    io.FULL <= lifo.io.FULL @[dut.scala 70:11]
    io.dataOut <= lifo.io.dataOut @[dut.scala 71:14]

