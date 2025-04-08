circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip dataIn : UInt<4>, flip RW : UInt<1>, flip EN : UInt<1>, EMPTY : UInt<1>, FULL : UInt<1>, dataOut : UInt<4>}

    cmem stack_mem : UInt<4> [4] @[dut.scala 15:22]
    reg SP : UInt<3>, clock with :
      reset => (reset, UInt<3>("h4")) @[dut.scala 18:19]
    io.dataOut <= UInt<1>("h0") @[dut.scala 21:14]
    node _io_EMPTY_T = eq(SP, UInt<3>("h4")) @[dut.scala 24:19]
    io.EMPTY <= _io_EMPTY_T @[dut.scala 24:12]
    node _io_FULL_T = eq(SP, UInt<1>("h0")) @[dut.scala 25:18]
    io.FULL <= _io_FULL_T @[dut.scala 25:11]
    node _T = bits(reset, 0, 0) @[dut.scala 28:14]
    when _T : @[dut.scala 28:22]
      write mport MPORT = stack_mem[UInt<1>("h0")], clock
      MPORT <= UInt<1>("h0")
      write mport MPORT_1 = stack_mem[UInt<1>("h1")], clock
      MPORT_1 <= UInt<1>("h0")
      write mport MPORT_2 = stack_mem[UInt<2>("h2")], clock
      MPORT_2 <= UInt<1>("h0")
      write mport MPORT_3 = stack_mem[UInt<2>("h3")], clock
      MPORT_3 <= UInt<1>("h0")
      SP <= UInt<3>("h4") @[dut.scala 33:8]
    else :
      when io.EN : @[dut.scala 34:22]
        node _T_1 = eq(io.RW, UInt<1>("h0")) @[dut.scala 35:10]
        node _T_2 = eq(io.FULL, UInt<1>("h0")) @[dut.scala 35:20]
        node _T_3 = and(_T_1, _T_2) @[dut.scala 35:17]
        when _T_3 : @[dut.scala 35:30]
          node _T_4 = sub(SP, UInt<1>("h1")) @[dut.scala 37:26]
          node _T_5 = tail(_T_4, 1) @[dut.scala 37:26]
          node _T_6 = bits(_T_5, 1, 0)
          write mport MPORT_4 = stack_mem[_T_6], clock
          MPORT_4 <= io.dataIn
          node _SP_T = sub(SP, UInt<1>("h1")) @[dut.scala 38:16]
          node _SP_T_1 = tail(_SP_T, 1) @[dut.scala 38:16]
          SP <= _SP_T_1 @[dut.scala 38:10]
        else :
          node _T_7 = eq(io.EMPTY, UInt<1>("h0")) @[dut.scala 39:26]
          node _T_8 = and(io.RW, _T_7) @[dut.scala 39:23]
          when _T_8 : @[dut.scala 39:37]
            node _io_dataOut_T = bits(SP, 1, 0) @[dut.scala 41:35]
            read mport io_dataOut_MPORT = stack_mem[_io_dataOut_T], clock @[dut.scala 41:35]
            io.dataOut <= io_dataOut_MPORT @[dut.scala 41:18]
            node _T_9 = bits(SP, 1, 0)
            write mport MPORT_5 = stack_mem[_T_9], clock
            MPORT_5 <= UInt<1>("h0")
            node _SP_T_2 = add(SP, UInt<1>("h1")) @[dut.scala 43:16]
            node _SP_T_3 = tail(_SP_T_2, 1) @[dut.scala 43:16]
            SP <= _SP_T_3 @[dut.scala 43:10]


