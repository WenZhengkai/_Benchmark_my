circuit BTB :
  module BTB :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    cmem btbTable : UInt<2> [16] @[dut.scala 14:21]
    node _T = bits(reset, 0, 0) @[dut.scala 17:15]
    when _T : @[dut.scala 17:23]
      write mport MPORT = btbTable[UInt<1>("h0")], clock
      MPORT <= UInt<1>("h0")
      write mport MPORT_1 = btbTable[UInt<1>("h1")], clock
      MPORT_1 <= UInt<1>("h0")
      write mport MPORT_2 = btbTable[UInt<2>("h2")], clock
      MPORT_2 <= UInt<1>("h0")
      write mport MPORT_3 = btbTable[UInt<2>("h3")], clock
      MPORT_3 <= UInt<1>("h0")
      write mport MPORT_4 = btbTable[UInt<3>("h4")], clock
      MPORT_4 <= UInt<1>("h0")
      write mport MPORT_5 = btbTable[UInt<3>("h5")], clock
      MPORT_5 <= UInt<1>("h0")
      write mport MPORT_6 = btbTable[UInt<3>("h6")], clock
      MPORT_6 <= UInt<1>("h0")
      write mport MPORT_7 = btbTable[UInt<3>("h7")], clock
      MPORT_7 <= UInt<1>("h0")
      write mport MPORT_8 = btbTable[UInt<4>("h8")], clock
      MPORT_8 <= UInt<1>("h0")
      write mport MPORT_9 = btbTable[UInt<4>("h9")], clock
      MPORT_9 <= UInt<1>("h0")
      write mport MPORT_10 = btbTable[UInt<4>("ha")], clock
      MPORT_10 <= UInt<1>("h0")
      write mport MPORT_11 = btbTable[UInt<4>("hb")], clock
      MPORT_11 <= UInt<1>("h0")
      write mport MPORT_12 = btbTable[UInt<4>("hc")], clock
      MPORT_12 <= UInt<1>("h0")
      write mport MPORT_13 = btbTable[UInt<4>("hd")], clock
      MPORT_13 <= UInt<1>("h0")
      write mport MPORT_14 = btbTable[UInt<4>("he")], clock
      MPORT_14 <= UInt<1>("h0")
      write mport MPORT_15 = btbTable[UInt<4>("hf")], clock
      MPORT_15 <= UInt<1>("h0")
    node _btbEntry_T = bits(io.pc, 5, 2) @[dut.scala 24:32]
    infer mport btbEntry = btbTable[_btbEntry_T], clock @[dut.scala 24:26]
    node btbPredict = bits(btbEntry, 1, 1) @[dut.scala 27:28]
    node _T_1 = eq(io.branch, UInt<1>("h1")) @[dut.scala 30:18]
    when _T_1 : @[dut.scala 30:27]
      node _T_2 = eq(io.pcsrc, UInt<1>("h1")) @[dut.scala 31:19]
      when _T_2 : @[dut.scala 31:28]
        node _T_3 = bits(io.mem_pc, 5, 2) @[dut.scala 33:30]
        infer mport MPORT_16 = btbTable[_T_3], clock @[dut.scala 33:20]
        node _T_4 = lt(MPORT_16, UInt<2>("h3")) @[dut.scala 33:38]
        when _T_4 : @[dut.scala 33:45]
          node _T_5 = bits(io.mem_pc, 5, 2) @[dut.scala 34:33]
          node _T_6 = bits(io.mem_pc, 5, 2) @[dut.scala 34:59]
          infer mport MPORT_17 = btbTable[_T_6], clock @[dut.scala 34:49]
          node _T_7 = add(MPORT_17, UInt<1>("h1")) @[dut.scala 34:67]
          node _T_8 = tail(_T_7, 1) @[dut.scala 34:67]
          write mport MPORT_18 = btbTable[_T_5], clock
          MPORT_18 <= _T_8
      else :
        node _T_9 = bits(io.mem_pc, 5, 2) @[dut.scala 38:30]
        infer mport MPORT_19 = btbTable[_T_9], clock @[dut.scala 38:20]
        node _T_10 = gt(MPORT_19, UInt<1>("h0")) @[dut.scala 38:38]
        when _T_10 : @[dut.scala 38:45]
          node _T_11 = bits(io.mem_pc, 5, 2) @[dut.scala 39:33]
          node _T_12 = bits(io.mem_pc, 5, 2) @[dut.scala 39:59]
          infer mport MPORT_20 = btbTable[_T_12], clock @[dut.scala 39:49]
          node _T_13 = sub(MPORT_20, UInt<1>("h1")) @[dut.scala 39:67]
          node _T_14 = tail(_T_13, 1) @[dut.scala 39:67]
          write mport MPORT_21 = btbTable[_T_11], clock
          MPORT_21 <= _T_14
    io.btb_taken <= btbPredict @[dut.scala 44:16]

