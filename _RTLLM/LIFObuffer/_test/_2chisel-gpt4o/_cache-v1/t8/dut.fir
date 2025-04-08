circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stackMem_WIRE : UInt<4>[4] @[dut.scala 16:33]
    _stackMem_WIRE[0] <= UInt<4>("h0") @[dut.scala 16:33]
    _stackMem_WIRE[1] <= UInt<4>("h0") @[dut.scala 16:33]
    _stackMem_WIRE[2] <= UInt<4>("h0") @[dut.scala 16:33]
    _stackMem_WIRE[3] <= UInt<4>("h0") @[dut.scala 16:33]
    reg stackMem : UInt<4>[4], clock with :
      reset => (reset, _stackMem_WIRE) @[dut.scala 16:25]
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 17:19]
    node _T = bits(reset, 0, 0) @[dut.scala 20:15]
    when _T : @[dut.scala 20:23]
      sp <= UInt<3>("h4") @[dut.scala 21:8]
      stackMem[0] <= UInt<1>("h0") @[dut.scala 23:19]
      stackMem[1] <= UInt<1>("h0") @[dut.scala 23:19]
      stackMem[2] <= UInt<1>("h0") @[dut.scala 23:19]
      stackMem[3] <= UInt<1>("h0") @[dut.scala 23:19]
    else :
      when io.EN : @[dut.scala 26:17]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 27:18]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 27:33]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 27:30]
        when _T_3 : @[dut.scala 27:43]
          node _T_4 = gt(sp, UInt<1>("h0")) @[dut.scala 28:17]
          when _T_4 : @[dut.scala 28:24]
            node _sp_T = sub(sp, UInt<1>("h1")) @[dut.scala 29:20]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 29:20]
            sp <= _sp_T_1 @[dut.scala 29:14]
            node _T_5 = sub(sp, UInt<1>("h1")) @[dut.scala 30:23]
            node _T_6 = tail(_T_5, 1) @[dut.scala 30:23]
            node _T_7 = bits(_T_6, 1, 0)
            stackMem[_T_7] <= io.dataIn @[dut.scala 30:30]
        else :
          node _T_8 = eq(io.RW, UInt<1>("h1")) @[dut.scala 32:25]
          node _T_9 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 32:39]
          node _T_10 = and(_T_8, _T_9) @[dut.scala 32:36]
          when _T_10 : @[dut.scala 32:50]
            node _io_dataOut_T = bits(sp, 1, 0)
            io.dataOut <= stackMem[_io_dataOut_T] @[dut.scala 33:20]
            node _T_11 = lt(sp, UInt<3>("h4")) @[dut.scala 34:17]
            when _T_11 : @[dut.scala 34:24]
              node _T_12 = bits(sp, 1, 0)
              stackMem[_T_12] <= UInt<1>("h0") @[dut.scala 35:24]
              node _sp_T_2 = add(sp, UInt<1>("h1")) @[dut.scala 36:20]
              node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 36:20]
              sp <= _sp_T_3 @[dut.scala 36:14]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 43:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 43:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 44:18]
    io.FULL <= _io_FULL_T @[dut.scala 44:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 45:14]
    node _T_13 = eq(io.RW, UInt<1>("h1")) @[dut.scala 48:14]
    node _T_14 = and(_T_13, io.EN) @[dut.scala 48:25]
    node _T_15 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 48:37]
    node _T_16 = and(_T_14, _T_15) @[dut.scala 48:34]
    when _T_16 : @[dut.scala 48:48]
      node _io_dataOut_T_1 = bits(sp, 1, 0)
      io.dataOut <= stackMem[_io_dataOut_T_1] @[dut.scala 49:16]


