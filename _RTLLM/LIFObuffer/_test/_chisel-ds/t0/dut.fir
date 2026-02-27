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
    reg stackPtr : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:25]
    wire empty : UInt<1> @[dut.scala 17:19]
    wire full : UInt<1> @[dut.scala 18:18]
    io.EMPTY <= UInt<1>("h0") @[dut.scala 21:12]
    io.FULL <= UInt<1>("h0") @[dut.scala 22:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 23:14]
    node _empty_T = eq(stackPtr, UInt<3>("h4")) @[dut.scala 26:21]
    empty <= _empty_T @[dut.scala 26:9]
    node _full_T = eq(stackPtr, UInt<1>("h0")) @[dut.scala 27:20]
    full <= _full_T @[dut.scala 27:8]
    when io.EN : @[dut.scala 30:15]
      node _T = bits(reset, 0, 0) @[dut.scala 31:22]
      when _T : @[dut.scala 31:26]
        wire _WIRE : UInt<4>[4] @[dut.scala 33:26]
        _WIRE[0] <= UInt<4>("h0") @[dut.scala 33:26]
        _WIRE[1] <= UInt<4>("h0") @[dut.scala 33:26]
        _WIRE[2] <= UInt<4>("h0") @[dut.scala 33:26]
        _WIRE[3] <= UInt<4>("h0") @[dut.scala 33:26]
        stackMem <= _WIRE @[dut.scala 33:16]
        stackPtr <= UInt<3>("h4") @[dut.scala 34:16]
        io.EMPTY <= UInt<1>("h1") @[dut.scala 35:16]
        io.FULL <= UInt<1>("h0") @[dut.scala 36:15]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 39:12]
        node _T_2 = eq(full, UInt<1>("h0")) @[dut.scala 39:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 39:19]
        when _T_3 : @[dut.scala 39:29]
          node _T_4 = sub(stackPtr, UInt<1>("h1")) @[dut.scala 41:27]
          node _T_5 = tail(_T_4, 1) @[dut.scala 41:27]
          node _T_6 = bits(_T_5, 1, 0)
          stackMem[_T_6] <= io.dataIn @[dut.scala 41:34]
          node _stackPtr_T = sub(stackPtr, UInt<1>("h1")) @[dut.scala 42:30]
          node _stackPtr_T_1 = tail(_stackPtr_T, 1) @[dut.scala 42:30]
          stackPtr <= _stackPtr_T_1 @[dut.scala 42:18]
        else :
          node _T_7 = eq(empty, UInt<1>("h0")) @[dut.scala 43:27]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 43:24]
          when _T_8 : @[dut.scala 43:35]
            node _io_dataOut_T = bits(stackPtr, 1, 0)
            io.dataOut <= stackMem[_io_dataOut_T] @[dut.scala 45:20]
            node _T_9 = bits(stackPtr, 1, 0)
            stackMem[_T_9] <= UInt<1>("h0") @[dut.scala 46:28]
            node _stackPtr_T_2 = add(stackPtr, UInt<1>("h1")) @[dut.scala 47:30]
            node _stackPtr_T_3 = tail(_stackPtr_T_2, 1) @[dut.scala 47:30]
            stackPtr <= _stackPtr_T_3 @[dut.scala 47:18]
        io.EMPTY <= empty @[dut.scala 50:16]
        io.FULL <= full @[dut.scala 51:15]


