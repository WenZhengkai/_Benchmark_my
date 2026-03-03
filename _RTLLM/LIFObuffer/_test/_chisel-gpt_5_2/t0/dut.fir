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
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 21:19]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 23:27]
    io.dataOut <= dataOutReg @[dut.scala 24:14]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 27:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 27:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 28:19]
    io.FULL <= _io_FULL_T @[dut.scala 28:12]
    when io.EN : @[dut.scala 30:15]
      node _T = bits(reset, 0, 0) @[dut.scala 31:16]
      when _T : @[dut.scala 31:24]
        sp <= UInt<3>("h4") @[dut.scala 33:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 34:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 36:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 36:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 40:12]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 40:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 40:19]
        when _T_3 : @[dut.scala 40:32]
          node _newSp_T = sub(sp, UInt<1>("h1")) @[dut.scala 41:24]
          node newSp = tail(_newSp_T, 1) @[dut.scala 41:24]
          node _T_4 = bits(newSp, 1, 0)
          stack_mem[_T_4] <= io.dataIn @[dut.scala 42:26]
          sp <= newSp @[dut.scala 43:12]
        else :
          node _T_5 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 46:26]
          node _T_6 = and(io.RW, _T_5) @[dut.scala 46:23]
          when _T_6 : @[dut.scala 46:37]
            node _dataOutReg_T = bits(sp, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 48:20]
            node _T_7 = bits(sp, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 49:24]
            node _sp_T = add(sp, UInt<1>("h1")) @[dut.scala 50:18]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 50:18]
            sp <= _sp_T_1 @[dut.scala 50:12]


