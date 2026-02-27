circuit Fetch_golden :
  module BHT_golden :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip target_pc : UInt<32>, matched : UInt<1>, valid : UInt<1>, bht_pred_pc : UInt<32>}

    cmem bhtTable : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} [16] @[BHT.scala 24:21]
    node index = bits(io.pc, 5, 2) @[BHT.scala 26:20]
    read mport bhtEntry = bhtTable[index], clock @[BHT.scala 28:31]
    node _io_matched_T = bits(io.pc, 31, 6) @[BHT.scala 30:39]
    node _io_matched_T_1 = eq(bhtEntry.tag, _io_matched_T) @[BHT.scala 30:30]
    io.matched <= _io_matched_T_1 @[BHT.scala 30:14]
    io.valid <= bhtEntry.valid @[BHT.scala 31:12]
    io.bht_pred_pc <= bhtEntry.target_pc @[BHT.scala 32:18]
    node _T = eq(io.pcsrc, UInt<1>("h1")) @[BHT.scala 34:17]
    when _T : @[BHT.scala 34:26]
      wire newEntry : { tag : UInt<26>, valid : UInt<1>, target_pc : UInt<32>} @[BHT.scala 35:24]
      node _newEntry_tag_T = bits(io.mem_pc, 31, 6) @[BHT.scala 36:30]
      newEntry.tag <= _newEntry_tag_T @[BHT.scala 36:18]
      newEntry.valid <= UInt<1>("h1") @[BHT.scala 37:20]
      newEntry.target_pc <= io.target_pc @[BHT.scala 38:24]
      node _T_1 = bits(io.mem_pc, 5, 2) @[BHT.scala 39:29]
      write mport MPORT = bhtTable[_T_1], clock
      MPORT <= newEntry


  module BTB_golden :
    input clock : Clock
    input reset : Reset
    output io : { flip pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, btb_taken : UInt<1>}

    cmem btbTable : UInt<2> [16] @[BTB.scala 14:21]
    node _T = asUInt(reset) @[BTB.scala 17:15]
    when _T : @[BTB.scala 17:23]
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
    node _btbEntry_T = bits(io.pc, 5, 2) @[BTB.scala 24:32]
    infer mport btbEntry = btbTable[_btbEntry_T], clock @[BTB.scala 24:26]
    node btbPredict = bits(btbEntry, 1, 1) @[BTB.scala 27:28]
    node _T_1 = eq(io.branch, UInt<1>("h1")) @[BTB.scala 30:18]
    when _T_1 : @[BTB.scala 30:27]
      node _T_2 = eq(io.pcsrc, UInt<1>("h1")) @[BTB.scala 31:19]
      when _T_2 : @[BTB.scala 31:28]
        node _T_3 = bits(io.mem_pc, 5, 2) @[BTB.scala 33:30]
        infer mport MPORT_16 = btbTable[_T_3], clock @[BTB.scala 33:20]
        node _T_4 = lt(MPORT_16, UInt<2>("h3")) @[BTB.scala 33:38]
        when _T_4 : @[BTB.scala 33:45]
          node _T_5 = bits(io.mem_pc, 5, 2) @[BTB.scala 34:33]
          node _T_6 = bits(io.mem_pc, 5, 2) @[BTB.scala 34:59]
          infer mport MPORT_17 = btbTable[_T_6], clock @[BTB.scala 34:49]
          node _T_7 = add(MPORT_17, UInt<1>("h1")) @[BTB.scala 34:67]
          node _T_8 = tail(_T_7, 1) @[BTB.scala 34:67]
          write mport MPORT_18 = btbTable[_T_5], clock
          MPORT_18 <= _T_8
      else :
        node _T_9 = bits(io.mem_pc, 5, 2) @[BTB.scala 38:30]
        infer mport MPORT_19 = btbTable[_T_9], clock @[BTB.scala 38:20]
        node _T_10 = gt(MPORT_19, UInt<1>("h0")) @[BTB.scala 38:38]
        when _T_10 : @[BTB.scala 38:45]
          node _T_11 = bits(io.mem_pc, 5, 2) @[BTB.scala 39:33]
          node _T_12 = bits(io.mem_pc, 5, 2) @[BTB.scala 39:59]
          infer mport MPORT_20 = btbTable[_T_12], clock @[BTB.scala 39:49]
          node _T_13 = sub(MPORT_20, UInt<1>("h1")) @[BTB.scala 39:67]
          node _T_14 = tail(_T_13, 1) @[BTB.scala 39:67]
          write mport MPORT_21 = btbTable[_T_11], clock
          MPORT_21 <= _T_14
    io.btb_taken <= btbPredict @[BTB.scala 44:16]

  module Fetch_golden :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip trap_vector : UInt<32>, flip mret_vector : UInt<32>, flip target_pc : UInt<32>, flip mem_pc : UInt<32>, flip pcsrc : UInt<1>, flip branch : UInt<1>, flip trap : UInt<1>, flip mret : UInt<1>, flip pc_stall : UInt<1>, flip if_id_stall : UInt<1>, flip if_id_flush : UInt<1>, flip predict : UInt<1>, id_pc : UInt<32>, inst : UInt<32>, flip fetch_data : UInt<32>, fetch_address : UInt<32>}

    inst bht of BHT_golden @[Fetch.scala 32:19]
    bht.clock <= clock
    bht.reset <= reset
    inst btb of BTB_golden @[Fetch.scala 33:19]
    btb.clock <= clock
    btb.reset <= reset
    reg pcReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h8")) @[Fetch.scala 36:22]
    reg idPcReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetch.scala 37:24]
    reg instReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetch.scala 38:24]
    bht.io.pc <= pcReg @[Fetch.scala 41:13]
    bht.io.mem_pc <= io.mem_pc @[Fetch.scala 42:17]
    bht.io.pcsrc <= io.pcsrc @[Fetch.scala 43:16]
    bht.io.target_pc <= io.target_pc @[Fetch.scala 44:20]
    btb.io.pc <= pcReg @[Fetch.scala 46:13]
    btb.io.mem_pc <= io.mem_pc @[Fetch.scala 47:17]
    btb.io.pcsrc <= io.pcsrc @[Fetch.scala 48:16]
    btb.io.branch <= io.branch @[Fetch.scala 49:17]
    when io.trap : @[Fetch.scala 54:17]
      pcReg <= io.trap_vector @[Fetch.scala 55:11]
    else :
      when io.mret : @[Fetch.scala 56:23]
        pcReg <= io.mret_vector @[Fetch.scala 57:11]
      else :
        node _T = eq(io.predict, UInt<1>("h0")) @[Fetch.scala 58:26]
        node _T_1 = and(io.pcsrc, _T) @[Fetch.scala 58:23]
        when _T_1 : @[Fetch.scala 58:39]
          pcReg <= io.target_pc @[Fetch.scala 59:11]
        else :
          when io.pc_stall : @[Fetch.scala 60:27]
            pcReg <= pcReg @[Fetch.scala 61:11]
          else :
            node _T_2 = and(btb.io.btb_taken, bht.io.valid) @[Fetch.scala 62:32]
            node _T_3 = and(_T_2, bht.io.matched) @[Fetch.scala 62:47]
            node _T_4 = neq(_T_3, UInt<1>("h0")) @[Fetch.scala 62:65]
            when _T_4 : @[Fetch.scala 62:74]
              pcReg <= bht.io.bht_pred_pc @[Fetch.scala 63:11]
            else :
              node _pcReg_T = add(pcReg, UInt<3>("h4")) @[Fetch.scala 65:20]
              node _pcReg_T_1 = tail(_pcReg_T, 1) @[Fetch.scala 65:20]
              pcReg <= _pcReg_T_1 @[Fetch.scala 65:11]
    when io.if_id_stall : @[Fetch.scala 69:24]
      idPcReg <= idPcReg @[Fetch.scala 70:13]
      instReg <= instReg @[Fetch.scala 71:13]
    else :
      idPcReg <= pcReg @[Fetch.scala 73:13]
      instReg <= io.fetch_data @[Fetch.scala 74:13]
    when io.if_id_flush : @[Fetch.scala 77:24]
      idPcReg <= UInt<1>("h0") @[Fetch.scala 78:13]
      instReg <= UInt<5>("h13") @[Fetch.scala 79:13]
    io.fetch_address <= pcReg @[Fetch.scala 82:20]
    io.id_pc <= idPcReg @[Fetch.scala 83:12]
    io.inst <= instReg @[Fetch.scala 84:11]

