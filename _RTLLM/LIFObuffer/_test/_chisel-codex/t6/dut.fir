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
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:25]
    reg dataOutR : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[dut.scala 19:25]
    node empty = eq(sp, UInt<3>("h4")) @[dut.scala 21:19]
    node full = eq(sp, UInt<1>("h0")) @[dut.scala 22:19]
    when io.EN : @[dut.scala 24:15]
      node _T = bits(reset, 0, 0) @[dut.scala 25:16]
      when _T : @[dut.scala 25:24]
        sp <= UInt<3>("h4") @[dut.scala 26:10]
        dataOutR <= UInt<1>("h0") @[dut.scala 27:16]
        stackMem[0] <= UInt<1>("h0") @[dut.scala 29:21]
        stackMem[1] <= UInt<1>("h0") @[dut.scala 29:21]
        stackMem[2] <= UInt<1>("h0") @[dut.scala 29:21]
        stackMem[3] <= UInt<1>("h0") @[dut.scala 29:21]
      else :
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 33:12]
        node _T_2 = eq(full, UInt<1>("h0")) @[dut.scala 33:22]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 33:19]
        when _T_3 : @[dut.scala 33:29]
          node _nextSp_T = sub(sp, UInt<1>("h1")) @[dut.scala 34:25]
          node nextSp = tail(_nextSp_T, 1) @[dut.scala 34:25]
          node _T_4 = bits(nextSp, 1, 0)
          stackMem[_T_4] <= io.dataIn @[dut.scala 35:26]
          sp <= nextSp @[dut.scala 36:12]
        else :
          node _T_5 = eq(empty, UInt<1>("h0")) @[dut.scala 39:26]
          node _T_6 = and(io.RW, _T_5) @[dut.scala 39:23]
          when _T_6 : @[dut.scala 39:34]
            node _dataOutR_T = bits(sp, 1, 0)
            dataOutR <= stackMem[_dataOutR_T] @[dut.scala 40:18]
            node _T_7 = bits(sp, 1, 0)
            stackMem[_T_7] <= UInt<1>("h0") @[dut.scala 41:22]
            node _sp_T = add(sp, UInt<1>("h1")) @[dut.scala 42:18]
            node _sp_T_1 = tail(_sp_T, 1) @[dut.scala 42:18]
            sp <= _sp_T_1 @[dut.scala 42:12]
    io.EMPTY <= empty @[dut.scala 47:12]
    io.FULL <= full @[dut.scala 48:12]
    io.dataOut <= dataOutR @[dut.scala 49:14]

