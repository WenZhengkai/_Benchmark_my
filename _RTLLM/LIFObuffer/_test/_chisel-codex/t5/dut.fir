circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stack_mem_WIRE : UInt<4>[4] @[dut.scala 16:36]
    _stack_mem_WIRE[0] <= UInt<4>("h0") @[dut.scala 16:36]
    _stack_mem_WIRE[1] <= UInt<4>("h0") @[dut.scala 16:36]
    _stack_mem_WIRE[2] <= UInt<4>("h0") @[dut.scala 16:36]
    _stack_mem_WIRE[3] <= UInt<4>("h0") @[dut.scala 16:36]
    reg stack_mem : UInt<4>[4], clock with :
      reset => (reset, _stack_mem_WIRE) @[dut.scala 16:28]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:28]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:28]
    when io.EN : @[dut.scala 21:15]
      node _T = bits(reset, 0, 0) @[dut.scala 22:16]
      when _T : @[dut.scala 22:24]
        SP <= UInt<3>("h4") @[dut.scala 23:10]
        dataOutReg <= UInt<1>("h0") @[dut.scala 24:18]
        stack_mem[0] <= UInt<1>("h0") @[dut.scala 26:22]
        stack_mem[1] <= UInt<1>("h0") @[dut.scala 26:22]
        stack_mem[2] <= UInt<1>("h0") @[dut.scala 26:22]
        stack_mem[3] <= UInt<1>("h0") @[dut.scala 26:22]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 29:12]
        when _T_1 : @[dut.scala 29:20]
          node _T_2 = neq(SP, UInt<1>("h0")) @[dut.scala 30:17]
          when _T_2 : @[dut.scala 30:26]
            node _nextSp_T = sub(SP, UInt<1>("h1")) @[dut.scala 31:27]
            node nextSp = tail(_nextSp_T, 1) @[dut.scala 31:27]
            node _T_3 = bits(nextSp, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 32:29]
            SP <= nextSp @[dut.scala 33:14]
        else :
          node _T_4 = neq(SP, UInt<3>("h4")) @[dut.scala 36:17]
          when _T_4 : @[dut.scala 36:26]
            node _dataOutReg_T = bits(SP, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 37:22]
            node _T_5 = bits(SP, 1, 0)
            stack_mem[_T_5] <= UInt<1>("h0") @[dut.scala 38:25]
            node _SP_T = add(SP, UInt<1>("h1")) @[dut.scala 39:20]
            node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 39:20]
            SP <= _SP_T_1 @[dut.scala 39:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 45:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 45:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 46:19]
    io.FULL <= _io_FULL_T @[dut.scala 46:12]
    io.dataOut <= dataOutReg @[dut.scala 47:14]

