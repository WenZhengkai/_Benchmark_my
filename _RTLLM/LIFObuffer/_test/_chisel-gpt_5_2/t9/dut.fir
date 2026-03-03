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
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 20:27]
    io.dataOut <= dataOutReg @[dut.scala 21:14]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 23:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 23:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 24:19]
    io.FULL <= _io_FULL_T @[dut.scala 24:12]
    when io.EN : @[dut.scala 26:15]
      node _T = bits(reset, 0, 0) @[dut.scala 27:16]
      when _T : @[dut.scala 27:24]
        sp <= UInt<3>("h4") @[dut.scala 28:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 29:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 30:43]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 30:43]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 30:43]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 30:43]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 32:12]
        when _T_1 : @[dut.scala 32:20]
          node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 33:14]
          when _T_2 : @[dut.scala 33:24]
            node _idx_T = sub(sp, UInt<1>("h1")) @[dut.scala 34:24]
            node idx = tail(_idx_T, 1) @[dut.scala 34:24]
            node _T_3 = bits(idx, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 35:26]
            node _sp_T = sub(sp, UInt<1>("h1")) @[dut.scala 36:20]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 36:20]
            sp <= _sp_T_1 @[dut.scala 36:14]
        else :
          node _T_4 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 39:14]
          when _T_4 : @[dut.scala 39:25]
            node _dataOutReg_T = bits(sp, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 41:22]
            node _T_5 = bits(sp, 1, 0)
            stack_mem[_T_5] <= UInt<1>("h0") @[dut.scala 42:26]
            node _sp_T_2 = add(sp, UInt<1>("h1")) @[dut.scala 43:20]
            node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 43:20]
            sp <= _sp_T_3 @[dut.scala 43:14]


