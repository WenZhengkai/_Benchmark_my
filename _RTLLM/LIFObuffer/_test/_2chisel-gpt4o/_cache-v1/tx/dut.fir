circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
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
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 23:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 23:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 24:18]
    io.FULL <= _io_FULL_T @[dut.scala 24:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 25:14]
    when io.EN : @[dut.scala 28:15]
      node _T = bits(reset, 0, 0) @[dut.scala 29:22]
      when _T : @[dut.scala 29:26]
        sp <= UInt<3>("h4") @[dut.scala 31:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 33:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 33:22]
      else :
        when io.RW : @[dut.scala 35:23]
          node _T_1 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 37:12]
          when _T_1 : @[dut.scala 37:23]
            node _io_dataOut_T = bits(sp, 1, 0)
            io.dataOut <= stack_mem[_io_dataOut_T] @[dut.scala 38:20]
            node _T_2 = bits(sp, 1, 0)
            stack_mem[_T_2] <= UInt<1>("h0") @[dut.scala 39:23]
            node _sp_T = add(sp, UInt<1>("h1")) @[dut.scala 40:18]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 40:18]
            sp <= _sp_T_1 @[dut.scala 40:12]
        else :
          node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 44:12]
          when _T_3 : @[dut.scala 44:22]
            node _sp_T_2 = sub(sp, UInt<1>("h1")) @[dut.scala 45:18]
            node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 45:18]
            sp <= _sp_T_3 @[dut.scala 45:12]
            node _T_4 = bits(sp, 1, 0)
            stack_mem[_T_4] <= io.dataIn @[dut.scala 46:23]


