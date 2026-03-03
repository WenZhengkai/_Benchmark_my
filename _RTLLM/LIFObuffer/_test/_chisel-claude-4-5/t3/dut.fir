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
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 25:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 25:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 26:18]
    io.FULL <= _io_FULL_T @[dut.scala 26:11]
    when io.EN : @[dut.scala 28:15]
      node _T = bits(reset, 0, 0) @[dut.scala 29:16]
      when _T : @[dut.scala 29:24]
        SP <= UInt<3>("h4") @[dut.scala 31:10]
        wire _WIRE : UInt<4>[4] @[dut.scala 32:27]
        _WIRE[0] <= UInt<4>("h0") @[dut.scala 32:27]
        _WIRE[1] <= UInt<4>("h0") @[dut.scala 32:27]
        _WIRE[2] <= UInt<4>("h0") @[dut.scala 32:27]
        _WIRE[3] <= UInt<4>("h0") @[dut.scala 32:27]
        stack_mem <= _WIRE @[dut.scala 32:17]
        dataOut_reg <= UInt<1>("h0") @[dut.scala 33:19]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 35:12]
        when _T_1 : @[dut.scala 35:20]
          node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 37:14]
          when _T_2 : @[dut.scala 37:24]
            node _write_addr_T = sub(SP, UInt<1>("h1")) @[dut.scala 38:31]
            node write_addr = tail(_write_addr_T, 1) @[dut.scala 38:31]
            node _T_3 = bits(write_addr, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 39:33]
            SP <= write_addr @[dut.scala 40:14]
        else :
          node _T_4 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 44:14]
          when _T_4 : @[dut.scala 44:25]
            node _dataOut_reg_T = bits(SP, 1, 0)
            dataOut_reg <= stack_mem[_dataOut_reg_T] @[dut.scala 45:23]
            node _T_5 = bits(SP, 1, 0)
            stack_mem[_T_5] <= UInt<1>("h0") @[dut.scala 46:25]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 47:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 47:20]
            SP <= _SP_T_1 @[dut.scala 47:14]


