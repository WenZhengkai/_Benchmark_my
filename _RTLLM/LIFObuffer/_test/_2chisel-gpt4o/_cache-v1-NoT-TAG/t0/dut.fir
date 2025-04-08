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
    node _T = bits(reset, 0, 0) @[dut.scala 19:20]
    when _T : @[dut.scala 19:24]
      SP <= UInt<3>("h4") @[dut.scala 20:8]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 22:20]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 22:20]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 22:20]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 22:20]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 27:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 27:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 28:18]
    io.FULL <= _io_FULL_T @[dut.scala 28:11]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 31:27]
    io.dataOut <= dataOutReg @[dut.scala 32:14]
    when io.EN : @[dut.scala 35:15]
      node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 36:16]
      when _T_1 : @[dut.scala 36:29]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 37:12]
        when _T_2 : @[dut.scala 37:22]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 38:18]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 38:18]
          SP <= _SP_T_1 @[dut.scala 38:12]
          node _T_3 = sub(SP, UInt<1>("h1")) @[dut.scala 39:22]
          node _T_4 = tail(_T_3, 1) @[dut.scala 39:22]
          node _T_5 = bits(_T_4, 1, 0)
          stack_mem[_T_5] <= io.dataIn @[dut.scala 39:29]
      else :
        node _T_6 = eq(io.RW, UInt<1>("h1")) @[dut.scala 41:23]
        when _T_6 : @[dut.scala 41:35]
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 42:12]
          when _T_7 : @[dut.scala 42:23]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 43:20]
            node _T_8 = bits(SP, 1, 0)
            stack_mem[_T_8] <= UInt<1>("h0") @[dut.scala 44:23]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 45:18]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 45:18]
            SP <= _SP_T_3 @[dut.scala 45:12]


