circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stackMem_WIRE : UInt<4>[4] @[dut.scala 15:33]
    _stackMem_WIRE[0] <= UInt<4>("h0") @[dut.scala 15:33]
    _stackMem_WIRE[1] <= UInt<4>("h0") @[dut.scala 15:33]
    _stackMem_WIRE[2] <= UInt<4>("h0") @[dut.scala 15:33]
    _stackMem_WIRE[3] <= UInt<4>("h0") @[dut.scala 15:33]
    reg stackMem : UInt<4>[4], clock with :
      reset => (reset, _stackMem_WIRE) @[dut.scala 15:25]
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:19]
    node _T = bits(reset, 0, 0) @[dut.scala 19:14]
    when _T : @[dut.scala 19:22]
      sp <= UInt<3>("h4") @[dut.scala 20:8]
      wire _WIRE : UInt<4>[4] @[dut.scala 21:24]
      _WIRE[0] <= UInt<4>("h0") @[dut.scala 21:24]
      _WIRE[1] <= UInt<4>("h0") @[dut.scala 21:24]
      _WIRE[2] <= UInt<4>("h0") @[dut.scala 21:24]
      _WIRE[3] <= UInt<4>("h0") @[dut.scala 21:24]
      stackMem <= _WIRE @[dut.scala 21:14]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 25:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 25:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 26:18]
    io.FULL <= _io_FULL_T @[dut.scala 26:11]
    reg dataOutReg : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 29:27]
    io.dataOut <= dataOutReg @[dut.scala 30:14]
    when io.EN : @[dut.scala 33:15]
      when io.RW : @[dut.scala 34:17]
        node _T_1 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 35:12]
        when _T_1 : @[dut.scala 35:23]
          node _dataOutReg_T = bits(sp, 1, 0)
          dataOutReg <= stackMem[_dataOutReg_T] @[dut.scala 36:20]
          node _T_2 = bits(sp, 1, 0)
          stackMem[_T_2] <= UInt<1>("h0") @[dut.scala 37:22]
          node _sp_T = add(sp, UInt<1>("h1")) @[dut.scala 38:18]
          node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 38:18]
          sp <= _sp_T_1 @[dut.scala 38:12]
      else :
        node _T_3 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 41:12]
        when _T_3 : @[dut.scala 41:22]
          node _sp_T_2 = sub(sp, UInt<1>("h1")) @[dut.scala 42:18]
          node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 42:18]
          sp <= _sp_T_3 @[dut.scala 42:12]
          node _T_4 = sub(sp, UInt<1>("h1")) @[dut.scala 43:21]
          node _T_5 = tail(_T_4, 1) @[dut.scala 43:21]
          node _T_6 = bits(_T_5, 1, 0)
          stackMem[_T_6] <= io.dataIn @[dut.scala 43:28]


