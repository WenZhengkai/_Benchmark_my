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
    reg stackPointer : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 16:29]
    node resetSignal = bits(reset, 0, 0) @[dut.scala 17:27]
    io.EMPTY <= UInt<1>("h0") @[dut.scala 20:12]
    io.FULL <= UInt<1>("h0") @[dut.scala 21:11]
    io.dataOut <= UInt<1>("h0") @[dut.scala 22:14]
    node _io_EMPTY_T = eq(stackPointer, UInt<3>("h4")) @[dut.scala 25:28]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 25:12]
    node _io_FULL_T = eq(stackPointer, UInt<1>("h0")) @[dut.scala 26:27]
    io.FULL <= _io_FULL_T @[dut.scala 26:11]
    when resetSignal : @[dut.scala 28:21]
      stackMem[0] <= UInt<1>("h0") @[dut.scala 30:24]
      stackMem[1] <= UInt<1>("h0") @[dut.scala 30:24]
      stackMem[2] <= UInt<1>("h0") @[dut.scala 30:24]
      stackMem[3] <= UInt<1>("h0") @[dut.scala 30:24]
      stackPointer <= UInt<3>("h4") @[dut.scala 31:18]
    else :
      when io.EN : @[dut.scala 32:21]
        node _T = eq(io.RW, UInt<1>("h0")) @[dut.scala 33:10]
        node _T_1 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 33:20]
        node _T_2 = and(_T, _T_1) @[dut.scala 33:17]
        when _T_2 : @[dut.scala 33:30]
          node _T_3 = sub(stackPointer, UInt<1>("h1")) @[dut.scala 35:29]
          node _T_4 = tail(_T_3, 1) @[dut.scala 35:29]
          node _T_5 = bits(_T_4, 1, 0)
          stackMem[_T_5] <= io.dataIn @[dut.scala 35:36]
          node _stackPointer_T = sub(stackPointer, UInt<1>("h1")) @[dut.scala 36:36]
          node _stackPointer_T_1 = tail(_stackPointer_T, 1) @[dut.scala 36:36]
          stackPointer <= _stackPointer_T_1 @[dut.scala 36:20]
        else :
          node _T_6 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 37:25]
          node _T_7 = and(io.RW, _T_6) @[dut.scala 37:22]
          when _T_7 : @[dut.scala 37:36]
            node _io_dataOut_T = bits(stackPointer, 1, 0)
            io.dataOut <= stackMem[_io_dataOut_T] @[dut.scala 39:18]
            node _T_8 = bits(stackPointer, 1, 0)
            stackMem[_T_8] <= UInt<1>("h0") @[dut.scala 40:30]
            node _stackPointer_T_2 = add(stackPointer, UInt<1>("h1")) @[dut.scala 41:36]
            node _stackPointer_T_3 = tail(_stackPointer_T_2, 1) @[dut.scala 41:36]
            stackPointer <= _stackPointer_T_3 @[dut.scala 41:20]


