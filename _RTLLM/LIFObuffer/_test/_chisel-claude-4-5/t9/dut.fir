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
    io.dataOut <= dataOut_reg @[dut.scala 24:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 27:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 27:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 28:19]
    io.FULL <= _io_FULL_T @[dut.scala 28:12]
    when io.EN : @[dut.scala 31:15]
      node _T = bits(reset, 0, 0) @[dut.scala 32:16]
      when _T : @[dut.scala 32:24]
        SP <= UInt<3>("h4") @[dut.scala 34:10]
        dataOut_reg <= UInt<1>("h0") @[dut.scala 35:19]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 37:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 37:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 37:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 37:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 40:12]
        when _T_1 : @[dut.scala 40:20]
          node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 42:14]
          when _T_2 : @[dut.scala 42:24]
            node _new_SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 43:27]
            node new_SP = tail(_new_SP_T, 1) @[dut.scala 43:27]
            node _T_3 = bits(new_SP, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 44:29]
            SP <= new_SP @[dut.scala 45:14]
        else :
          node _T_4 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 49:14]
          when _T_4 : @[dut.scala 49:25]
            node _dataOut_reg_T = sub(SP, UInt<1>("h1")) @[dut.scala 50:39]
            node _dataOut_reg_T_1 = tail(_dataOut_reg_T, 1) @[dut.scala 50:39]
            node _dataOut_reg_T_2 = bits(_dataOut_reg_T_1, 1, 0)
            dataOut_reg <= stack_mem[_dataOut_reg_T_2] @[dut.scala 50:23]
            node _T_5 = sub(SP, UInt<1>("h1")) @[dut.scala 51:24]
            node _T_6 = tail(_T_5, 1) @[dut.scala 51:24]
            node _T_7 = bits(_T_6, 1, 0)
            stack_mem[_T_7] <= UInt<1>("h0") @[dut.scala 51:31]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 52:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 52:20]
            SP <= _SP_T_1 @[dut.scala 52:14]


