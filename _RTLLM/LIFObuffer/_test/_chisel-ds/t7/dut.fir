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
    reg stackPtr : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 17:25]
    reg empty : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[dut.scala 18:22]
    reg full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 19:21]
    node _T = bits(reset, 0, 0) @[dut.scala 22:14]
    when _T : @[dut.scala 22:22]
      stackMem[0] <= UInt<1>("h0") @[dut.scala 23:24]
      stackMem[1] <= UInt<1>("h0") @[dut.scala 23:24]
      stackMem[2] <= UInt<1>("h0") @[dut.scala 23:24]
      stackMem[3] <= UInt<1>("h0") @[dut.scala 23:24]
      stackPtr <= UInt<3>("h4") @[dut.scala 24:14]
      empty <= UInt<1>("h1") @[dut.scala 25:11]
      full <= UInt<1>("h0") @[dut.scala 26:10]
    else :
      when io.EN : @[dut.scala 28:17]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 29:12]
        node _T_2 = eq(full, UInt<1>("h0")) @[dut.scala 29:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 29:19]
        when _T_3 : @[dut.scala 29:29]
          node _stackPtr_T = sub(stackPtr, UInt<1>("h1")) @[dut.scala 30:30]
          node _stackPtr_T_1 = tail(_stackPtr_T, 1) @[dut.scala 30:30]
          stackPtr <= _stackPtr_T_1 @[dut.scala 30:18]
          node _T_4 = bits(stackPtr, 1, 0)
          stackMem[_T_4] <= io.dataIn @[dut.scala 31:28]
          empty <= UInt<1>("h0") @[dut.scala 32:15]
          node _full_T = eq(stackPtr, UInt<1>("h1")) @[dut.scala 33:26]
          full <= _full_T @[dut.scala 33:14]
        else :
          node _T_5 = eq(empty, UInt<1>("h0")) @[dut.scala 34:27]
          node _T_6 = and(io.RW, _T_5) @[dut.scala 34:24]
          when _T_6 : @[dut.scala 34:35]
            node _io_dataOut_T = bits(stackPtr, 1, 0)
            io.dataOut <= stackMem[_io_dataOut_T] @[dut.scala 35:20]
            node _T_7 = bits(stackPtr, 1, 0)
            stackMem[_T_7] <= UInt<1>("h0") @[dut.scala 36:28]
            node _stackPtr_T_2 = add(stackPtr, UInt<1>("h1")) @[dut.scala 37:30]
            node _stackPtr_T_3 = tail(_stackPtr_T_2, 1) @[dut.scala 37:30]
            stackPtr <= _stackPtr_T_3 @[dut.scala 37:18]
            full <= UInt<1>("h0") @[dut.scala 38:14]
            node _empty_T = eq(stackPtr, UInt<2>("h3")) @[dut.scala 39:27]
            empty <= _empty_T @[dut.scala 39:15]
    io.EMPTY <= empty @[dut.scala 45:12]
    io.FULL <= full @[dut.scala 46:11]
    node _io_dataOut_T_1 = bits(stackPtr, 1, 0)
    io.dataOut <= stackMem[_io_dataOut_T_1] @[dut.scala 47:14]

