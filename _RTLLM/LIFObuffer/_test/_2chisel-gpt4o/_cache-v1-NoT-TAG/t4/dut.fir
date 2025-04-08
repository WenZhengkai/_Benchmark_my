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
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 21:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 21:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 22:19]
    io.FULL <= _io_FULL_T @[dut.scala 22:12]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 25:27]
    io.dataOut <= dataOutReg @[dut.scala 26:14]
    when io.EN : @[dut.scala 29:15]
      node _T = eq(io.RW, UInt<1>("h0")) @[dut.scala 30:16]
      when _T : @[dut.scala 30:29]
        node _T_1 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 31:12]
        when _T_1 : @[dut.scala 31:22]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 32:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 32:18]
          SP <= _SP_T_1 @[dut.scala 32:12]
          node _T_2 = sub(SP, UInt<1>("h1")) @[dut.scala 33:22]
          node _T_3 = tail(_T_2, 1) @[dut.scala 33:22]
          node _T_4 = bits(_T_3, 1, 0)
          stack_mem[_T_4] <= io.dataIn @[dut.scala 33:29]
      else :
        node _T_5 = eq(io.RW, UInt<1>("h1")) @[dut.scala 35:23]
        when _T_5 : @[dut.scala 35:35]
          node _T_6 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 36:12]
          when _T_6 : @[dut.scala 36:23]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 37:20]
            node _T_7 = bits(SP, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 38:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 39:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 39:18]
            SP <= _SP_T_3 @[dut.scala 39:12]


