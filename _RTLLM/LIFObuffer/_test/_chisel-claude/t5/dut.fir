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
    reg dataOut_reg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 17:28]
    node empty = eq(SP, UInt<3>("h4")) @[dut.scala 20:18]
    node full = eq(SP, UInt<1>("h0")) @[dut.scala 21:17]
    io.EMPTY <= empty @[dut.scala 23:12]
    io.FULL <= full @[dut.scala 24:11]
    io.dataOut <= dataOut_reg @[dut.scala 25:14]
    node _T = bits(reset, 0, 0) @[dut.scala 27:14]
    when _T : @[dut.scala 27:22]
      SP <= UInt<3>("h4") @[dut.scala 28:8]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 30:20]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 30:20]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 30:20]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 30:20]
      dataOut_reg <= UInt<1>("h0") @[dut.scala 32:17]
    else :
      when io.EN : @[dut.scala 33:21]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 34:10]
        node _T_2 = eq(full, UInt<1>("h0")) @[dut.scala 34:20]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 34:17]
        when _T_3 : @[dut.scala 34:27]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 36:20]
          node _T_5 = tail(_T_4, 1) @[dut.scala 36:20]
          node _T_6 = bits(_T_5, 1, 0)
          stack_mem[_T_6] <= io.dataIn @[dut.scala 36:27]
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 37:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 37:16]
          SP <= _SP_T_1 @[dut.scala 37:10]
        else :
          node _T_7 = eq(empty, UInt<1>("h0")) @[dut.scala 38:25]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 38:22]
          when _T_8 : @[dut.scala 38:33]
            node _dataOut_reg_T = bits(SP, 1, 0)
            dataOut_reg <= stack_mem[_dataOut_reg_T] @[dut.scala 40:19]
            node _T_9 = bits(SP, 1, 0)
            stack_mem[_T_9] <= UInt<1>("h0") @[dut.scala 41:21]
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 42:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 42:16]
            SP <= _SP_T_3 @[dut.scala 42:10]


