circuit dut :
  module BHT :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, matched : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}

    cmem bhtTable : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} [16] @[driver.scala 28:21]
    node index = bits(io.pc, 5, 2) @[driver.scala 31:20]
    read mport bhtEntry = bhtTable[index], clock @[driver.scala 33:31]
    node _io_matched_T = bits(io.pc, 31, 6) @[driver.scala 35:39]
    node _io_matched_T_1 = eq(bhtEntry.tag, _io_matched_T) @[driver.scala 35:30]
    io.matched <= _io_matched_T_1 @[driver.scala 35:14]
    io.valid <= bhtEntry.valid @[driver.scala 36:12]
    io.bht_pred_pc <= bhtEntry.target_pc @[driver.scala 37:18]
    node _T = eq(io.pcsrc, UInt<1>("h1")) @[driver.scala 39:17]
    when _T : @[driver.scala 39:26]
      wire newEntry : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} @[driver.scala 40:24]
      node _newEntry_tag_T = bits(io.mem_pc, 31, 6) @[driver.scala 41:30]
      newEntry.tag <= _newEntry_tag_T @[driver.scala 41:18]
      newEntry.valid <= UInt<1>("h1") @[driver.scala 42:20]
      newEntry.target_pc <= io.target_pc @[driver.scala 43:24]
      node _T_1 = bits(io.mem_pc, 5, 2) @[driver.scala 44:29]
      write mport MPORT = bhtTable[_T_1], clock
      MPORT <= newEntry


  module BTB :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    cmem btbTable : UInt<2> [16] @[driver.scala 58:21]
    node _T = asUInt(reset) @[driver.scala 61:15]
    when _T : @[driver.scala 61:23]
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
    node _btbEntry_T = bits(io.pc, 5, 2) @[driver.scala 68:32]
    infer mport btbEntry = btbTable[_btbEntry_T], clock @[driver.scala 68:26]
    node btbPredict = bits(btbEntry, 1, 1) @[driver.scala 71:28]
    node _T_1 = eq(io.branch, UInt<1>("h1")) @[driver.scala 74:18]
    when _T_1 : @[driver.scala 74:27]
      node _T_2 = eq(io.pcsrc, UInt<1>("h1")) @[driver.scala 75:19]
      when _T_2 : @[driver.scala 75:28]
        node _T_3 = bits(io.mem_pc, 5, 2) @[driver.scala 77:30]
        infer mport MPORT_16 = btbTable[_T_3], clock @[driver.scala 77:20]
        node _T_4 = lt(MPORT_16, UInt<2>("h3")) @[driver.scala 77:38]
        when _T_4 : @[driver.scala 77:45]
          node _T_5 = bits(io.mem_pc, 5, 2) @[driver.scala 78:33]
          node _T_6 = bits(io.mem_pc, 5, 2) @[driver.scala 78:59]
          infer mport MPORT_17 = btbTable[_T_6], clock @[driver.scala 78:49]
          node _T_7 = add(MPORT_17, UInt<1>("h1")) @[driver.scala 78:67]
          node _T_8 = tail(_T_7, 1) @[driver.scala 78:67]
          write mport MPORT_18 = btbTable[_T_5], clock
          MPORT_18 <= _T_8
      else :
        node _T_9 = bits(io.mem_pc, 5, 2) @[driver.scala 82:30]
        infer mport MPORT_19 = btbTable[_T_9], clock @[driver.scala 82:20]
        node _T_10 = gt(MPORT_19, UInt<1>("h0")) @[driver.scala 82:38]
        when _T_10 : @[driver.scala 82:45]
          node _T_11 = bits(io.mem_pc, 5, 2) @[driver.scala 83:33]
          node _T_12 = bits(io.mem_pc, 5, 2) @[driver.scala 83:59]
          infer mport MPORT_20 = btbTable[_T_12], clock @[driver.scala 83:49]
          node _T_13 = sub(MPORT_20, UInt<1>("h1")) @[driver.scala 83:67]
          node _T_14 = tail(_T_13, 1) @[driver.scala 83:67]
          write mport MPORT_21 = btbTable[_T_11], clock
          MPORT_21 <= _T_14
    io.btb_taken <= btbPredict @[driver.scala 88:16]

  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip trap_vector : UInt<32>, flip mert_vector : UInt<32>, flip target_pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, flip trap : UInt<1>, flip mert : UInt<1>, flip pc_stall : UInt<1>, flip if_id_stall : UInt<1>, flip if_id_flush : UInt<1>, id_pc : UInt<32>, inst : UInt<32>, flip fetch_data : UInt<32>, fetch_address : UInt<32>}
    output io_bht : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, matched : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}
    output io_btb : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    reg pc_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h80000000")) @[dut.scala 58:23]
    reg id_pc_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 61:26]
    reg inst_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[dut.scala 62:25]
    wire next_pc : UInt<32> @[dut.scala 67:21]
    node _next_pc_T = add(pc_reg, UInt<3>("h4")) @[dut.scala 68:29]
    node _next_pc_T_1 = tail(_next_pc_T, 1) @[dut.scala 68:29]
    node _next_pc_T_2 = bits(reset, 0, 0) @[dut.scala 69:12]
    node _next_pc_T_3 = bits(io_bht.matched, 0, 0) @[dut.scala 73:22]
    node _next_pc_T_4 = bits(io_bht.valid, 0, 0) @[dut.scala 73:45]
    node _next_pc_T_5 = and(_next_pc_T_3, _next_pc_T_4) @[dut.scala 73:29]
    node _next_pc_T_6 = bits(io_btb.btb_taken, 0, 0) @[dut.scala 74:22]
    node _next_pc_T_7 = and(_next_pc_T_5, _next_pc_T_6) @[dut.scala 73:53]
    node _next_pc_T_8 = mux(_next_pc_T_7, io_bht.bht_pred_pc, _next_pc_T_1) @[Mux.scala 101:16]
    node _next_pc_T_9 = mux(io.pcsrc, io.target_pc, _next_pc_T_8) @[Mux.scala 101:16]
    node _next_pc_T_10 = mux(io.mert, io.mert_vector, _next_pc_T_9) @[Mux.scala 101:16]
    node _next_pc_T_11 = mux(io.trap, io.trap_vector, _next_pc_T_10) @[Mux.scala 101:16]
    node _next_pc_T_12 = mux(_next_pc_T_2, UInt<32>("h80000000"), _next_pc_T_11) @[Mux.scala 101:16]
    next_pc <= _next_pc_T_12 @[dut.scala 68:11]
    node _T = bits(reset, 0, 0) @[dut.scala 78:14]
    when _T : @[dut.scala 78:22]
      pc_reg <= UInt<32>("h80000000") @[dut.scala 79:12]
    else :
      node _T_1 = eq(io.pc_stall, UInt<1>("h0")) @[dut.scala 80:14]
      when _T_1 : @[dut.scala 80:28]
        pc_reg <= next_pc @[dut.scala 81:12]
    inst bht of BHT @[dut.scala 87:19]
    bht.clock <= clock
    bht.reset <= reset
    bht.io.pc <= pc_reg @[dut.scala 88:13]
    bht.io.mem_pc <= io.mem_pc @[dut.scala 89:17]
    bht.io.pcsrc <= io.pcsrc @[dut.scala 90:16]
    bht.io.target_pc <= io.target_pc @[dut.scala 91:20]
    io_bht.matched <= bht.io.matched @[dut.scala 94:18]
    io_bht.valid <= bht.io.valid @[dut.scala 95:16]
    io_bht.bht_pred_pc <= bht.io.bht_pred_pc @[dut.scala 96:22]
    inst btb of BTB @[dut.scala 101:19]
    btb.clock <= clock
    btb.reset <= reset
    btb.io.pc <= pc_reg @[dut.scala 102:13]
    btb.io.mem_pc <= io.mem_pc @[dut.scala 103:17]
    btb.io.pcsrc <= io.pcsrc @[dut.scala 104:16]
    btb.io.branch <= io.branch @[dut.scala 105:17]
    io_btb.btb_taken <= btb.io.btb_taken @[dut.scala 108:20]
    node _T_2 = bits(reset, 0, 0) @[dut.scala 113:14]
    when _T_2 : @[dut.scala 113:22]
      id_pc_reg <= UInt<1>("h0") @[dut.scala 114:15]
      inst_reg <= UInt<1>("h0") @[dut.scala 115:14]
    else :
      when io.if_id_flush : @[dut.scala 116:30]
        id_pc_reg <= pc_reg @[dut.scala 118:15]
        inst_reg <= UInt<1>("h0") @[dut.scala 119:14]
      else :
        node _T_3 = eq(io.if_id_stall, UInt<1>("h0")) @[dut.scala 120:14]
        when _T_3 : @[dut.scala 120:31]
          id_pc_reg <= pc_reg @[dut.scala 122:15]
          inst_reg <= io.fetch_data @[dut.scala 123:14]
    io.fetch_address <= pc_reg @[dut.scala 129:20]
    io.id_pc <= id_pc_reg @[dut.scala 130:12]
    io.inst <= inst_reg @[dut.scala 131:11]

