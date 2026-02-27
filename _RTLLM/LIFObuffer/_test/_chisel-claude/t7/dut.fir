circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    wire _stackMem_WIRE : UInt<4>[4] @[dut.scala 17:33]
    _stackMem_WIRE[0] <= UInt<4>("h0") @[dut.scala 17:33]
    _stackMem_WIRE[1] <= UInt<4>("h0") @[dut.scala 17:33]
    _stackMem_WIRE[2] <= UInt<4>("h0") @[dut.scala 17:33]
    _stackMem_WIRE[3] <= UInt<4>("h0") @[dut.scala 17:33]
    reg stackMem : UInt<4>[4], clock with :
      reset => (reset, _stackMem_WIRE) @[dut.scala 17:25]
    reg sp : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 20:19]
    node _io_EMPTY_T = eq(sp, UInt<3>("h4")) @[dut.scala 23:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 23:12]
    node _io_FULL_T = eq(sp, UInt<1>("h0")) @[dut.scala 24:18]
    io.FULL <= _io_FULL_T @[dut.scala 24:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 25:14]
    when io.EN : @[dut.scala 28:15]
      node _T = bits(reset, 0, 0) @[dut.scala 29:16]
      when _T : @[dut.scala 29:24]
        sp <= UInt<3>("h4") @[dut.scala 31:10]
        stackMem[0] <= UInt<1>("h0") @[dut.scala 33:21]
        stackMem[1] <= UInt<1>("h0") @[dut.scala 33:21]
        stackMem[2] <= UInt<1>("h0") @[dut.scala 33:21]
        stackMem[3] <= UInt<1>("h0") @[dut.scala 33:21]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 35:16]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 35:26]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 35:23]
        when _T_3 : @[dut.scala 35:36]
          node _T_4 = sub(sp, UInt<1>("h1")) @[dut.scala 37:19]
          node _T_5 = tail(_T_4, 1) @[dut.scala 37:19]
          node _T_6 = bits(_T_5, 1, 0)
          stackMem[_T_6] <= io.dataIn @[dut.scala 37:26]
          node _sp_T = sub(sp, UInt<1>("h1")) @[dut.scala 38:16]
          node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 38:16]
          sp <= _sp_T_1 @[dut.scala 38:10]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 39:25]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 39:22]
          when _T_8 : @[dut.scala 39:36]
            node _io_dataOut_T = bits(sp, 1, 0)
            io.dataOut <= stackMem[_io_dataOut_T] @[dut.scala 41:18]
            node _T_9 = bits(sp, 1, 0)
            stackMem[_T_9] <= UInt<1>("h0") @[dut.scala 42:20]
            node _sp_T_2 = add(sp, UInt<1>("h1")) @[dut.scala 43:16]
            node _sp_T_3 = tail(_sp_T_2, 1) @[dut.scala 43:16]
            sp <= _sp_T_3 @[dut.scala 43:10]
    node _T_10 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 49:17]
    node _T_11 = and(io.RW, _T_10) @[dut.scala 49:14]
    when _T_11 : @[dut.scala 49:28]
      node _io_dataOut_T_1 = bits(sp, 1, 0)
      io.dataOut <= stackMem[_io_dataOut_T_1] @[dut.scala 50:16]


