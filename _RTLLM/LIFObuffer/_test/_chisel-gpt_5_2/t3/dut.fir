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
      reset => (reset, UInt<3>("h4")) @[dut.scala 23:19]
    node empty = eq(sp, UInt<3>("h4")) @[dut.scala 25:19]
    node full = eq(sp, UInt<1>("h0")) @[dut.scala 26:19]
    io.EMPTY <= empty @[dut.scala 28:12]
    io.FULL <= full @[dut.scala 29:12]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 31:27]
    io.dataOut <= dataOutReg @[dut.scala 32:14]
    node _T = bits(reset, 0, 0) @[dut.scala 34:15]
    when _T : @[dut.scala 34:23]
      sp <= UInt<3>("h4") @[dut.scala 35:8]
      dataOutReg <= UInt<1>("h0") @[dut.scala 36:16]
      stack_mem[0] <= UInt<1>("h0") @[dut.scala 38:20]
      stack_mem[1] <= UInt<1>("h0") @[dut.scala 38:20]
      stack_mem[2] <= UInt<1>("h0") @[dut.scala 38:20]
      stack_mem[3] <= UInt<1>("h0") @[dut.scala 38:20]
    else :
      when io.EN : @[dut.scala 40:23]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 41:11]
        when _T_1 : @[dut.scala 41:19]
          node _T_2 = eq(full, UInt<1>("h0")) @[dut.scala 43:13]
          when _T_2 : @[dut.scala 43:20]
            node _wrIdx_T = sub(sp, UInt<1>("h1")) @[dut.scala 44:24]
            node wrIdx = tail(_wrIdx_T, 1) @[dut.scala 44:24]
            node _T_3 = bits(wrIdx, 1, 0)
            stack_mem[_T_3] <= io.dataIn @[dut.scala 45:26]
            node _sp_T = sub(sp, UInt<1>("h1")) @[dut.scala 46:18]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 46:18]
            sp <= _sp_T_1 @[dut.scala 46:12]
        else :
          node _T_4 = eq(empty, UInt<1>("h0")) @[dut.scala 50:13]
          when _T_4 : @[dut.scala 50:21]
            node _dataOutReg_T = bits(sp, 1, 0)
            dataOutReg <= stack_mem[_dataOutReg_T] @[dut.scala 52:20]
            node _T_5 = bits(sp, 1, 0)
            stack_mem[_T_5] <= UInt<1>("h0") @[dut.scala 53:26]
            node _sp_T_2 = add(sp, UInt<1>("h1")) @[dut.scala 54:18]
            node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 54:18]
            sp <= _sp_T_3 @[dut.scala 54:12]


