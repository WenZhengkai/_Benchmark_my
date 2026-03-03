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
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:19]
    reg dataOut_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 21:28]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:20]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:14]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:20]
    io.FULL <= _io_FULL_T @[dut.scala 25:14]
    io.dataOut <= dataOut_reg @[dut.scala 26:14]
    when io.EN : @[dut.scala 29:15]
      node _T = bits(reset, 0, 0) @[dut.scala 30:16]
      when _T : @[dut.scala 30:24]
        SP <= UInt<3>("h4") @[dut.scala 32:10]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 34:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 34:22]
        dataOut_reg <= UInt<1>("h0") @[dut.scala 36:19]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 38:12]
        when _T_1 : @[dut.scala 38:20]
          node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 40:14]
          when _T_2 : @[dut.scala 40:24]
            node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 41:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 41:20]
            SP <= _SP_T_1 @[dut.scala 41:14]
            node _T_3 = sub(SP, UInt<1>("h1")) @[dut.scala 42:24]
            node _T_4 = tail(_T_3, 1) @[dut.scala 42:24]
            node _T_5 = bits(_T_4, 1, 0)
            stack_mem[_T_5] <= io.dataIn @[dut.scala 42:31]
        else :
          node _T_6 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 46:14]
          when _T_6 : @[dut.scala 46:25]
            node _dataOut_reg_T = bits(SP, 1, 0)
            dataOut_reg <= stack_mem[_dataOut_reg_T] @[dut.scala 47:23]
            node _T_7 = bits(SP, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 48:25]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 49:20]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 49:20]
            SP <= _SP_T_3 @[dut.scala 49:14]


